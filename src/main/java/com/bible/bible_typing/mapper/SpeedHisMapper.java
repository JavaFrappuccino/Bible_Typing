package com.bible.bible_typing.mapper;

import com.bible.bible_typing.dto.SpeedHisDto;
import com.bible.bible_typing.dto.response.SpeedHisDashboardResponse;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SpeedHisMapper {

    // 대시보드에 띄울 사용자 연습 기록 조회
    SpeedHisDashboardResponse getSpeedHisDashboardById(@Param("userIdx") int userIdx);
}
