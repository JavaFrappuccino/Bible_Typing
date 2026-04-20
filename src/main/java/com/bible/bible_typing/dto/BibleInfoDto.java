package com.bible.bible_typing.dto;

import lombok.Data;

@Data
public class BibleInfoDto {
    private Long id;
    private String bookCodeKo;
    private String bookCodeEn;
    private String bookNameKo;
    private String bookNameEn;
    private String testament;
    private int bookOrder;
}
