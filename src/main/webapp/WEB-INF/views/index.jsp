<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BibleTyping - Login</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <link rel="shortcut icon" href="/favicon.ico">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="/js/theme.js"></script>
</head>
<script>
    $(document).ready(function() {
        // 1. 페이지 로드 시 저장된 아이디 확인
        var savedUserId = localStorage.getItem('savedUserId');
        if (savedUserId) {
            $('#userId').val(savedUserId);
            $('#rememberId').prop('checked', true);
        }

        // 엔터키 입력 시 로그인 버튼 클릭 이벤트 발생
        $("#userId, #password").keypress(function(e) {
            if (e.keyCode === 13) {
                e.preventDefault();
                $("#loginBtn").click();
            }
        });

        // 2. 로그인 버튼 클릭 시
        $("#loginBtn").click(function(e) {
            e.preventDefault(); // 기본 폼 전송 막기
            var userId = $('#userId').val();
            var pw = $('#password').val();
            
            if(userId.length == 0) {
                alert('아이디를 입력해주세요.');
                $('#userId').focus();
                return false;
            }
            if(pw.length == 0) {
                alert('비밀번호를 입력해주세요.');
                $('#password').focus();
                return false;
            }

            // 3. 아이디 저장 체크박스 확인
            if ($('#rememberId').is(':checked')) {
                // 체크되어 있으면 로컬 스토리지에 아이디 저장
                localStorage.setItem('savedUserId', userId);
            } else {
                // 체크 해제되어 있으면 로컬 스토리지에서 아이디 삭제
                localStorage.removeItem('savedUserId');
            }

            // 4. JSON 형태로 데이터 전송 (AJAX)
            var requestData = {
                userId: userId,
                password: pw
            };

            $.ajax({
                type: "POST",
                url: "/api/users/loginProc",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(requestData),
                success: function(response) {
                    if (response.success) {
                        window.location.href = "/mainPage"; // 로그인 성공 시 이동
                    }
                },
                error: function(xhr) {
                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        alert(xhr.responseJSON.message);
                    } else {
                        alert("로그인 중 오류가 발생했습니다.");
                    }
                }
            });
        });

        // 회원가입 성공 메시지 표시 (URL 파라미터 확인)
        var urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('signUp_success') === 'true') {
            alert('회원가입이 성공적으로 완료되었습니다. 로그인해주세요.');
            // URL에서 파라미터 제거 (선택 사항)
            history.replaceState({}, document.title, window.location.pathname);
        }
    })
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
                <h2>Bible Typing</h2>
                <p style="color: #666; font-size: 0.9rem;">성경 말씀 타자 연습을 시작해볼까요?</p><br>
            </div>

            <form id="loginForm">
                <c:if test="${not empty loginError}">
                    <div style="color: #dc3545; text-align: center; margin-bottom: 15px; font-weight: bold;">
                        ${loginError}
                    </div>
                </c:if>

                <div class="input-group">
                    <label for="userId">사용자 아이디</label>
                    <input type="text" id="userId" name="userId" placeholder="ID를 입력하세요" required>
                </div>
                
                <div class="input-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="Password를 입력하세요" required>
                </div>

                <div class="input-group" style="display: flex; align-items: center; margin-bottom: 25px;">
                    <input type="checkbox" id="rememberId" style="width: auto; margin-right: 8px;">
                    <label for="rememberId" style="margin-bottom: 0; font-size: 0.9rem; color: #666; cursor: pointer;">아이디 저장</label>
                </div>

                <button type="button" class="btn-main" id="loginBtn" style="width: 100%;">로그인</button>
            </form>

            <div style="margin-top: 25px; text-align: center; font-size: 0.9rem; color: #888;">
                계정이 없으신가요? <a href="signUp" style="color: #0d6efd; text-decoration: none; font-weight: bold;">회원가입 시작하기</a>
            </div>
        </div>
    </main>
</body>
</html>