package com.example.demo;

import com.amazonaws.services.pinpoint.model.MessageResult;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import com.amazonaws.services.sqs.model.Message;
import com.amazonaws.services.sqs.model.ReceiveMessageRequest;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.aws.messaging.listener.annotation.SqsListener;
import org.springframework.messaging.handler.annotation.Payload;

@SpringBootApplication
public class AwsDemoApplication {

	public static void main(String[] args)
	{
		SpringApplication.run(AwsDemoApplication.class, args);
		test();
	}

	public static void test(){

		System.out.println("Deus é grande");


	}

}
