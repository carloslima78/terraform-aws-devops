package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

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
