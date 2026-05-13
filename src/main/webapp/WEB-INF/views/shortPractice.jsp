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
        /* 결과창 모달 커스텀 스타일 */
        #resultModalOverlay {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 9999;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
            display: flex;
            justify-content: center;
            align-items: center;
        }
        #resultModalOverlay.show {
            opacity: 1;
            visibility: visible;
        }
        .result-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 40px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            transform: translateY(20px);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        #resultModalOverlay.show .result-card {
            transform: translateY(0);
        }

        /* 네온 프로그레스 바 커스텀 */
        .neon-bar-container {
            background: #1e1e1e;
            border-radius: 30px;
            height: 24px;
            padding: 3px;
            box-shadow: inset 0 2px 5px rgba(0,0,0,0.7), 0 1px 1px rgba(255,255,255,0.2);
            margin-bottom: 20px;
            overflow: hidden;
            position: relative;
        }
        .neon-bar {
            height: 100%;
            border-radius: 20px;
            width: 0%; /* JS로 애니메이션 처리 */
            transition: width 1.5s cubic-bezier(0.25, 1, 0.5, 1);
            background-size: 1.5rem 1.5rem;
            background-image: linear-gradient(
                    45deg,
                    rgba(255, 255, 255, 0.15) 25%,
                    transparent 25%,
                    transparent 50%,
                    rgba(255, 255, 255, 0.15) 50%,
                    rgba(255, 255, 255, 0.15) 75%,
                    transparent 75%,
                    transparent
            );
            animation: stripe-slide 1s linear infinite;
        }
        @keyframes stripe-slide {
            from { background-position: 1.5rem 0; }
            to { background-position: 0 0; }
        }

        /* 색상 테마 */
        .neon-green { background-color: #0be881; box-shadow: 0 0 12px #0be881; }
        .neon-silver { background-color: #d2dae2; box-shadow: 0 0 12px #d2dae2; }
        .neon-orange { background-color: #ff9f43; box-shadow: 0 0 12px #ff9f43; }

        .stat-label-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            padding: 0 5px;
        }
        .stat-title { font-weight: 700; color: #495057; font-size: 0.95rem; }
        .stat-score { font-weight: 900; font-size: 1.1rem; }
    </style>
</head>
<body>

<header class="practice-header">
    <div class="container-fluid px-4 d-flex justify-content-between align-items-center">
        <div class="navbar-brand-group d-flex align-items-center">
            <img src="/images/bible3.png" class="logo-img me-2" alt="Logo" style="height: 30px;">
            <span class="logo-text fs-4 fw-bold">BibleTyping - 단문 연습</span>
        </div>
        <c:if test="${not empty sessionScope.loggedInUser}">
            <div class="d-flex align-items-center">
                <span class="me-3 text-white fw-bold">${sessionScope.loggedInUser.userNic}님</span>
                <a href="/mainPage" class="btn btn-light btn-sm fw-bold text-dark" style="border-radius: 20px; padding: 5px 15px;">그만하기</a>
            </div>
        </c:if>
    </div>
</header>

<div class="timer-bar">
    <div class="container d-flex flex-wrap justify-content-around">
        <div class="stat-item">현재 타수: <span id="wpm" class="stat-value text-primary">0</span></div>
        <div class="stat-item">평균 타수: <span id="avgWpm" class="stat-value text-primary">0</span></div>
        <div class="stat-item">현재 정확도: <span id="currentAccuracy" class="stat-value text-primary">100%</span></div>
        <div class="stat-item">총 정확도: <span id="totalAccuracy" class="stat-value text-primary">100%</span></div>
        <div class="stat-item">소요시간: <span id="timer" class="stat-value text-danger">0초</span></div>
    </div>
</div>

<div class="container mt-4 mb-2" style="max-width: 800px;">
    <div class="progress position-relative" style="height: 25px; border-radius: 15px; background-color: #e9ecef;">
        <div id="practiceProgressBar" class="progress-bar progress-bar-striped progress-bar-animated bg-success"
             role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="20">
        </div>
        <div id="progressTextDisplay" class="position-absolute w-100 h-100 d-flex justify-content-center align-items-center fw-bold" style="color: #333; pointer-events: none;">
            0 / 20
        </div>
    </div>
</div>

<main class="container">
    <div class="short-practice-wrapper">
        <div id="bibleReference" class="text-center fw-bold text-secondary fs-5" style="letter-spacing: 1px;">
            로딩 중...
        </div>

        <div class="position-relative mx-auto" style="max-width: 800px; cursor: text;" onclick="document.getElementById('typeInput').focus()">
            <input type="text" id="typeInput" class="position-absolute w-100 h-100"
                   autofocus autocomplete="off" style="opacity: 0; z-index: 2; top: 0; left: 0;" readonly>

            <div id="fakeDisplay" class="text-center"
                 style="font-size: 2rem; font-weight: 600; line-height: 1.6; min-height: 160px; color: #ced4da; white-space: pre-wrap; word-break: keep-all; padding: 40px 20px; border-radius: 15px; background-color: #f8f9fa; border: 2px dashed #dee2e6; user-select: none;">
                데이터를 불러오는 중입니다...
            </div>
        </div>

        <div class="mt-4 text-muted small">
            <p class="mb-1">문장을 끝까지 입력한 후 Space 또는 Enter를 누르면 다음으로 넘어갑니다.</p>
            <p class="mb-0">말씀에 오타나 문제가 있을 시 tsk8520@naver.com으로 문의해주세요.</p>
        </div>
    </div>
</main>

<!-- 결과창 모달 오버레이 -->
<div id="resultModalOverlay">
    <div class="result-card text-center">
        <h3 class="fw-bold mb-2">
            <span style="color: #0d6efd;">${not empty sessionScope.loggedInUser ? sessionScope.loggedInUser.userNic : '회원'}</span>님 수고하셨습니다!
        </h3>
        <!-- 완료 문구를 동적으로 변경하기 위해 id 추가 -->
        <p class="text-muted mb-3 small" id="modalCompletionText">20개의 단문 연습을 모두 완료했습니다.</p>

        <div class="d-inline-block px-4 py-2 mb-4" style="background-color: #f8f9fa; border-radius: 30px; border: 1px solid #e9ecef;">
            <span class="text-muted small fw-bold me-2">총 소요 시간</span>
            <span class="fw-bold" style="color: #0fbcf9; font-size: 1.15rem;" id="modalTotalTime">0분 0초</span>
        </div>

        <div class="text-start mt-2">
            <div class="stat-label-group">
                <span class="stat-title">평균 타수</span>
                <span class="stat-score" style="color: #0be881;" id="modalAvgWpm">0 타</span>
            </div>
            <div class="neon-bar-container">
                <div class="neon-bar neon-green" id="modalAvgWpmBar" data-width="0%"></div>
            </div>

            <div class="stat-label-group">
                <span class="stat-title">총 정확도</span>
                <span class="stat-score" style="color: #636e72;" id="modalTotalAcc">0 %</span>
            </div>
            <div class="neon-bar-container">
                <div class="neon-bar neon-silver" id="modalTotalAccBar" data-width="0%"></div>
            </div>

            <div class="stat-label-group">
                <span class="stat-title">최고 타수</span>
                <span class="stat-score" style="color: #ff9f43;" id="modalMaxWpm">0 타</span>
            </div>
            <div class="neon-bar-container">
                <div class="neon-bar neon-orange" id="modalMaxWpmBar" data-width="0%"></div>
            </div>
        </div>

        <div class="mt-5 d-flex justify-content-center gap-3">
            <button class="btn btn-outline-secondary px-4 fw-bold" style="border-radius: 12px;" onclick="location.reload()">다시 하기</button>
            <button class="btn btn-primary px-4 fw-bold" style="border-radius: 12px; background-color: #0d6efd; border:none;" onclick="location.href='/mainPage'">메인으로</button>
        </div>
    </div>
</div>

<script>
    let isSaving = false;
    let seconds = 0;
    let currentProgress = 0;   // 현재 시도 중인 문제 번호 (0~19)
    let completedCount = 0;    // 실제로 끝까지 친 문제 개수
    const totalSentences = 20;

    let versesList = [];
    let sentenceStartTime = 0;
    let isTyping = false;

    let globalCorrectCount = 0;
    let globalTypedCount = 0;
    let globalTotalStrokes = 0;
    let globalTotalSeconds = 0;
    let maxWpm = 0;

    let targetWpm = 0;
    let displayedWpm = 0;
    let targetSentence = "";
    let targetReference = "";

    const timerElement = document.getElementById('timer');
    const inputElement = document.getElementById('typeInput');
    const progressBar = document.getElementById('practiceProgressBar');
    const progressTextDisplay = document.getElementById('progressTextDisplay');
    const fakeDisplay = document.getElementById('fakeDisplay');
    const referenceElement = document.getElementById('bibleReference');

    const wpmElement = document.getElementById('wpm');
    const avgWpmElement = document.getElementById('avgWpm');
    const currentAccuracyElement = document.getElementById('currentAccuracy');
    const totalAccuracyElement = document.getElementById('totalAccuracy');

    window.addEventListener('keydown', function(e) {
        if(e.code === 'Space' && e.target === document.body) {
            e.preventDefault();
        }
    });

    function getStrokeCount(text) {
        let count = 0;
        for (let i = 0; i < text.length; i++) {
            let code = text.charCodeAt(i);
            if (code >= 44032 && code <= 55203) {
                code -= 44032;
                const jong = code % 28;
                count += (jong > 0) ? 3 : 2;
            } else {
                count += 1;
            }
        }
        return count;
    }

    function updateWPM() {
        if (!isTyping || sentenceStartTime === 0) return;
        const typedText = inputElement.value;
        const strokes = getStrokeCount(typedText);
        const elapsedSeconds = Math.max((Date.now() - sentenceStartTime) / 1000, 1);
        const elapsedMinutes = elapsedSeconds / 60;
        if (elapsedMinutes > 0 && strokes > 0) {
            targetWpm = Math.round(strokes / elapsedMinutes);
        }
    }

    function updateAccuracy() {
        if (!targetSentence) return;
        const typed = inputElement.value;
        let currentCorrect = 0;
        let currentTyped = typed.length;
        for (let i = 0; i < currentTyped; i++) {
            if (i < targetSentence.length && typed[i] === targetSentence[i]) {
                currentCorrect++;
            }
        }
        let currentAcc = 100;
        if (currentTyped > 0) {
            currentAcc = Math.round((currentCorrect / currentTyped) * 100);
        }
        currentAccuracyElement.innerText = currentAcc + "%";
    }

    setInterval(() => {
        if (Math.round(displayedWpm) !== targetWpm) {
            displayedWpm += (targetWpm - displayedWpm) * 0.1;
            if (Math.abs(targetWpm - displayedWpm) < 0.5) {
                displayedWpm = targetWpm;
            }
            wpmElement.innerText = Math.round(displayedWpm);
        }
    }, 50);

    function setSentence(index) {
        if (index >= versesList.length) return;
        const data = versesList[index];
        targetSentence = data.content;
        targetReference = data.bookNameKo + ' ' + data.chapter + '장 ' + data.verse + '절';
        referenceElement.innerText = targetReference;
        targetWpm = 0; // 문장 변경 시 현재 타수 초기화
        displayedWpm = 0;
        sentenceStartTime = 0;
        isTyping = false;
        inputElement.readOnly = false;
        inputElement.value = "";
        inputElement.focus();
        updateDisplay();
        updateAccuracy();
    }

    setInterval(() => {
        if (!inputElement.readOnly && currentProgress < totalSentences) {
            seconds++;
            timerElement.innerText = seconds + "초";
            updateWPM();
        }
    }, 1000);

    function updateDisplay() {
        if (!targetSentence) return;
        const typed = inputElement.value;
        let html = '';
        let targetIdx = 0;
        let typedIdx = 0;
        let hasCursor = false;

        while (typedIdx < typed.length && targetIdx < targetSentence.length) {
            let isLast = (typedIdx === typed.length - 1);
            if (typed[typedIdx] === targetSentence[targetIdx]) {
                html += '<span class="text-dark">' + targetSentence[targetIdx] + '</span>';
            } else {
                let char = typed[typedIdx] === ' ' ? targetSentence[targetIdx] : typed[typedIdx];
                if (isLast) {
                    html += '<span class="text-danger" style="background-color: #f8d7da; text-decoration: underline; text-decoration-thickness: 3px; text-underline-offset: 6px;">' + char + '</span>';
                    hasCursor = true;
                } else {
                    html += '<span class="text-danger" style="background-color: #f8d7da;">' + char + '</span>';
                }
            }
            targetIdx++;
            typedIdx++;
        }
        while (typedIdx < typed.length) {
            const char = typed[typedIdx];
            let isLast = (typedIdx === typed.length - 1);
            if (isLast) {
                html += '<span class="text-danger" style="background-color: #f8d7da; text-decoration: underline; text-decoration-thickness: 3px; text-underline-offset: 6px;">' + char + '</span>';
                hasCursor = true;
            } else {
                html += '<span class="text-danger" style="background-color: #f8d7da;">' + char + '</span>';
            }
            typedIdx++;
        }
        if (targetIdx < targetSentence.length) {
            const char = targetSentence[targetIdx];
            if (!hasCursor) {
                html += '<span style="color: #adb5bd; text-decoration: underline; text-decoration-thickness: 3px; text-underline-offset: 6px;">' + char + '</span>';
            } else {
                html += '<span style="color: #adb5bd;">' + char + '</span>';
            }
            targetIdx++;
        }
        while (targetIdx < targetSentence.length) {
            const char = targetSentence[targetIdx];
            html += '<span style="color: #adb5bd;">' + char + '</span>';
            targetIdx++;
        }
        fakeDisplay.innerHTML = html;
    }

    inputElement.addEventListener('input', function() {
        if (sentenceStartTime === 0 && this.value.length > 0) {
            sentenceStartTime = Date.now();
            isTyping = true;
        }
        updateDisplay();
        updateWPM();
        updateAccuracy();
    });

    function showResultModal() {
        const modal = document.getElementById('resultModalOverlay');
        const min = Math.floor(seconds / 60);
        const sec = seconds % 60;
        const timeStr = min > 0 ? min + "분 " + sec + "초" : sec + "초";
        document.getElementById('modalTotalTime').innerText = timeStr;

        // 완료 개수 표시 업데이트
        document.getElementById('modalCompletionText').innerText = completedCount + "개의 단문 연습을 완료했습니다.";

        let avgWpm = 0;
        if (globalTotalSeconds > 0) {
            avgWpm = Math.round(globalTotalStrokes / (globalTotalSeconds / 60));
        }
        document.getElementById('modalAvgWpm').innerText = avgWpm + " 타";
        let avgWpmWidth = Math.min((avgWpm / 1000) * 100, 100);
        document.getElementById('modalAvgWpmBar').setAttribute('data-width', avgWpmWidth + "%");

        let totalAcc = 100;
        if (globalTypedCount > 0) {
            totalAcc = Math.round((globalCorrectCount / globalTypedCount) * 100);
        }
        document.getElementById('modalTotalAcc').innerText = totalAcc + " %";
        document.getElementById('modalTotalAccBar').setAttribute('data-width', totalAcc + "%");

        document.getElementById('modalMaxWpm').innerText = maxWpm + " 타";
        let maxWpmWidth = Math.min((maxWpm / 1000) * 100, 100);
        document.getElementById('modalMaxWpmBar').setAttribute('data-width', maxWpmWidth + "%");

        modal.classList.add('show');
        const bars = document.querySelectorAll('.neon-bar');
        setTimeout(() => {
            bars.forEach(bar => {
                const targetWidth = bar.getAttribute('data-width');
                bar.style.width = targetWidth;
            });
        }, 300);
    }

    inputElement.addEventListener('keydown', function(e) {
        const isEnter = e.key === 'Enter' || e.code === 'Enter';
        const isSpaceAtEnd = (e.key === ' ' || e.code === 'Space') && this.value.length >= targetSentence.length;

        if (isEnter || isSpaceAtEnd) {
            e.preventDefault();
            if (isSaving) return;

            this.readOnly = true;
            const typed = inputElement.value;

            // --- [수정] 실제로 끝까지 입력했는지 확인 ---
            const isFinished = typed.length >= targetSentence.length;

            if (isFinished) {
                completedCount++; // 실제 완료 개수 증가

                let currentCorrect = 0;
                for (let i = 0; i < typed.length; i++) {
                    if (i < targetSentence.length && typed[i] === targetSentence[i]) {
                        currentCorrect++;
                    }
                }
                globalCorrectCount += currentCorrect;
                globalTypedCount += typed.length;

                const strokes = getStrokeCount(typed);
                const elapsedSeconds = Math.max((Date.now() - sentenceStartTime) / 1000, 1);
                globalTotalStrokes += strokes;
                globalTotalSeconds += elapsedSeconds;

                let finalSentenceWpm = Math.round(strokes / (elapsedSeconds / 60));
                if (finalSentenceWpm > maxWpm) maxWpm = finalSentenceWpm;

                // 통계 업데이트
                let totalAcc = globalTypedCount > 0 ? Math.round((globalCorrectCount / globalTypedCount) * 100) : 100;
                totalAccuracyElement.innerText = totalAcc + "%";

                let avgWpm = globalTotalSeconds > 0 ? Math.round(globalTotalStrokes / (globalTotalSeconds / 60)) : 0;
                avgWpmElement.innerText = avgWpm;

                targetWpm = finalSentenceWpm;
                displayedWpm = targetWpm;
                wpmElement.innerText = targetWpm;
            }

            isTyping = false;
            currentProgress++; // 시도 횟수(진행도)는 무조건 증가

            let percentage = (currentProgress / totalSentences) * 100;
            progressBar.style.width = percentage + '%';
            progressBar.setAttribute('aria-valuenow', currentProgress);
            progressTextDisplay.innerText = currentProgress + ' / ' + totalSentences;

            if (currentProgress >= totalSentences) {
                // --- [수정] 완료한 개수가 0개이면 저장하지 않음 ---
                if (completedCount === 0) {
                    isSaving = true; // 중복 방지
                    fakeDisplay.innerText = "완료된 문장이 없어 기록을 저장하지 않습니다.";
                    setTimeout(() => {
                        showResultModal();
                    }, 1000);
                    return;
                }

                isSaving = true;
                let finalAvgWpm = globalTotalSeconds > 0 ? Math.round(globalTotalStrokes / (globalTotalSeconds / 60)) : 0;
                let finalTotalAcc = globalTypedCount > 0 ? Math.round((globalCorrectCount / globalTypedCount) * 100) : 100;

                const recordData = {
                    practiceType: 'short',
                    speed: finalAvgWpm,
                    accuracy: finalTotalAcc,
                    duration: seconds
                };

                fetch('/api/verses/records', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(recordData)
                })
                    .then(response => response.text())
                    .then(data => {
                        console.log('기록 저장 성공:', data);
                        showResultModal();
                    })
                    .catch(error => {
                        console.error('기록 저장 에러:', error);
                        showResultModal();
                    });
                return;
            }

            setTimeout(() => {
                setSentence(currentProgress);
            }, 10);
        }
    });

    window.onload = function() {
        fetch('/api/verses/short-practice')
            .then(res => res.ok ? res.json() : Promise.reject())
            .then(response => {
                if (Array.isArray(response)) versesList = response;
                else if (response.data) versesList = response.data;

                if (versesList && versesList.length > 0) setSentence(0);
                else fakeDisplay.innerText = "가져온 말씀 데이터가 없습니다.";
            })
            .catch(err => {
                fakeDisplay.innerText = "서버와 통신할 수 없습니다.";
            });
    };
</script>
</body>
</html>