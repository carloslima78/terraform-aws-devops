package com.demo.s3;

import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.auth.DefaultAWSCredentialsProviderChain;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.sqs.AmazonSQSAsyncClientBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.aws.messaging.core.QueueMessagingTemplate;
import com.amazonaws.services.sqs.AmazonSQSAsync;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AwsConfig {

    @Value("${aws.access_key_id}")
    private String accessKey;

    @Value("${aws.secret_access_key_id}")
    private String secretKey;

    @Value("${aws.s3.region}")
    private String region;

    @Bean
    public AmazonS3 amazonS3(){
        final BasicAWSCredentials credentials = new BasicAWSCredentials(this.accessKey, this.secretKey);
        return AmazonS3ClientBuilder
                .standard()
                .withRegion(Regions.fromName(this.region))
                .withCredentials( new AWSStaticCredentialsProvider( credentials))
                .build();
    }
}
