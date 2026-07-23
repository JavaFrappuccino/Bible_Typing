package com.bible.bible_typing.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShortPracticeResponse {

    private int rowNum;
    private String bookNameKo;
    private String bookCodeKo;
    private int chapter;
    private int verse;
    private String content;
}
