package com.bible.bible_typing.service;

import com.bible.bible_typing.dto.BibleDto;
import com.bible.bible_typing.mapper.BibleMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PracticeService {

    private final BibleMapper bibleMapper;

    public List<BibleDto.BibleShortPracticeDto> getShortPractice() {
        return bibleMapper.getShortPractice();
    }
}
