package com.bible.bible_typing.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ApiResponse<T> {

    private boolean success; // 성공 여부 (true/false)
    private String message;  // 응답 메세지
    private T data;          // 실제 데이터

    // 성공 응답을 만드는 정적 메서드
    public static <T> ApiResponse<T> success(T data) {
        return new ApiResponse<>(true, "요청이 성공적으로 처리되었습니다.", data);
    }

    // 메시지까지 직접 지정하는 성공 응답
    public static <T> ApiResponse<T> success(String message, T data) {
        return new ApiResponse<>(true, message, data);
    }

    // 실패 응답을 만드는 정적 메서드
    public static <T> ApiResponse<T> fail(String message) {
        return new ApiResponse<>(false, message, null);
    }

}
