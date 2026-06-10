package com.bible.bible_typing.service;

import com.bible.bible_typing.dto.BibleDto;
import com.bible.bible_typing.dto.request.LongPracticeRequest;
import com.bible.bible_typing.dto.request.SaveLongRequest;
import com.bible.bible_typing.dto.request.SaveShortRequest;
import com.bible.bible_typing.dto.response.LongPracticeResponse;
import com.bible.bible_typing.dto.response.ShortPracticeResponse;
import com.bible.bible_typing.mapper.BibleMapper;
import com.bible.bible_typing.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PracticeService {

    private final BibleMapper bibleMapper;
    private final UserMapper userMapper;

    // 단문 연습용 20개 데이터 호출
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
    // 단문 연습 후 데이터 저장
    @Transactional
    public void saveShortPracticeHistory(SaveShortRequest saveShortRequest, int userIdx, String userId) {
        BibleDto.BibleSaveDto bibleSaveDto = BibleDto.BibleSaveDto.builder()
                .userIdx(userIdx)
                .practiceType(saveShortRequest.getPracticeType())
                .speed(saveShortRequest.getSpeed())
                .accuracy(saveShortRequest.getAccuracy())
                .duration(saveShortRequest.getDuration())
                .build();
        bibleMapper.saveShortPracticeHistory(bibleSaveDto);

        // 최고 기록 업데이트 (단/장문 공통 사용)
        userMapper.updateMaxSpeedIfGreater(userId, saveShortRequest.getPracticeType(),
                saveShortRequest.getSpeed(), userIdx);
    }

    // 장문 연습 데이터 호출
    // resoponseDto로 바로 적용 => 가공 필요x
    public LongPracticeResponse getLongPractice(LongPracticeRequest longPracticeRequest) {
        return bibleMapper.getLongPractice(longPracticeRequest);
    }

    // 장문 연습 후 데이터 저장
    @Transactional
    public void saveLongPracticeHistory(SaveLongRequest saveLongRequest, String userId, int userIdx) {
        BibleDto.BibleSaveDto bibleLongSaveDto = BibleDto.BibleSaveDto.builder()
                .userIdx(userIdx)
                .practiceType(saveLongRequest.getPracticeType())
                .bookCodeKo(saveLongRequest.getBookCodeKo())
                .bookCodeEn(saveLongRequest.getBookCodeEn())
                .title(saveLongRequest.getTitle())
                .chapter(saveLongRequest.getChapter())
                .speed(saveLongRequest.getSpeed())
                .testament(saveLongRequest.getTestament())
                .accuracy(saveLongRequest.getAccuracy())
                .duration(saveLongRequest.getDuration())
                .build();
        bibleMapper.saveLongPracticeHistory(bibleLongSaveDto);

        // 최고 기록 업데이트 (단/장문 공통 사용)
        userMapper.updateMaxSpeedIfGreater(userId, saveLongRequest.getPracticeType(),
                saveLongRequest.getSpeed(), userIdx);
    }
}
