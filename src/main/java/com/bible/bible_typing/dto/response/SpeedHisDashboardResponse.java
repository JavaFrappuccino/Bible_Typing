package com.bible.bible_typing.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SpeedHisDashboardResponse {

    private int avgAccuracy;
    private String totalDuration;
    private int sevenDayAvgSpeed;

}
