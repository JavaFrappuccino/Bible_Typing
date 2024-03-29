package com.bible.bible_typing;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
public class BibleTypingApplication {

	public static void main(String[] args) {
		SpringApplication.run(BibleTypingApplication.class, args);
	}

}
