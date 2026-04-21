package com.bible.bible_typing.controller;

import java.util.HashMap;
import java.util.Map;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bible.bible_typing.service.BibleMigrationService;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class MigrationController {

    private final BibleMigrationService migrationService;

    @GetMapping("/migrate")
    public Map<String, Object> migrate() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 기존에 만들었던 void 메서드 그대로 호출 (수정할 필요 없음)
            migrationService.migrate(); 
            
            // 성공 시 보낼 데이터 구성
            response.put("status", "success");
            response.put("message", "데이터 마이그레이션이 성공적으로 완료되었습니다.");
            
        } catch (Exception e) {
            // 실패 시 에러 정보 구성
            response.put("status", "error");
            response.put("message", "작업 중 오류 발생: " + e.getMessage());
            e.printStackTrace(); 
        }
        
        return response; // 이제 브라우저에 JSON 텍스트가 뜹니다.
    }
}