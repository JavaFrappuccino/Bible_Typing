<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BibleTyping - 장문 연습</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <script src="/js/bibleData.js"></script>
    <script src="/js/theme.js"></script>
</head>
<body>

<header class="practice-header">
    <div class="container-fluid px-4 d-flex justify-content-between align-items-center mt-3 mb-3">
        <div class="navbar-brand-group d-flex align-items-center">
            <img src="/images/bible3.png" class="logo-img me-2" alt="Logo" style="height: 30px;">
            <span class="logo-text fs-4 fw-bold">BibleTyping - 장문 연습</span>
        </div>
        <c:if test="${not empty sessionScope.loggedInUser}">
            <div class="d-flex align-items-center gap-2">
                <button type="button" class="theme-toggle-btn me-2" onclick="toggleTheme()" aria-label="테마 변경">
                    🌙 모드
                </button>
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

<div class="container mt-4 mb-2" style="max-width: 900px;">
    <div class="row g-3">
        <div class="col-md-6">
            <div class="d-flex justify-content-between mb-1">
                <span class="fw-bold small text-secondary">구절 진행 상황</span>
                <span id="progressTextDisplay" class="fw-bold small text-dark">0 / 0 절 (0%)</span>
            </div>
            <div class="progress" style="height: 15px; border-radius: 10px; background-color: #e9ecef;">
                <div id="practiceProgressBar" class="progress-bar progress-bar-striped progress-bar-animated bg-success"
                     role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="d-flex justify-content-between mb-1">
                <span class="fw-bold small text-secondary">기록 인정 달성도 (목표: 50% 이상)</span>
                <span id="typedPercentDisplay" class="fw-bold small text-danger">0%</span>
            </div>
            <div class="progress position-relative" style="height: 15px; border-radius: 10px; background-color: #e9ecef; overflow: visible;">
                <div style="position: absolute; left: 50%; top: -3px; height: 21px; width: 2px; background-color: #ff9f43; z-index: 10; cursor: help;" title="기록 저장 기준선 (50%)"></div>
                <div id="typedProgressBar" class="progress-bar progress-bar-striped progress-bar-animated bg-info"
                     role="progressbar" style="width: 0%; border-radius: 10px;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                </div>
            </div>
        </div>
    </div>
</div>

<main class="container mt-4 mb-5">
    <div class="short-practice-wrapper mt-3" style="max-width: 900px; margin-top: 20px !important;">
        <div id="bibleReference" class="text-center fw-bold text-secondary mb-4 fs-4" style="letter-spacing: 1px;">
            로딩 중...
        </div>

        <div class="position-relative mx-auto" style="cursor: text;" onclick="document.getElementById('typeInput').focus()">
            <input type="text" id="typeInput" class="position-absolute w-100 h-100"
                   autofocus autocomplete="off" style="opacity: 0; z-index: 2; top: 0; left: 0;" readonly>

            <div id="fakeDisplay" class="text-start"
                 style="font-size: 1.45rem; font-weight: 600; line-height: 2.1; min-height: 280px; color: #ced4da; white-space: pre-wrap; word-break: break-all; padding: 30px; border-radius: 15px; background-color: #ffffff; box-shadow: 0 10px 30px rgba(0,0,0,0.05); user-select: none;">
                데이터를 불러오는 중입니다...
            </div>
        </div>

        <div class="mt-4 text-muted small text-center">
            <p class="mb-1">줄 바꿈 전까지는 문장 끝에서 <span class="fw-bold text-primary">Space</span>를, 다음 페이지로 넘기거나 완료할 때는 <span class="fw-bold text-success">Enter</span>를 누르세요.</p>
            <p class="mb-0">말씀에 오타나 문제가 있을 시 tsk8520@naver.com으로 문의해주세요.</p>
        </div>
    </div>
</main>

