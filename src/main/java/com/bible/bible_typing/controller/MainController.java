package com.bible.bible_typing.controller;

import com.bible.bible_typing.dto.SpeedHisDto;
import com.bible.bible_typing.dto.UserInfoDto;
import com.bible.bible_typing.dto.response.SpeedHisDashboardResponse;
import com.bible.bible_typing.service.SpeedHisService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/")
public class MainController {

	private final SpeedHisService speedHisService;

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
	public String mainPage(HttpSession session, Model model) {
		// 세션에 사용자 정보가 없으면 로그인 페이지로 리다이렉트 (선택 사항, 보안 강화)
		if (session.getAttribute("loggedInUser") == null) {
			return "redirect:/";
		}

		UserInfoDto user =  (UserInfoDto) session.getAttribute("loggedInUser");
		model.addAttribute("user", user);

		SpeedHisDashboardResponse speedHisDashboardResponse = speedHisService.getSpeedHisDashboardDto(user.getUserIdx());
		model.addAttribute("history", speedHisDashboardResponse);

		return "mainPage";
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

	// 장문 연습 페이지를 보여주는 메서드
	@GetMapping(value = "/longPractice")
	public String longPractice(HttpSession session) {
		if (session.getAttribute("loggedInUser") == null) {
			return "redirect:/";
		}
		return "longPractice";
	}
}
