package com.demo.s3;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoS3Application {

	public static void main(String[] args)
	{
		SpringApplication.run(DemoS3Application.class, args);
		test();
	}

	public static void test(){

		System.out.println("Deus é grande");
	}
}
