package com.bible.bible_typing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bible.bible_typing.dto.BibleInfoDto;
import com.bible.bible_typing.dto.BibleVerseDto;

@Mapper
public interface BibleMapper {
	void insertBibleBatch(List<BibleVerseDto> list);
	void deleteAllVerses();
    List<BibleInfoDto> findAllBookInfo();
}
