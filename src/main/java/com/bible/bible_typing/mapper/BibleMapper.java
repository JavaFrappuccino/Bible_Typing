package com.bible.bible_typing.mapper;

import java.util.List;

import com.bible.bible_typing.dto.request.LongPracticeRequest;
import com.bible.bible_typing.dto.response.LongPracticeResponse;
import org.apache.ibatis.annotations.Mapper;

import com.bible.bible_typing.dto.BibleDto;

@Mapper
public interface BibleMapper {
	// 성경 데이터 DB 마이그레이션 시 사용
	void insertBibleBatch(List<BibleDto.BibleVerseDto> list);

	// 성경 데이터 DB 마이그레이션 시 사용
	void deleteAllVerses();

	// 성경 전체 권수 조회
    List<BibleDto.BibleInfoDto> findAllBookInfo();

	// 단문 연습용 20개 데이터 호출
	List<BibleDto.BibleShortPracticeDto> getShortPractice();

	// 단문 연습 후 데이터 저장
	void saveShortPracticeHistory(BibleDto.BibleSaveDto bibleShortSaveDto);

	// 장문 연습 데이터 호출
	LongPracticeResponse getLongPractice(LongPracticeRequest longPracticeRequest);

	// 장문 연습 후 데이터 저장
	void saveLongPracticeHistory(BibleDto.BibleSaveDto bibleLongSaveDto);
}
