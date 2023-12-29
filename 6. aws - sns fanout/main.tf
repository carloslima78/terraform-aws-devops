# Definindo o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Criando um tópico SNS
resource "aws_sns_topic" "pagamento_efetuado" {
  name = "pagamento-efetuado"
}

# Criando a fila SQS para pagamento pix
resource "aws_sqs_queue" "pagamento_pix" {
  name = "pagamento-pix"
}

# Criando a fila SQS para pagamento boleto
resource "aws_sqs_queue" "pagamento_boleto" {
  name = "pagamento-boleto"
}

# Criando a fila SQS para pagamento contábil
resource "aws_sqs_queue" "pagamento_contabil" {
  name = "pagamento-contabil"
}

# Adicionando permissões para o tópico SNS escrever na fila
resource "aws_sqs_queue_policy" "permissao_pagamento_pix" {
  queue_url = aws_sqs_queue.pagamento_pix.id
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": [
        "sqs:SendMessage"
      ],
      "Resource": [
        "${aws_sqs_queue.pagamento_pix.arn}"
      ],
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.pagamento_efetuado.arn}"
        }
      }
    }
  ]
}
EOF
}

# Adicionando permissões para o tópico SNS escrever na fila
resource "aws_sqs_queue_policy" "permissao_pagamento_boleto" {
  queue_url = aws_sqs_queue.pagamento_boleto.id
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": [
        "sqs:SendMessage"
      ],
      "Resource": [
        "${aws_sqs_queue.pagamento_boleto.arn}"
      ],
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.pagamento_efetuado.arn}"
        }
      }
    }
  ]
}
EOF
}

# Adicionando permissões para o tópico SNS escrever na fila
resource "aws_sqs_queue_policy" "permissao_pagamento_contabil" {
  queue_url = aws_sqs_queue.pagamento_contabil.id
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": [
        "sqs:SendMessage"
      ],
      "Resource": [
        "${aws_sqs_queue.pagamento_contabil.arn}"
      ],
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.pagamento_efetuado.arn}"
        }
      }
    }
  ]
}
EOF
}

# Criando a assinatura da fila "pagamento-pix" no tópico "pagamento-efetuado" com filtro
resource "aws_sns_topic_subscription" "assinatura_pix" {
  topic_arn = aws_sns_topic.pagamento_efetuado.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.pagamento_pix.arn

  filter_policy = <<EOF
{
  "tipo": ["pix"]
}
EOF
}

# Criando a assinatura da fila "pagamento-boleto" no tópico "pagamento-efetuado" com filtro
resource "aws_sns_topic_subscription" "assinatura_boleto" {
  topic_arn = aws_sns_topic.pagamento_efetuado.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.pagamento_boleto.arn

  filter_policy = <<EOF
{
  "tipo": ["boleto"]
}
EOF
}

# Criando a assinatura da fila "pagamento-contabil" no tópico "pagamento-efetuado" sem filtro
resource "aws_sns_topic_subscription" "assinatura_contabil" {
  topic_arn = aws_sns_topic.pagamento_efetuado.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.pagamento_contabil.arn
}

# Output para imprimir o nome do tópico
output "topic_name" {
  value = aws_sns_topic.pagamento_efetuado.name
}

# Output para imprimir o nome da fila pagamento pix
output "queue_name_pix" {
  value = aws_sqs_queue.pagamento_pix.name
}

# Output para imprimir o nome da fila pagamento boleto
output "queue_name_boleto" {
  value = aws_sqs_queue.pagamento_boleto.name
}

# Output para imprimir o nome da fila pagamento contabil
output "queue_name_contabil" {
  value = aws_sqs_queue.pagamento_contabil.name
}
