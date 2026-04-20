package com.bible.bible_typing.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UserInfoDto {

    private Long userIdx;
    private String userId;
    private String userPw;
    private String passwordConfirm; // 비밀번호 확인 필드 추가
    private String userNm;
    private String userNic;
    private String userEmail;
    private String userBirth;
    private String userPhone;
    private String useYn;
    private Long insIdx;
    private LocalDateTime insDate;
    private Long uptIdx;
    private LocalDateTime uptDate;

}
