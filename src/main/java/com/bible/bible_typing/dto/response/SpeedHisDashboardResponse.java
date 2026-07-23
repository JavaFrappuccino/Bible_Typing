package com.bible.bible_typing.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SpeedHisDashboardResponse {

    private int avgAccuracy;
    private String totalDuration;
    private int sevenDayAvgSpeed;

}
