package com.bible.bible_typing.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
public class BibleDto {

    // json 성경 데이터 DB 마이그레이션 시 사용
    @Data
    public static class BibleVerseDto {
        private Long bookId;
        private int chapter;
        private int verse;
        private String content;
        private String verseKey;
    }

    // json 성경 데이터 DB 마이그레이션 시 사용 / 서버 시작 시 전체 권수 콘솔에 출력
    @Data
    public static class BibleInfoDto {
        private Long id;
        private String bookCodeKo;
        private String bookCodeEn;
        private String bookNameKo;
        private String bookNameEn;
        private String testament;
        private int bookOrder;
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

    // 단문 연습 후 데이터 저장
    @Builder
    @AllArgsConstructor
    @Data
    public static class BibleShortSaveDto {
        private int speedIdx;
        private int userIdx;
        private String practiceType;
        private String book_code_ko;
        private String book_code_en;
        private String title;
        private int chapter;
        private int speed;
        private String testament;
        private int accuracy;
        private int duration;
    }
}