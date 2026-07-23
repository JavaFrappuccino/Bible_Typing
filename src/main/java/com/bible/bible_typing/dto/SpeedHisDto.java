package com.bible.bible_typing.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SpeedHisDto {

    private int speedIdx;
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
    private String useYn;
    private int insIdx;
    private LocalDateTime insDate;
    private int uptIdx;
    private LocalDateTime uptDate;
}
