package com.bible.bible_typing.controller;

import com.bible.bible_typing.dto.BibleDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/practice")
public class practiceCotroller {

    public List<BibleDto.ShortPracticeDto> selectShortPractice() {
        
        return null;
    }

}