<div id="resultModalOverlay">
    <div class="result-card text-center">
        <span id="modalIcon" style="font-size: 3.5rem; margin-bottom: 15px; display: block;">🎉</span>
        <h3 class="fw-bold mb-2" id="modalTitle">
            <span style="color: #0d6efd;">${not empty sessionScope.loggedInUser ? sessionScope.loggedInUser.userNic : '회원'}</span>님 수고하셨습니다!
        </h3>
        <p class="text-muted mb-3 small" id="modalCompletionText">선택하신 장문 연습을 모두 완료했습니다.</p>

        <div id="modalStatsSection">
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
        </div>

        <div id="modalEmptyMessage" style="display: none; padding: 20px 0;">
            <p class="fw-bold text-secondary">입력 분량이 부족하여<br>기록이 저장되지 않습니다.</p>
            <p class="text-muted small">한 장 전체의 최소 <span id="modalThresholdText">50</span>% 이상 타이핑해야 기록이 인정됩니다.</p>
        </div>

        <div class="mt-5 d-flex justify-content-center gap-3">
            <button class="btn btn-outline-secondary px-4 fw-bold" style="border-radius: 12px;" onclick="location.reload()">다시 하기</button>
            <button class="btn btn-primary px-4 fw-bold" style="border-radius: 12px; background-color: #0d6efd; border:none;" onclick="location.href='/mainPage'">메인으로</button>
        </div>
    </div>
</div>

