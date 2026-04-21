package com.bible.bible_typing.controller;

import com.bible.bible_typing.dto.BibleDto;
import com.bible.bible_typing.mapper.BibleMapper;
import com.bible.bible_typing.service.PracticeService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/verses")
public class PracticeController {

    private final PracticeService practiceService;

    @GetMapping("/short-practice")
    public List<BibleDto.BibleShortPracticeDto> getShortPractice() {
        return practiceService.getShortPractice();
    }

}
