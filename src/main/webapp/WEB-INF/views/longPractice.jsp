<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BibleTyping - 장문 연습</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body class="long-practice-body">

    <header class="practice-header">
        <div class="container-fluid px-4 d-flex justify-content-between align-items-center">
            <div class="navbar-brand-group">
                <img src="/images/bible3.png" style="width:30px;">
                <span class="logo-text">BibleTyping - 장문 연습</span>
            </div>
            <a href="/mainPage" class="btn btn-outline-light btn-sm" style="border-radius: 20px;">그만하기</a>
        </div>
    </header>

    <div class="timer-bar">
        <div class="container d-flex justify-content-around">
            <div class="stat-item">경과 시간 <span id="timer" class="stat-value">00:00</span></div>
            <div class="stat-item">평균 타수 <span id="wpm" class="stat-value">0</span></div>
            <div class="stat-item">진행도 <span class="stat-value">1 / 5 쪽</span></div>
        </div>
    </div>

    <div class="long-practice-wrapper">
        <div class="text-center mb-4">
            <h4 class="fw-bold">창세기 1장 연습</h4>
            <p class="text-muted small">Enter를 누르면 다음 줄로 이동합니다.</p>
        </div>
        
        <div class="long-practice-box">
            <div class="typing-row">
                <div class="sentence-display">태초에 하나님이 천지를 창조하시니라.</div>
                <input type="text" class="long-input active" id="row1" placeholder="내용을 입력하세요..." autofocus>
            </div>

            <div class="typing-row">
                <div class="sentence-display">땅이 혼돈하고 공허하며 흑암이 깊음 위에 있고</div>
                <input type="text" class="long-input" id="row2" readonly>
            </div>

            <div class="typing-row">
                <div class="sentence-display">하나님의 영은 수면 위에 운행하시니라.</div>
                <input type="text" class="long-input" id="row3" readonly>
            </div>

            <div class="typing-row">
                <div class="sentence-display">하나님이 이르시되 빛이 있으라 하시니 빛이 있었고</div>
                <input type="text" class="long-input" id="row4" readonly>
            </div>
        </div>
    </div>

    <script>
        let seconds = 0;
        const timerElement = document.getElementById('timer');
        
        // 타이머 시작
        setInterval(() => {
            seconds++;
            let min = String(Math.floor(seconds / 60)).padStart(2, '0');
            let sec = String(seconds % 60).padStart(2, '0');
            timerElement.innerText = min + ":" + sec;
        }, 1000);

        // 줄바꿈 기능
        const inputs = document.querySelectorAll('.long-input');
        inputs.forEach((input, index) => {
            input.addEventListener('keydown', function(e) {
                if(e.key === 'Enter') {
                    e.preventDefault();
                    if (index + 1 < inputs.length) {
                        this.classList.remove('active');
                        this.readOnly = true;
                        
                        const nextInput = inputs[index + 1];
                        nextInput.readOnly = false;
                        nextInput.classList.add('active');
                        nextInput.focus();
                    } else {
                        alert('연습이 완료되었습니다!');
                    }
                }
            });
        });
    </script>
</body>
</html>