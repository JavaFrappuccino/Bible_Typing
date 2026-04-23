package com.bible.bible_typing.dto.request;

import lombok.Data;

@Data
public class LoginRequest {

    private String userId;
    private String password;
}
