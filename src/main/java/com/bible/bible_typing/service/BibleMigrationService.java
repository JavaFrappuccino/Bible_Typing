package com.bible.bible_typing.service;

import com.bible.bible_typing.dto.BibleDto;
import com.bible.bible_typing.mapper.BibleMapper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Service;

@Service
public class BibleMigrationService implements ApplicationListener<ApplicationReadyEvent> {

  private final BibleMapper bibleMapper;
  private final ResourceLoader resourceLoader;
  private Map<String, Long> bookCodeToIdMap;

  public BibleMigrationService(BibleMapper bibleMapper, ResourceLoader resourceLoader) {
    this.bibleMapper = bibleMapper;
    this.resourceLoader = resourceLoader;
  }

  @Override
  public void onApplicationEvent(ApplicationReadyEvent event) {
    // 애플리케이션이 완전히 준비된 후 DB에서 책 정보를 읽어와 Map에 저장
    List<BibleDto.BibleInfoDto> allBooks = bibleMapper.findAllBookInfo();
    this.bookCodeToIdMap =
        allBooks.stream()
            .collect(Collectors.toMap(BibleDto.BibleInfoDto::getBookCodeKo, BibleDto.BibleInfoDto::getId));
    System.out.println("Bible info loaded. Total books: " + this.bookCodeToIdMap.size());
  }

  public void migrate() throws Exception {
    // bookCodeToIdMap이 비어있으면 DB에서 다시 로드
    if (this.bookCodeToIdMap == null || this.bookCodeToIdMap.isEmpty()) {
      List<BibleDto.BibleInfoDto> allBooks = bibleMapper.findAllBookInfo();
      this.bookCodeToIdMap =
          allBooks.stream()
              .collect(Collectors.toMap(BibleDto.BibleInfoDto::getBookCodeKo, BibleDto.BibleInfoDto::getId));
    }

    // 1. 테이블 비우기
    bibleMapper.deleteAllVerses();

    // 2. JSON 파일 읽기
    ObjectMapper mapper = new ObjectMapper();
    Resource resource =
        resourceLoader.getResource("classpath:BibleData/Revised Revision Bible.json");
    Map<String, String> rawData =
        mapper.readValue(resource.getInputStream(), new TypeReference<>() {});

    List<BibleDto.BibleVerseDto> batchList = new ArrayList<>();

    // 3. 데이터 파싱 및 DTO 생성
    for (Map.Entry<String, String> entry : rawData.entrySet()) {
      String key = entry.getKey();
      String content = entry.getValue();

      try {
        String[] keyParts = key.split(":", 2);
        if (keyParts.length != 2) {
          continue;
        }

        String bookAndChapterPart = keyParts[0];
        String versePart = keyParts[1];

        int chapterStartIndex = -1;
        for (int i = bookAndChapterPart.length() - 1; i >= 0; i--) {
          if (!Character.isDigit(bookAndChapterPart.charAt(i))) {
            chapterStartIndex = i + 1;
            break;
          }
        }

        if (chapterStartIndex == -1 || chapterStartIndex == bookAndChapterPart.length()) {
          continue;
        }

        String bookCodeKo = bookAndChapterPart.substring(0, chapterStartIndex);
        String chapterStr = bookAndChapterPart.substring(chapterStartIndex);

        // 4. Map에서 book_id 조회
        Long bookId = bookCodeToIdMap.get(bookCodeKo);
        if (bookId == null) {
          System.out.println("Skipping unknown book code: " + bookCodeKo);
          continue;
        }

        int chapter = Integer.parseInt(chapterStr);
        if (versePart.contains("-")) {
          versePart = versePart.split("-")[0];
        }
        int verse = Integer.parseInt(versePart);

        BibleDto.BibleVerseDto dto = new BibleDto.BibleVerseDto();
        dto.setBookId(bookId);
        dto.setChapter(chapter);
        dto.setVerse(verse);
        dto.setContent(content.trim());
        dto.setVerseKey(key);

        batchList.add(dto);

        // 5. 1000건마다 DB에 저장
        if (batchList.size() >= 1000) {
          bibleMapper.insertBibleBatch(batchList);
          batchList.clear();
        }
      } catch (NumberFormatException e) {
        System.out.println("Skipping malformed key (not a number): " + key);
      }
    }

    // 6. 남은 데이터 최종 저장
    if (!batchList.isEmpty()) {
      bibleMapper.insertBibleBatch(batchList);
    }
    System.out.println("Bible migration completed.");
  }
}
