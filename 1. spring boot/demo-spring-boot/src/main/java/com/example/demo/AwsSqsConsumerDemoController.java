package com.example.demo;

import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import com.amazonaws.services.sqs.model.Message;
import com.amazonaws.services.sqs.model.ReceiveMessageRequest;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/aws/sqs/consumer")
public class AwsSqsConsumerDemoController {

    @GetMapping("/receive")
    public String receive(){

        StringBuilder sb = new StringBuilder();

        // Cria um cliente SQS
        AmazonSQS sqs = AmazonSQSClientBuilder.defaultClient();

        // Cria uma requisição para receber mensagens da fila
        ReceiveMessageRequest receiveMessageRequest = new ReceiveMessageRequest()
                .withQueueUrl("terraform-queue")
                .withWaitTimeSeconds(20)
                .withMaxNumberOfMessages(10);

        // Recebe as mensagens da fila
        for (Message message : sqs.receiveMessage(receiveMessageRequest).getMessages()) {
            // Processa a mensagem recebida
            sb.append("Mensagem recebida da fila: " + message.getBody()).append("\n");
            // Exclui a mensagem da fila
            sqs.deleteMessage("terraform-queue", message.getReceiptHandle());
            sb.append("Mensagem excluída da fila: " + message.getBody()).append("\n");
        }

        return sb.toString();
    }
}
