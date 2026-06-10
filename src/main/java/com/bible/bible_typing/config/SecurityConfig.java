package com.bible.bible_typing.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable()) // CSRF 보호 비활성화 (개발 편의를 위해)
            .authorizeHttpRequests(authz -> authz
                .anyRequest().permitAll() // 모든 요청을 인증 없이 허용
            )
            .logout(logout -> logout
                .logoutUrl("/logout") // 로그아웃을 처리할 URL (기본값과 동일)
                .logoutSuccessUrl("/") // 로그아웃 성공 시 리다이렉트될 URL
                .invalidateHttpSession(true) // 세션 무효화 (기본값)
                .deleteCookies("JSESSIONID") // 쿠키 삭제 (선택 사항)
            );
        return http.build();
    }
}
