package com.bible.bible_typing.controller;

import com.bible.bible_typing.dto.UserInfoDto;
import com.bible.bible_typing.service.UserService;
import jakarta.servlet.http.HttpSession; // HttpSession 임포트 추가
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/user")
public class UserController {

    private final UserService userService;

    // 아이디 중복 확인을 처리하는 메서드
    @PostMapping("/checkId")
    @ResponseBody // JSON 응답을 위해 필요
    public ResponseEntity<Map<String, Boolean>> checkId(@RequestBody Map<String, String> request) {
        String userId = request.get("user_id");
        boolean isDuplicate = userService.isUserIdDuplicate(userId);
        return ResponseEntity.ok(Map.of("isDuplicate", isDuplicate));
    }

    // 회원가입 폼 제출을 처리하는 메서드 (JSON 요청 처리)
    @PostMapping("/signUpProc")
    @ResponseBody // JSON 응답을 위해 필요
    public ResponseEntity<Map<String, Object>> signUpProcess(@RequestBody UserInfoDto userInfoDto) {
        userService.signUp(userInfoDto); // try-catch 제거, 예외 발생 시 밖으로 던짐
        return ResponseEntity.ok(Map.of("success", true, "message", "회원가입이 성공적으로 완료되었습니다."));
    }

    // 로그인 폼 제출을 처리하는 메서드
    @PostMapping("/loginProc") // index.jsp의 form action과 일치
    public String loginProcess(@RequestParam("username") String userId,
                               @RequestParam("password") String password,
                               HttpSession session, // HttpSession 추가
                               RedirectAttributes redirectAttributes) {
        UserInfoDto userInfo = userService.login(userId, password);

        if (userInfo != null) {
            // 로그인 성공 시, 사용자 정보를 세션에 저장
            session.setAttribute("loggedInUser", userInfo);
            return "redirect:/mainPage"; // 메인 페이지로 리다이렉트
        } else {
            // 로그인 실패 시, 로그인 페이지로 돌아가면서 에러 메시지 전달
            redirectAttributes.addFlashAttribute("loginError", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "redirect:/"; // index.jsp (로그인 페이지)
        }
    }

    // IllegalArgumentException 예외 처리 핸들러
    @ExceptionHandler(IllegalArgumentException.class)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> handleIllegalArgumentException(IllegalArgumentException e) {
        return ResponseEntity.status(HttpStatus.CONFLICT) // 409 Conflict
                .body(Map.of("success", false, "message", e.getMessage()));
    }

    // 기타 모든 예외 처리 핸들러
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> handleGenericException(Exception e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR) // 500 Internal Server Error
                .body(Map.of("success", false, "message", "처리 중 알 수 없는 오류가 발생했습니다."));
    }
}
