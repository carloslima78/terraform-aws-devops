package com.example.demo;

import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import com.amazonaws.services.sqs.model.SendMessageRequest;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/aws/sqs/producer")
public class AwsSqsProducerDemoController {

    // Dependência Maven spring-cloud-aws-messaging
    @PostMapping("/send")
    public void send(@RequestParam String mensagem){

        // Cria um cliente SQS
        AmazonSQS sqs = AmazonSQSClientBuilder.defaultClient();

        // Cria uma requisição para enviar a mensagem para a fila
        SendMessageRequest sendMessageRequest = new SendMessageRequest()
                .withQueueUrl("terraform-queue")
                .withMessageBody(mensagem);

        // Envia a mensagem para a fila
        sqs.sendMessage(sendMessageRequest);
    }
}
