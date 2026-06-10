package com.bible.bible_typing.dto.request;

import lombok.Data;

@Data
public class SaveShortRequest {

    private String practiceType;
    private int speed;
    private int accuracy;
    private int duration;

}
