package com.bible.bible_typing.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
public class BibleDto {

    // json 성경 데이터 DB 마이그레이션 시 사용
    // 장문 연습 데이터 호출
    @Data
    public static class BibleVerseDto {
        private Long bookId;
        private int chapter;
        private int verse;
        private String content;
        private String verseKey;
    }

    // json 성경 데이터 DB 마이그레이션 시 사용 / 서버 시작 시 전체 권수 콘솔에 출력
    // 장문 연습 데이터 호출
    @Data
    public static class BibleInfoDto {
        private Long id;
        private String bookCodeKo;
        private String bookCodeEn;
        private String bookNameKo;
        private String bookNameEn;
        private String testament;
        private int bookOrder;

        // 장문 데이터 호출 시 계층형 구조로 사용 (1:N)
        private List<BibleVerseDto> verses;
    }

    // 단문 연습용 20개 데이터 호출
    @Data
    public static class BibleShortPracticeDto {
        private int rowNum;
        private String bookNameKo;
        private String bookCodeKo;
        private int chapter;
        private int verse;
        private String content;
    }

    // 단문/장문 연습 후 데이터 저장
    @Builder
    @AllArgsConstructor
    @Data
    public static class BibleSaveDto {
        private int userIdx;
        private String practiceType;
        private String bookCodeKo;
        private String bookCodeEn;
        private String title;
        private int chapter;
        private int speed;
        private String testament;
        private int accuracy;
        private int duration;
    }


}