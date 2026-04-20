package com.bible.bible_typing.service;

import com.bible.bible_typing.dto.UserInfoDto;
import com.bible.bible_typing.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils; // StringUtils 임포트 추가

@Service
@RequiredArgsConstructor // final 필드에 대한 생성자를 자동으로 만들어줍니다.
public class UserService {

    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;

    /**
     * 아이디 중복 여부를 확인합니다.
     * @param userId 확인할 사용자 ID
     * @return 중복이면 true, 아니면 false
     */
    public boolean isUserIdDuplicate(String userId) {
        return userMapper.countByUserId(userId) > 0;
    }

    /**
     * 회원가입을 처리합니다.
     * @param userInfoDto 사용자 정보 DTO
     */
    @Transactional
    public void join(UserInfoDto userInfoDto) {
        // 1. 필수 입력값 검증 (비밀번호 관련)
        if (!StringUtils.hasText(userInfoDto.getUserId())) {
            throw new IllegalArgumentException("아이디는 필수 입력값입니다.");
        }
        if (!StringUtils.hasText(userInfoDto.getUserPw())) {
            throw new IllegalArgumentException("비밀번호는 필수 입력값입니다.");
        }
        if (!StringUtils.hasText(userInfoDto.getPasswordConfirm())) {
            throw new IllegalArgumentException("비밀번호 확인은 필수 입력값입니다.");
        }

        // 2. 아이디 중복 확인
        if (isUserIdDuplicate(userInfoDto.getUserId())) {
            throw new IllegalArgumentException("이미 사용 중인 아이디입니다.");
        }

        // 3. 비밀번호와 비밀번호 확인 일치 여부 검증
        if (!userInfoDto.getUserPw().equals(userInfoDto.getPasswordConfirm())) {
            throw new IllegalArgumentException("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
        }

        // 4. 비밀번호 암호화
        String encodedPassword = passwordEncoder.encode(userInfoDto.getUserPw());
        userInfoDto.setUserPw(encodedPassword);
        
        // 비밀번호 확인 필드는 DB에 저장하지 않으므로 null 처리 (선택 사항)
        userInfoDto.setPasswordConfirm(null); 

        // 5. DB에 사용자 정보 저장
        userMapper.insertUser(userInfoDto);
    }

    /**
     * 로그인을 처리합니다.
     * @param userId 사용자 ID
     * @param password 입력된 비밀번호 (암호화되지 않은 원본)
     * @return 로그인 성공 시 UserInfoDto, 실패 시 null
     */
    public UserInfoDto login(String userId, String password) {
        // 1. 사용자 ID로 DB에서 사용자 정보 조회
        UserInfoDto userInfo = userMapper.findByUserId(userId);

        // 2. 사용자 존재 여부 확인
        if (userInfo == null) {
            return null; // 사용자가 존재하지 않음
        }

        // 3. 입력된 비밀번호와 DB에 저장된 암호화된 비밀번호 비교
        // passwordEncoder.matches(원본 비밀번호, 암호화된 비밀번호)
        if (passwordEncoder.matches(password, userInfo.getUserPw())) {
            return userInfo; // 비밀번호 일치, 로그인 성공
        } else {
            return null; // 비밀번호 불일치, 로그인 실패
        }
    }
}
