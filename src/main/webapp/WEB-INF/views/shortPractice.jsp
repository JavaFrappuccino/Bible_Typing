<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BibleTyping - 단문 연습</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <style>
        /* 단문 연습 전용 미세 조정 (나중에 style.css로 옮겨도 됨) */
        .short-practice-wrapper {
            max-width: 800px;
            margin: 100px auto;
            text-align: center;
        }
        .target-display {
            font-size: 2rem;
            font-weight: 500;
            color: #212529;
            margin-bottom: 40px;
            word-break: keep-all;
            min-height: 100px;
        }
    </style>
</head>
<body>

    <header class="practice-header">
        <div class="container-fluid px-4 d-flex justify-content-between align-items-center">
            <div class="navbar-brand-group">
                <img src="/images/bible3.png" class="logo-img">
                <span class="logo-text">BibleTyping - 단문 연습</span>
            </div>
            <a href="/mainPage" class="btn btn-outline-light btn-sm" style="border-radius: 20px;">그만하기</a>
        </div>
    </header>

    <div class="timer-bar">
        <div class="container d-flex justify-content-around">
            <div class="stat-item">시간 <span id="timer" class="stat-value">00:00</span></div>
            <div class="stat-item">현재타수 <span id="wpm" class="stat-value">0</span></div>
            <div class="stat-item">정확도 <span id="acc" class="stat-value">100%</span></div>
            <div class="stat-item">진행 <span id="progress" class="stat-value">1 / 10</span></div>
        </div>
    </div>

    <main class="container">
        <div class="short-practice-wrapper">
            <div class="target-display" id="targetText">
                하나님이 세상을 이처럼 사랑하사 독생자를 주셨으니 (요한복음 3:16)
            </div>

            <div class="input-group" style="max-width: 600px; margin: 0 auto;">
                <input type="text" id="typeInput" class="long-input active"
                       placeholder="위 문장을 따라 입력하세요" autofocus autocomplete="off">
            </div>

            <p class="text-muted mt-4 small">Enter를 누르면 다음 구절로 넘어갑니다.</p>
        </div>
    </main>

    <script>
        let seconds = 0;
        const timerElement = document.getElementById('timer');
        const inputElement = document.getElementById('typeInput');

        // 타이머 시작
        setInterval(() => {
            seconds++;
            let min = String(Math.floor(seconds / 60)).padStart(2, '0');
            let sec = String(seconds % 60).padStart(2, '0');
            timerElement.innerText = min + ":" + sec;
        }, 1000);

        // 엔터 키 이벤트 (다음 구절 이동 시뮬레이션)
        inputElement.addEventListener('keydown', function(e) {
            if(e.key === 'Enter') {
                e.preventDefault();
                // 여기에 다음 구절을 가져오는 로직을 넣을 수 있습니다.
                alert('다음 구절로 넘어갑니다!');
                this.value = ''; // 입력창 비우기
            }
        });
    </script>
</body>
</html>