<script>
    // URL 및 성경 관련 전역 변수
    let globalBookCodeKo = "";
    let globalBookCodeEn = "";
    let globalChapter = 1;

    let apiData = {};
    let versesList = [];
    let currentVerseIndex = 0;
    const CHUNK_SIZE = 3;
    let typedHistory = [];

    const SAVE_THRESHOLD = 0.5;
    let totalChapterLength = 0;

    let seconds = 0;
    let sentenceStartTime = 0;
    let isTyping = false;
    let isFinished = false;
    let dataLoaded = false;
    let isProcessing = false;

    let globalCorrectCount = 0;
    let globalTypedCount = 0;
    let globalTotalStrokes = 0;
    let globalTotalSeconds = 0;
    let maxWpm = 0;

    let targetWpm = 0;
    let displayedWpm = 0;

    const timerElement = document.getElementById('timer');
    const inputElement = document.getElementById('typeInput');
    const fakeDisplay = document.getElementById('fakeDisplay');
    const referenceElement = document.getElementById('bibleReference');

    const wpmElement = document.getElementById('wpm');
    const avgWpmElement = document.getElementById('avgWpm');
    const currentAccuracyElement = document.getElementById('currentAccuracy');
    const totalAccuracyElement = document.getElementById('totalAccuracy');

    const progressBar = document.getElementById('practiceProgressBar');
    const progressTextDisplay = document.getElementById('progressTextDisplay');
    const typedProgressBar = document.getElementById('typedProgressBar');
    const typedPercentDisplay = document.getElementById('typedPercentDisplay');

    // bibleData.js 데이터를 활용하여 영어 약어(bookCodeEn)로 한글 약어(bookCodeKo)를 찾는 함수
    function getMappedBookCodeKo(enCode) {
        if (!enCode || typeof bibleData === 'undefined') return null;

        const upperCode = enCode.toUpperCase();

        // 구약에서 찾기
        const oldBook = bibleData.old.find(b => b.bookCodeEn === upperCode);
        if (oldBook) return oldBook.bookCodeKo;

        // 신약에서 찾기
        const newBook = bibleData.new.find(b => b.bookCodeEn === upperCode);
        if (newBook) return newBook.bookCodeKo;

        return null;
    }

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
                code -= 44032; count += (code % 28 > 0) ? 3 : 2;
            } else {
                count += 1;
            }
        }
        return count;
    }

    function updateWPM() {
        if (!isTyping || sentenceStartTime === 0 || isFinished || !dataLoaded) return;

        const typedText = inputElement.value;
        const strokes = getStrokeCount(typedText);
        const elapsedSeconds = Math.max((Date.now() - sentenceStartTime) / 1000, 1);
        const elapsedMinutes = elapsedSeconds / 60;

        if (elapsedMinutes > 0 && strokes > 0) {
            targetWpm = Math.round(strokes / elapsedMinutes);
        }
    }

    function updateAccuracy() {
        if (!dataLoaded || currentVerseIndex >= versesList.length) return;

        const targetSentence = versesList[currentVerseIndex].content;
        const typed = inputElement.value;
        let currentCorrect = 0;

        for (let i = 0; i < typed.length; i++) {
            if (i < targetSentence.length && typed[i] === targetSentence[i]) {
                currentCorrect++;
            }
        }

        let currentAcc = 100;
        if (typed.length > 0) {
            currentAcc = Math.round((currentCorrect / typed.length) * 100);
        }
        currentAccuracyElement.innerText = currentAcc + "%";
    }

    function updateProgressBar() {
        if (!versesList || versesList.length === 0) return;

        const percentage = (currentVerseIndex / versesList.length) * 100;
        progressBar.style.width = percentage + '%';
        progressBar.setAttribute('aria-valuenow', currentVerseIndex);
        progressTextDisplay.innerText = currentVerseIndex + ' / ' + versesList.length + ' 절 (' + Math.round(percentage) + '%)';

        const typedRatio = totalChapterLength > 0 ? (globalTypedCount / totalChapterLength) : 0;
        const typedPercent = Math.min(Math.round(typedRatio * 100), 100);

        typedProgressBar.style.width = typedPercent + '%';
        typedProgressBar.setAttribute('aria-valuenow', typedPercent);

        if (typedRatio >= SAVE_THRESHOLD) {
            typedProgressBar.classList.remove('bg-info');
            typedProgressBar.classList.add('bg-primary');
            typedPercentDisplay.innerHTML = '<span class="text-primary fw-bold">✨ ' + typedPercent + '% (저장 가능)</span>';
        } else {
            typedProgressBar.classList.remove('bg-primary');
            typedProgressBar.classList.add('bg-info');
            typedPercentDisplay.innerHTML = '<span class="text-danger fw-bold">' + typedPercent + '% (미달)</span>';
        }
    }

    setInterval(() => {
        if (Math.round(displayedWpm) !== targetWpm) {
            displayedWpm += (targetWpm - displayedWpm) * 0.1;
            if (Math.abs(targetWpm - displayedWpm) < 0.5) displayedWpm = targetWpm;
            wpmElement.innerText = Math.round(displayedWpm);
        }
    }, 50);

    setInterval(() => {
        if (dataLoaded && !inputElement.readOnly && !isFinished) {
            seconds++;
            timerElement.innerText = seconds + "초";
            updateWPM();
        }
    }, 1000);

    function generateHtmlForLine(targetStr, typedStr, isCurrent) {
        let html = '';
        let targetIdx = 0;
        let typedIdx = 0;
        let hasCursor = false;

        typedStr = typedStr || "";

        while (typedIdx < typedStr.length && targetIdx < targetStr.length) {
            let isLast = (typedIdx === typedStr.length - 1);

            if (typedStr[typedIdx] === targetStr[targetIdx]) {
                html += '<span class="text-dark">' + targetStr[targetIdx] + '</span>';
            } else {
                let char = typedStr[typedIdx] === ' ' ? targetStr[targetIdx] : typedStr[typedIdx];
                if (isCurrent && isLast) {
                    html += '<span class="text-danger" style="background-color: #f8d7da; text-decoration: underline; text-decoration-thickness: 3px; text-underline-offset: 6px;">' + char + '</span>';
                    hasCursor = true;
                } else {
                    html += '<span class="text-danger" style="background-color: #f8d7da;">' + char + '</span>';
                }
            }
            targetIdx++;
            typedIdx++;
        }

        while (typedIdx < typedStr.length) {
            const char = typedStr[typedIdx];
            let isLast = (typedIdx === typedStr.length - 1);

            if (isCurrent && isLast) {
                html += '<span class="text-danger" style="background-color: #f8d7da; text-decoration: underline; text-decoration-thickness: 3px; text-underline-offset: 6px;">' + char + '</span>';
                hasCursor = true;
            } else {
                html += '<span class="text-danger" style="background-color: #f8d7da;">' + char + '</span>';
            }
            typedIdx++;
        }

        if (isCurrent && targetIdx < targetStr.length) {
            const char = targetStr[targetIdx];
            if (!hasCursor) {
                html += '<span style="color: #adb5bd; text-decoration: underline; text-decoration-thickness: 3px; text-underline-offset: 6px;">' + char + '</span>';
            } else {
                html += '<span style="color: #adb5bd;">' + char + '</span>';
            }
            targetIdx++;
        }

        while (targetIdx < targetStr.length) {
            html += '<span style="color: #adb5bd;">' + targetStr[targetIdx] + '</span>';
            targetIdx++;
        }

        return html;
    }

    function updateDisplay() {
        if (!dataLoaded || !versesList || versesList.length === 0) return;

        const startIdx = Math.floor(currentVerseIndex / CHUNK_SIZE) * CHUNK_SIZE;
        const endIdx = Math.min(startIdx + CHUNK_SIZE, versesList.length);

        let html = '';

        for (let i = startIdx; i < endIdx; i++) {
            const verseData = versesList[i];
            const verseNumHtml = '<span class="text-primary me-3 fw-bold" style="font-size: 1.1rem; user-select: none; flex-shrink: 0; min-width: 35px; text-align: right; display: inline-block;">' + verseData.verse + '</span>';

            let lineHtml = '';
            if (i < currentVerseIndex) {
                lineHtml = generateHtmlForLine(verseData.content, typedHistory[i], false);
            } else if (i === currentVerseIndex) {
                lineHtml = generateHtmlForLine(verseData.content, inputElement.value, true);
            } else {
                lineHtml = generateHtmlForLine(verseData.content, "", false);
            }

            const bgClass = (i === currentVerseIndex) ? "bg-light rounded-3 p-2" : "p-2";
            html += '<div class="mb-2 d-flex align-items-start ' + bgClass + '">' + verseNumHtml + '<div class="flex-grow-1">' + lineHtml + '</div></div>';
        }

        fakeDisplay.innerHTML = html;
    }

    inputElement.addEventListener('input', function() {
        if (!dataLoaded) return;

        const targetSentence = versesList[currentVerseIndex].content;
        const maxAllowedLength = targetSentence.length + 10;
        if (this.value.length > maxAllowedLength) {
            this.value = this.value.substring(0, maxAllowedLength);
        }

        if (sentenceStartTime === 0 && this.value.length > 0) {
            sentenceStartTime = Date.now();
            isTyping = true;
        }
        updateDisplay();
        updateWPM();
        updateAccuracy();
    });

    function getTestament(bookCodeEn) {
        if (!bookCodeEn) return "구약";
        const oldTestamentCodes = [
            'gen', 'exo', 'lev', 'num', 'deu', 'jos', 'jdg', 'rut', '1sa', '2sa', '1ki', '2ki',
            '1ch', '2ch', 'ezr', 'neh', 'est', 'job', 'psa', 'pro', 'ecc', 'sng', 'sol', 'isa',
            'jer', 'lam', 'ezk', 'dan', 'hos', 'jol', 'joe', 'amo', 'oba', 'jon', 'mic', 'nah',
            'nam', 'hab', 'zep', 'hag', 'zec', 'mal'
        ];
        return oldTestamentCodes.includes(bookCodeEn.toLowerCase()) ? "구약" : "신약";
    }

    function sendDataToServer() {
        let avgWpmVal = 0;
        if (globalTotalSeconds > 0) {
            avgWpmVal = Math.round(globalTotalStrokes / (globalTotalSeconds / 60));
        }

        let totalAccVal = 100;
        if (globalTypedCount > 0) {
            totalAccVal = Math.round((globalCorrectCount / globalTypedCount) * 100);
        }

        // 서버 전송 전, bibleData를 한 번 더 체크해서 완벽하게 매핑된 약어를 사용
        const finalBookCodeKo = getMappedBookCodeKo(globalBookCodeEn) || globalBookCodeKo;

        const resultData = {
            practiceType: "long",
            bookCodeKo: finalBookCodeKo,
            bookCodeEn: globalBookCodeEn,
            title: apiData.bookNameKo || finalBookCodeKo || "성경",
            chapter: globalChapter,
            speed: avgWpmVal,
            testament: getTestament(globalBookCodeEn),
            accuracy: totalAccVal,
            duration: Math.round(globalTotalSeconds)
        };

        console.log("=== 백엔드로 전송할 장문 연습 기록 데이터 ===");
        console.table(resultData);

        const saveUrl = "<%=request.getContextPath()%>/api/verses/long-records";

        fetch(saveUrl, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8"
            },
            body: JSON.stringify(resultData)
        })
            .then(res => {
                if (!res.ok) {
                    throw new Error("HTTP 전송 오류 (상태코드: " + res.status + ")");
                }
                return res.json();
            })
            .then(data => {
                console.log("✔ 기록이 성공적으로 DB에 저장되었습니다.", data);
            })
            .catch(err => {
                console.error("❌ 기록 저장에 실패했습니다:", err);
            });
    }

    function showResultModal() {
        const modal = document.getElementById('resultModalOverlay');
        const userNic = "${not empty sessionScope.loggedInUser ? sessionScope.loggedInUser.userNic : '회원'}";

        const typedRatio = totalChapterLength > 0 ? (globalTypedCount / totalChapterLength) : 0;
        const isPassed = typedRatio >= SAVE_THRESHOLD;

        if (!isPassed) {
            document.getElementById('modalIcon').innerText = "⌨️";
            document.getElementById('modalTitle').innerHTML = '<span style="color: #ff9f43;">' + userNic + '</span>님 아쉬워요!';
            document.getElementById('modalCompletionText').innerText = "입력 분량이 부족하여 연습 기록으로 인정되지 않았습니다.";
            document.getElementById('modalThresholdText').innerText = Math.round(SAVE_THRESHOLD * 100);
            document.getElementById('modalStatsSection').style.display = "none";
            document.getElementById('modalEmptyMessage').style.display = "block";
        } else {
            document.getElementById('modalIcon').innerText = "🎉";
            document.getElementById('modalTitle').innerHTML = '<span style="color: #0d6efd;">' + userNic + '</span>님 수고하셨습니다!';
            document.getElementById('modalCompletionText').innerText = "선택하신 장문 연습을 완수했습니다.";
            document.getElementById('modalStatsSection').style.display = "block";
            document.getElementById('modalEmptyMessage').style.display = "none";

            const min = Math.floor(seconds / 60);
            const sec = seconds % 60;
            document.getElementById('modalTotalTime').innerText = min > 0 ? min + "분 " + sec + "초" : sec + "초";

            let avgWpm = 0;
            if (globalTotalSeconds > 0) avgWpm = Math.round(globalTotalStrokes / (globalTotalSeconds / 60));
            document.getElementById('modalAvgWpm').innerText = avgWpm + " 타";
            let avgWpmWidth = Math.min((avgWpm / 1000) * 100, 100);
            document.getElementById('modalAvgWpmBar').setAttribute('data-width', avgWpmWidth + "%");

            let totalAcc = 100;
            if (globalTypedCount > 0) totalAcc = Math.round((globalCorrectCount / globalTypedCount) * 100);
            document.getElementById('modalTotalAcc').innerText = totalAcc + " %";
            document.getElementById('modalTotalAccBar').setAttribute('data-width', totalAcc + "%");

            document.getElementById('modalMaxWpm').innerText = maxWpm + " 타";
            let maxWpmWidth = Math.min((maxWpm / 1000) * 100, 100);
            document.getElementById('modalMaxWpmBar').setAttribute('data-width', maxWpmWidth + "%");
        }

        modal.classList.add('show');

        setTimeout(() => {
            if (isPassed) {
                document.querySelectorAll('.neon-bar').forEach(bar => {
                    bar.style.width = bar.getAttribute('data-width');
                });
            }
        }, 300);
    }

    inputElement.addEventListener('keydown', function(e) {
        if (!dataLoaded || isFinished || isProcessing) return;

        if (e.repeat && (e.key === 'Enter' || e.code === 'Enter')) return;

        if (e.isComposing && (e.key === 'Enter' || e.code === 'Enter')) return;

        const targetSentence = versesList[currentVerseIndex].content;

        const currentPageStart = Math.floor(currentVerseIndex / CHUNK_SIZE) * CHUNK_SIZE;
        const nextPageStart = currentPageStart + CHUNK_SIZE;
        const isLastOfPage = (currentVerseIndex === nextPageStart - 1) || (currentVerseIndex === versesList.length - 1);

        const isEnter = e.key === 'Enter' || e.code === 'Enter';
        const isSpaceKey = e.key === ' ' || e.code === 'Space';

        const requiredLen = targetSentence.trimEnd().length;

        const isSpaceAtEnd = isSpaceKey && this.value.length >= requiredLen;

        if (isEnter || (isSpaceAtEnd && isLastOfPage)) {
            e.preventDefault();

            isProcessing = true;
            this.readOnly = true;

            setTimeout(() => {
                const typed = this.value;
                let finalSentenceWpm = targetWpm;

                if (typed.trim().length > 0) {
                    let currentCorrect = 0;
                    for (let i = 0; i < targetSentence.length; i++) {
                        if (i < typed.length && typed[i] === targetSentence[i]) {
                            currentCorrect++;
                        }
                    }
                    globalCorrectCount += currentCorrect;
                    globalTypedCount += typed.length;

                    const strokes = getStrokeCount(typed);
                    const elapsedSeconds = Math.max((Date.now() - sentenceStartTime) / 1000, 1);
                    globalTotalStrokes += strokes;
                    globalTotalSeconds += elapsedSeconds;

                    finalSentenceWpm = Math.round(strokes / (elapsedSeconds / 60));
                    if (finalSentenceWpm > maxWpm) maxWpm = finalSentenceWpm;
                }

                for (let i = currentPageStart; i < nextPageStart; i++) {
                    if (i < versesList.length) {
                        if (i === currentVerseIndex) {
                            typedHistory[i] = typed;
                        } else if (i > currentVerseIndex) {
                            typedHistory[i] = "";
                        }
                    }
                }

                let totalAcc = 100;
                if (globalTypedCount > 0) totalAcc = Math.round((globalCorrectCount / globalTypedCount) * 100);
                totalAccuracyElement.innerText = totalAcc + "%";

                let avgWpm = 0;
                if (globalTotalSeconds > 0) avgWpm = Math.round(globalTotalStrokes / (globalTotalSeconds / 60));
                avgWpmElement.innerText = avgWpm;

                isTyping = false;
                targetWpm = finalSentenceWpm;
                displayedWpm = targetWpm;
                wpmElement.innerText = targetWpm;

                currentVerseIndex = nextPageStart;

                updateProgressBar();

                if (currentVerseIndex >= versesList.length) {
                    isFinished = true;
                    updateDisplay();
                    showResultModal();

                    const typedRatio = totalChapterLength > 0 ? (globalTypedCount / totalChapterLength) : 0;
                    if (typedRatio >= SAVE_THRESHOLD) {
                        sendDataToServer();
                    }
                    return;
                }

                this.value = "";
                sentenceStartTime = 0;
                isTyping = false;
                currentAccuracyElement.innerText = "100%";
                this.readOnly = false;
                isProcessing = false;
                this.focus();

                updateDisplay();
            }, 10);
            return;
        }

        if (isSpaceAtEnd && !isLastOfPage) {
            e.preventDefault();

            isProcessing = true;
            this.readOnly = true;

            setTimeout(() => {
                const typed = this.value;
                let finalSentenceWpm = targetWpm;

                if (typed.trim().length > 0) {
                    let currentCorrect = 0;
                    for (let i = 0; i < targetSentence.length; i++) {
                        if (i < typed.length && typed[i] === targetSentence[i]) {
                            currentCorrect++;
                        }
                    }
                    globalCorrectCount += currentCorrect;
                    globalTypedCount += typed.length;

                    const strokes = getStrokeCount(typed);
                    const elapsedSeconds = Math.max((Date.now() - sentenceStartTime) / 1000, 1);
                    globalTotalStrokes += strokes;
                    globalTotalSeconds += elapsedSeconds;

                    finalSentenceWpm = Math.round(strokes / (elapsedSeconds / 60));
                    if (finalSentenceWpm > maxWpm) maxWpm = finalSentenceWpm;
                }

                let totalAcc = 100;
                if (globalTypedCount > 0) totalAcc = Math.round((globalCorrectCount / globalTypedCount) * 100);
                totalAccuracyElement.innerText = totalAcc + "%";

                let avgWpm = 0;
                if (globalTotalSeconds > 0) avgWpm = Math.round(globalTotalStrokes / (globalTotalSeconds / 60));
                avgWpmElement.innerText = avgWpm;

                isTyping = false;
                targetWpm = finalSentenceWpm;
                displayedWpm = targetWpm;
                wpmElement.innerText = targetWpm;

                typedHistory[currentVerseIndex] = typed;
                currentVerseIndex++;

                updateProgressBar();

                this.value = "";
                sentenceStartTime = 0;
                isTyping = false;
                currentAccuracyElement.innerText = "100%";
                this.readOnly = false;
                isProcessing = false;
                this.focus();

                updateDisplay();
            }, 10);
        }
    });

    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);

        globalBookCodeEn = urlParams.get('bookCodeEn') || "";
        globalChapter = parseInt(urlParams.get('chapter'), 10) || 1;

        // URL에서 값을 먼저 찾고, 없으면 bibleData.js에서 추출합니다.
        globalBookCodeKo = urlParams.get('bookCodeKo') || getMappedBookCodeKo(globalBookCodeEn) || "";

        if (globalBookCodeEn && globalChapter) {
            const fetchUrl = "<%=request.getContextPath()%>/api/verses/long-practice"
                + "?bookCodeEn=" + encodeURIComponent(globalBookCodeEn)
                + "&chapter=" + encodeURIComponent(globalChapter);

            fetch(fetchUrl)
                .then(res => {
                    const contentType = res.headers.get("content-type");

                    if (!res.ok) {
                        return res.text().then(text => {
                            throw new Error('HTTP 에러 (상태: ' + res.status + ')');
                        });
                    }
                    if (contentType && contentType.includes("text/html")) {
                        throw new Error("HTML_RETURNED");
                    }
                    return res.json();
                })
                .then(data => {
                    apiData = data;

                    // URL에도 없고 bibleData.js에서도 매핑하지 못한 경우에만 서버에서 받아온 전체 이름 사용
                    if (!globalBookCodeKo && apiData.bookNameKo) {
                        globalBookCodeKo = apiData.bookNameKo;
                    }

                    versesList = apiData.verseList || (Array.isArray(data) ? data : []);

                    if (versesList.length > 0) {
                        dataLoaded = true;
                        typedHistory = new Array(versesList.length).fill("");

                        totalChapterLength = versesList.reduce((sum, v) => sum + v.content.length, 0);

                        progressBar.setAttribute('aria-valuemax', versesList.length);
                        updateProgressBar();

                        const displayName = apiData.bookNameKo || globalBookCodeKo || "성경";
                        referenceElement.innerText = displayName + " " + globalChapter + "장";

                        inputElement.readOnly = false;
                        inputElement.value = "";
                        inputElement.focus();

                        updateDisplay();
                    } else {
                        fakeDisplay.innerHTML = '<span class="text-danger">해당 장에 대한 말씀 데이터가 없습니다.</span>';
                    }
                })
                .catch(err => {
                    console.error("데이터 로드 오류:", err);
                    if (err.message === "HTML_RETURNED" || err.message.indexOf("Unexpected token <") !== -1) {
                        fakeDisplay.innerHTML =
                            '<div class="text-danger text-center p-4">' +
                            '    <h5 class="fw-bold mb-2">⚠️ 데이터를 불러올 수 없습니다.</h5>' +
                            '    <p class="small text-muted mb-0">서버가 데이터 대신 로그인 페이지나 HTML 에러 화면을 반환했습니다. 로그인 상태를 점검해 보세요.</p>' +
                            '</div>';
                    } else {
                        fakeDisplay.innerHTML = '<span class="text-danger">서버와 통신할 수 없거나 데이터 형식이 맞지 않습니다.<br><small>' + err.message + '</small></span>';
                    }
                });
        } else {
            fakeDisplay.innerHTML = '<span class="text-danger">잘못된 접근입니다.<br><small>성경 권 및 장 정보가 URL에 포함되어 있지 않습니다.</small></span>';
        }
    };
</script>
</body>
</html>