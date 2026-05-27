package com.bible.bible_typing.service;

import com.bible.bible_typing.dto.SpeedHisDto;
import com.bible.bible_typing.dto.response.SpeedHisDashboardResponse;
import com.bible.bible_typing.mapper.SpeedHisMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SpeedHisService {

    private final SpeedHisMapper speedHisMapper;

    // 대시보드에 띄울 사용자 연습 기록 조회
    public SpeedHisDashboardResponse getSpeedHisDashboardDto(int userIdx) {

        SpeedHisDashboardResponse speedHis = speedHisMapper.getSpeedHisDashboardById(userIdx);

        int rawSecond = Integer.parseInt(speedHis.getTotalDuration());

        int hours = rawSecond / 3600;
        int minutes = rawSecond % 3600 / 60;
        int seconds = rawSecond % 60;

        String timeString;

        if (hours > 0) {
            // 1시간 이상일 때는 "X시간 Y분" (예: 1시간 34분)
            timeString = hours + "시간 " + minutes + "분";
        } else if (minutes > 0) {
            // 1시간 미만이면서 1분 이상일 때는 "Y분 Z초" (예: 34분 15초)
            timeString = minutes + "분 " + seconds + "초";
        } else {
            // 1분 미만일 때는 "Z초" (예: 45초)
            timeString = seconds + "초";
        }

        speedHis.setTotalDuration(timeString);

        return speedHis;
    }
}
