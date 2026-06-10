package com.bible.bible_typing.dto.response;

import lombok.*;

import java.util.List;

@Data
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor
public class LongPracticeResponse {
    private String bookNameKo;
    private String bookNameEn;
    private String testament;
    private int chapter;

    private List<VerseDetail> verseList;

    @Data
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class VerseDetail {
        private int verse;
        private String content;
    }

}
