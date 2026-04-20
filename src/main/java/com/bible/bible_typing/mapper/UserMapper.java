package com.bible.bible_typing.mapper;

import com.bible.bible_typing.dto.UserInfoDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {

    /**
     * 사용자 ID로 사용자가 존재하는지 카운트 (ID 중복 체크용)
     * @param userId 사용자 ID
     * @return 존재하면 1, 없으면 0
     */
    int countByUserId(String userId);

    /**
     * 새로운 사용자 정보를 삽입
     * @param userInfo 사용자 정보 DTO
     */
    void insertUser(UserInfoDto userInfo);

    /**
     * 사용자 ID로 사용자 정보를 조회합니다.
     * @param userId 사용자 ID
     * @return 사용자 정보 DTO (없으면 null)
     */
    UserInfoDto findByUserId(String userId);

}
