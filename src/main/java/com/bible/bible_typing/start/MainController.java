package com.bible.bible_typing.start;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bible.bible_typing.dto.UserInfoDto;


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
	
	@RequestMapping(value = "/loginAction")
	public String loginAction(Model model, UserInfoDto userInfoDto) {
		
		if(userInfoDto == null) {
			
		} else {
			String userId = userInfoDto.getUserId();
			
			model.addAttribute("userId", userId);
		}
		
		return "main/main";
	}
}
