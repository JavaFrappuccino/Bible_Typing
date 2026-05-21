package com.bible.bible_typing.dto.request;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LongPracticeRequest {
    private String bookCodeKo;
    private String bookCodeEn;
    private int chapter;
    private int verse;
}
