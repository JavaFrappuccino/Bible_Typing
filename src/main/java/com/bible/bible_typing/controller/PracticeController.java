package com.bible.bible_typing.controller;

import com.bible.bible_typing.dto.BibleDto;
import com.bible.bible_typing.dto.UserInfoDto;
import com.bible.bible_typing.dto.request.LongPracticeRequest;
import com.bible.bible_typing.dto.request.SaveLongRequest;
import com.bible.bible_typing.dto.request.SaveShortRequest;
import com.bible.bible_typing.dto.response.ApiResponse;
import com.bible.bible_typing.dto.response.LongPracticeResponse;
import com.bible.bible_typing.dto.response.ShortPracticeResponse;
import com.bible.bible_typing.service.PracticeService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/verses")
public class PracticeController {

    private final PracticeService practiceService;

    // 단문 연습 데이터 호출
    @GetMapping("/short-practice")
    public ApiResponse<List<ShortPracticeResponse>> getShortPractice() {
        List<ShortPracticeResponse> practiceList = practiceService.getShortPractice();
        return ApiResponse.success(practiceList);
    }

    // 단문 연습 후 데이터 저장
    @PostMapping("/short-records")
    public ResponseEntity<String> saveShortPracticeHistory(HttpSession session, @RequestBody SaveShortRequest saveShortRequest) {
        UserInfoDto loginUser = (UserInfoDto) session.getAttribute("loggedInUser");
        if (loginUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }
        practiceService.saveShortPracticeHistory(saveShortRequest, loginUser.getUserIdx());
        return ResponseEntity.ok().body("단문 연습 데이터 저장 완료");
    }

    // 장문 연습 데이터 호출
    @GetMapping("/long-practice")
    public ResponseEntity<LongPracticeResponse> getLongPractice(LongPracticeRequest longPracticeRequest) {
        return ResponseEntity.ok(practiceService.getLongPractice(longPracticeRequest));
    }

    // 장문 연습 후 데이터 저장
    @PostMapping("/long-records")
    public ResponseEntity<ApiResponse<SaveLongRequest>> saveLongPracticeHistory(HttpSession session, @RequestBody SaveLongRequest saveLongRequest) {
        UserInfoDto loginUser = (UserInfoDto) session.getAttribute("loggedInUser");
        if (loginUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ApiResponse.fail("로그인이 필요합니다."));
        }
        practiceService.saveLongPracticeHistory(saveLongRequest, loginUser.getUserIdx());
        return ResponseEntity.ok().body(ApiResponse.success(saveLongRequest));
    }
}
