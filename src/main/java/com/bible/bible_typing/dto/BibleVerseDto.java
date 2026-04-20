package com.bible.bible_typing.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class BibleVerseDto {
	
    private Long bookId;
    private int chapter;
    private int verse;
    private String content;
    private String verseKey;
    
}
