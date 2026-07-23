<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BibleTyping - signUp</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <link rel="shortcut icon" href="/favicon.ico">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="/js/theme.js"></script>
</head>
<script>
    $(document).ready(function() {
        var idCheckFlag = false;

        // 아이디 입력 필드에 변경이 생기면 중복확인 상태를 리셋
        $('#user_id').on('input', function() {
            idCheckFlag = false;
        });

        // 아이디 중복확인 버튼 클릭 이벤트
        $("#idCheckBtn").click(function() {
            var userId = $('#user_id').val();
            if (userId.length === 0) {
                alert('아이디를 입력해주세요.');
                return;
            }

            $.ajax({
                url: '/api/users/checkId', // 아이디 중복확인 요청 URL
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ user_id: userId }),
                success: function(response) {
                    if (response.isDuplicate) {
                        alert('이미 사용 중인 아이디입니다.');
                        idCheckFlag = false;
                    } else {
                        alert('사용 가능한 아이디입니다.');
                        idCheckFlag = true;
                    }
                },
                error: function() {
                    alert('아이디 중복확인 중 오류가 발생했습니다.');
                    idCheckFlag = false;
                }
            });
        });

        // 회원가입 폼 제출 이벤트
        $("#signUpForm").on("submit", function(e) {
            e.preventDefault(); // 폼의 기본 제출 동작을 막음

            if (!idCheckFlag) {
                alert('아이디 중복확인을 먼저 진행해주세요.');
                return;
            }
            if ($('#user_pw').val().length === 0) {
                alert('비밀번호를 입력해주세요.');
                return;
            }
            if ($('#password_confirm').val().length === 0) {
                alert('비밀번호 확인을 입력해주세요.');
                return;
            }
            if ($('#user_pw').val() !== $('#password_confirm').val()) {
                alert('비밀번호가 일치하지 않습니다.');
                return;
            }
            if ($('#user_nm').val().length === 0) {
                alert('이름을 입력해주세요.');
                return;
            }
            if ($('#user_nic').val().length === 0) {
                alert('닉네임을 입력해주세요.');
                return;
            }
            if ($('#user_email').val().length === 0) {
                alert('이메일을 입력해주세요.');
                return;
            }
            var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
            if (!emailRegex.test($('#user_email').val())) {
                alert('올바른 이메일 주소를 입력해주세요.');
                return;
            }
            if ($('#user_birth').val().length === 0) {
                alert('생년월일을 입력해주세요.');
                return;
            }
            if ($('#user_phone').val().length === 0) {
                alert('휴대폰 번호를 입력해주세요.');
                return;
            }

            var signUpData = {
                userId: $('#user_id').val(),
                userPw: $('#user_pw').val(),
                passwordConfirm: $('#password_confirm').val(),
                userNm: $('#user_nm').val(),
                userNic: $('#user_nic').val(),
                userEmail: $('#user_email').val(),
                userBirth: $('#user_birth').val(),
                userPhone: $('#user_phone').val()
            };

            $.ajax({
                url: '/api/users/signUpProc',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(signUpData),
                success: function(response) {
                    alert('회원가입이 완료되었습니다.');
                    window.location.href = '/'; // 로그인 페이지로 리디렉션
                },
                error: function(xhr, status, error) {
                    // 서버에서 보낸 에러 메시지를 표시 (가능한 경우)
                    var errorMessage = "회원가입 중 오류가 발생했습니다.";
                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        errorMessage = xhr.responseJSON.message;
                    }
                    alert(errorMessage);
                }
            });
        });
    });
</script>
<body>
    <header>
        <div style="width: 100%; padding: 0 1.5rem;" class="d-flex justify-content-between align-items-center">
            <div class="navbar-brand-group">
                <img class="logo-img" src="/images/bible3.png"/>
                <span class="logo-text">BibleTyping</span>
            </div>
            <button type="button" class="theme-toggle-btn" onclick="toggleTheme()" aria-label="테마 변경">
                🌙 모드
            </button>
        </div>
    </header>

    <main>
        <div class="login-card" style="width: 400px; padding: 40px;">
            <div class="logo-container">
                <img class="logo-img" src="/images/bible3.png"/>
                <h2>회원가입</h2>
                <p style="color: #666; font-size: 0.9rem;">성경 말씀 타자 연습을 위한 계정을 만듭니다.</p><br>
            </div>

            <form id="signUpForm">
                <div class="input-group">
                    <label for="user_id">사용자 아이디</label>
                    <div style="display: flex; align-items: center;">
                        <input type="text" id="user_id" name="user_id" placeholder="사용할 ID를 입력하세요" required style="flex-grow: 1; margin-right: 10px;">
                        <button type="button" id="idCheckBtn" class="btn-sub" style="flex-shrink: 0;">중복확인</button>
                    </div>
                </div>

                <div class="input-group">
                    <label for="user_pw">비밀번호</label>
                    <input type="password" id="user_pw" name="user_pw" placeholder="사용할 Password를 입력하세요" required>
                </div>

                <div class="input-group">
                    <label for="passwordConfirm">비밀번호 확인</label>
                    <input type="password" id="password_confirm" name="password_confirm" placeholder="Password를 다시 한번 입력하세요" required>
                </div>

                <div class="input-group">
                    <label for="user_nm">이름</label>
                    <input type="text" id="user_nm" name="user_nm" placeholder="이름을 입력하세요" required>
                </div>

                <div class="input-group">
                    <label for="user_nic">닉네임</label>
                    <input type="text" id="user_nic" name="user_nic" placeholder="사용할 닉네임을 입력하세요" required>
                </div>

                <div class="input-group">
                    <label for="user_email">이메일</label>
                    <input type="email" id="user_email" name="user_email" placeholder="이메일 주소를 입력하세요" required>
                </div>

                <div class="input-group">
                    <label for="user_birth">생년월일</label>
                    <input type="text" id="user_birth" name="user_birth" placeholder="6자리 (예: 950101)" maxlength="6" required>
                </div>

                <div class="input-group">
                    <label for="user_phone">휴대폰 번호</label>
                    <input type="text" id="user_phone" name="user_phone" placeholder="'-' 없이 숫자만 입력" maxlength="11" required>
                </div>

                <button type="submit" class="btn-main" style="width: 100%;">회원가입</button>
            </form>

            <div style="margin-top: 25px; text-align: center; font-size: 0.9rem; color: #888;">
                이미 계정이 있으신가요? <a href="/" style="color: #0d6efd; text-decoration: none; font-weight: bold;">로그인 페이지로 돌아가기</a>
            </div>
        </div>
    </main>
</body>
</html>