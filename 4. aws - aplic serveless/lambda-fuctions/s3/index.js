
// Função para integração com a S3 e SNS

'use strict'

// SDK da AWS para os clients
const AWS = require('aws-sdk')

// Pacote "Joi" para validação do Schema 
const Joi = require('joi')

// Client S3
const S3 = new AWS.S3()

// Client SNS
const SNS = new AWS.SNS()

// Corresponde as colunas da tabela DynamoDB
const schema = Joi.object().keys({
    TodoId: Joi.string().required(),
    Task: Joi.string().required(),
    Done: Joi.string()
})

// Função que recupera o conteúdo do arquivo no Bucket S3
const getFileContent = async (S3, bucket, filename) => {
    const params = {
        Bucket: bucket,
        Key: filename
    }

    const file = await S3.getObject(params).promise()
    return JSON.parse(file.Body.toString('ascii'))
}

// Função que verifica se o item é válido utilizando o Schema
const isItemValid = (data) => {
    const isValid = schema.validate(data)
    return isValid.error === undefined
}

// Função que publica uma nova mensagem no tópico SNS
const publish = async (SNS, payload) => {
    const { message, subject, topic } = payload
    const params = {
        Message: message,
        Subject: subject,
        TopicArn: topic
    }

    try {
        await SNS.publish(params).promise()
        console.log(`Message published: ${message}`)
        return true
    } catch (error) {
        console.error(error)
        return false
    }
}

exports.handler = async (event) => {
    
    // Se o debug estíver habilitado, vai logar o evento.
    if (process.env.DEBUG) {
        console.log(`Received event: ${JSON.stringify(event)}`)
    }

    // Verifica se existe um tópico definido e atribui seu ARN para a constante
    const topicArn = event.topicArn || process.env.TOPIC_ARN
    if (!topicArn) {
        throw new Error('No topic defined.')
    }

    // Lê o conteúdo do arquivo 
    const { s3 } = event.Records[0]
    const content = await getFileContent(S3, s3.bucket.name, s3.object.key)
    let count = 0

    // Percorre os itens do arquivo
    for (let item of content) {

        // Verifica se cada item no arquivo é válido, retorna falso e loga um erro
        if (!isItemValid(item)) {
            console.log(`Invalid item found: ${JSON.stringify(item)}`)
            return false
        }

        // Realiza a publicação do item no tópico SNS
        await publish(SNS, {
            message: JSON.stringify(item),
            subject: 'Data from S3',
            topic: topicArn
        })

        count++
    }

    // Retorna quantas mensagens foram publicadas pela Lambda
    return `Published ${count} messages to the Topic.`
}