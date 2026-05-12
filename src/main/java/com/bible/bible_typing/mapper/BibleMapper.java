package com.bible.bible_typing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bible.bible_typing.dto.BibleDto;

@Mapper
public interface BibleMapper {
	void insertBibleBatch(List<BibleDto.BibleVerseDto> list);
	void deleteAllVerses();
    List<BibleDto.BibleInfoDto> findAllBookInfo();
	List<BibleDto.BibleShortPracticeDto> getShortPractice();
	void saveShortPracticeHistory(BibleDto.BibleShortSaveDto bibleShortSaveDto);
}
