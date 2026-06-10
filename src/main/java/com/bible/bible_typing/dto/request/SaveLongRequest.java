package com.bible.bible_typing.dto.request;

import lombok.Data;

@Data
public class SaveLongRequest {

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
