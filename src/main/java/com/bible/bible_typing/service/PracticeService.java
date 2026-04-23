package com.bible.bible_typing.service;

import com.bible.bible_typing.dto.BibleDto;
import com.bible.bible_typing.dto.response.ShortPracticeResponse;
import com.bible.bible_typing.mapper.BibleMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PracticeService {

    private final BibleMapper bibleMapper;

    public List<ShortPracticeResponse> getShortPractice() {

        List<BibleDto.BibleShortPracticeDto> shortPracticeList = bibleMapper.getShortPractice();

        return shortPracticeList.stream().map(data ->
                ShortPracticeResponse.builder()
                        .rowNum(data.getRowNum())
                        .bookNameKo(data.getBookNameKo())
                        .bookCodeKo(data.getBookCodeKo())
                        .verse(data.getVerse())
                        .chapter(data.getChapter())
                        .content(data.getContent())
                        .build()
        ).toList();
    }
}
