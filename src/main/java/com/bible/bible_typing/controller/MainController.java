package com.bible.bible_typing.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	@RequestMapping(value = "/")
	public String main() {
		
		return "index";
	}
	
	@RequestMapping(value = "/join")
	public String joinPage() {
		return "join";
	}
	
	@RequestMapping(value = "/mainPage")
	public String mainPage() {
		
		// 로그인 로직 
		
		
		
		return "/mainPage";
	}
	
	@RequestMapping(value = "/shortPractice")
	public String shortPractice() {
		return "/shortPractice";
	}
	
	@RequestMapping(value = "/longPractice")
	public String longPractice() {
		return "/longPractice";
	}
}
