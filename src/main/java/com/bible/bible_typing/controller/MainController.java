package com.bible.bible_typing.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/")
public class MainController {

	@GetMapping("/")
	public String index() {
		return "redirect:/login"; // 주소를 /login으로 강제 이동
	}

	@GetMapping("/login")
	public String loginPage() {
		return "index";
	}

	@GetMapping(value = "/signUp")
	public String signUp() {
		return "signUp";
	}

	// 메인 페이지를 보여주는 메서드
	@GetMapping("/mainPage")
	public String mainPage(HttpSession session) {
		// 세션에 사용자 정보가 없으면 로그인 페이지로 리다이렉트 (선택 사항, 보안 강화)
		if (session.getAttribute("loggedInUser") == null) {
			return "redirect:/";
		}
		return "mainPage"; // "mainPage.jsp" 파일을 렌더링
	}

	// 로그아웃 처리 메서드
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate(); // 세션 무효화
		return "redirect:/"; // 로그인 페이지로 리다이렉트
	}

	// 단문 연습 페이지를 보여주는 메서드
	@GetMapping("/shortPractice")
	public String shortPracticePage(HttpSession session) {
		if (session.getAttribute("loggedInUser") == null) {
			return "redirect:/";
		}
		return "shortPractice";
	}
	
	@GetMapping(value = "/longPractice")
	public String longPractice(HttpSession session) {
		if (session.getAttribute("loggedInUser") == null) {
			return "redirect:/";
		}
		return "longPractice";
	}
}
