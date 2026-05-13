<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BibleTyping - 대시보드</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

<!-- 헤더: 단문 연습 페이지와 동일한 크기를 유지하기 위해 내부 여백 클래스 정리 -->
<header class="practice-header">
    <div class="container-fluid px-4 d-flex justify-content-between align-items-center">
        <!-- 상단 좌측: 로고 및 타이틀 (py-2 제거하여 최소 크기 유지) -->
        <div class="navbar-brand-group d-flex align-items-center">
            <img src="/images/bible3.png" class="logo-img me-2" alt="Logo" onerror="this.src='https://cdn-icons-png.flaticon.com/512/3004/3004613.png'" style="height: 30px;">
            <span class="logo-text fs-5 fw-bold">BibleTyping - 대시보드</span>
        </div>

        <!-- 상단 우측: 사용자 정보 및 로그아웃 -->
        <c:if test="${not empty sessionScope.loggedInUser}">
            <div class="d-flex align-items-center">
                <span class="me-3 text-white fw-bold small">${sessionScope.loggedInUser.userNic}님 환영합니다!</span>
                <a href="/logout" class="btn btn-light btn-sm fw-bold text-dark" style="border-radius: 20px; padding: 4px 12px; font-size: 0.8rem;">로그아웃</a>
            </div>
        </c:if>
    </div>
</header>

<main class="dashboard-content">
    <div class="container">
        <div class="row mb-5 text-center">
            <div class="col">
                <h2 class="fw-bold">오늘도 기록을 경신해볼까요? 🚀</h2>
                <p class="text-muted mt-2">최근 7일간의 평균 타수는 <strong class="text-dark">${avgWpm != null ? avgWpm : 0} WPM</strong>입니다.</p>
            </div>
        </div>

        <div class="row mb-5">
            <div class="col-md-4 mb-3">
                <div class="card-common text-center p-4">
                    <h5 class="text-muted mb-3 fw-bold" style="font-size: 0.9rem;">최고 타수</h5>
                    <h2 class="display-6 fw-bold text-primary">${maxWpm != null ? maxWpm : 0} <small class="text-muted" style="font-size: 1rem">WPM</small></h2>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card-common text-center p-4">
                    <h5 class="text-muted mb-3 fw-bold" style="font-size: 0.9rem;">평균 정확도</h5>
                    <h2 class="display-6 fw-bold text-success">${avgAccuracy != null ? avgAccuracy : 0}%</h2>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card-common text-center p-4">
                    <h5 class="text-muted mb-3 fw-bold" style="font-size: 0.9rem;">전체 연습 시간</h5>
                    <h2 class="display-6 fw-bold text-info">${totalTime != null ? totalTime : 0} <small class="text-muted" style="font-size: 1rem">분</small></h2>
                </div>
            </div>
        </div>

        <div class="card-common text-center py-5">
            <h3 class="mb-4 fw-bold">연습 준비가 되셨나요?</h3>
            <div class="d-flex justify-content-center gap-4">
                <a href="/shortPractice" class="btn-start shadow-sm" style="width: 200px;">단문 연습 시작</a>
                <button type="button" class="btn-start shadow-sm" style="width: 200px;" data-bs-toggle="modal" data-bs-target="#longPracticeModal">장문 연습 시작</button>
            </div>
        </div>
    </div>
</main>

<!-- 장문 연습 모달 -->
<div class="modal fade" id="longPracticeModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content shadow-lg">
            <div class="modal-header bg-dark text-white px-4 py-3">
                <h5 class="modal-title fw-bold" id="modalTitle">장문 연습 설정</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4" id="modalBodyContainer">

                <!-- Step 1: 분류 선택 (구약/신약) -->
                <div id="step1">
                    <p class="text-center fw-bold text-secondary mb-4" style="font-size: 1rem;">하나님의 말씀을 따라가볼까요? 구약 또는 신약을 선택해 주세요.</p>
                    <div class="row g-4 justify-content-center">
                        <div class="col-sm-5">
                            <div class="testament-btn old-testament-btn" onclick="goToStep2('old')">
                                <span class="testament-icon">📜</span>
                                <span class="testament-label">구약 성경</span>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="testament-btn new-testament-btn" onclick="goToStep2('new')">
                                <span class="testament-icon">🕊️</span>
                                <span class="testament-label">신약 성경</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Step 2: 성경 권 선택 -->
                <div id="step2" style="display: none;">
                    <div class="btn-back" onclick="handleBackBtn()">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"></polyline></svg>
                        뒤로
                    </div>
                    <h6 class="fw-bold mb-3 d-flex align-items-center">
                        <span id="testamentIconDisplay" class="me-2"></span>
                        <span id="testamentNameDisplay"></span>
                    </h6>
                    <div class="bible-grid" id="bibleList"></div>
                </div>

                <!-- Step 3: 장 선택 -->
                <div id="step3" style="display: none;">
                    <div class="btn-back" onclick="handleBackBtn()">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"></polyline></svg>
                        뒤로
                    </div>
                    <h6 class="fw-bold mb-3 d-flex align-items-center">
                        <span class="me-2" style="color:currentColor">●</span>
                        <span id="selectedBookDisplay"></span> 장 선택
                    </h6>
                    <div class="chapter-grid" id="chapterList"></div>
                </div>

            </div>
        </div>
    </div>
</div>

<footer class="mt-5 mb-4 text-center text-muted" style="font-size: 0.85rem;">
    &copy; 2026 BibleTyping.
</footer>

<script>
    const bibleData = {
        old: [
            { name: "창세기", chapters: 50 }, { name: "출애굽기", chapters: 40 }, { name: "레위기", chapters: 27 },
            { name: "민수기", chapters: 36 }, { name: "신명기", chapters: 34 }, { name: "여호수아", chapters: 24 },
            { name: "사사기", chapters: 21 }, { name: "룻기", chapters: 4 }, { name: "사무엘상", chapters: 31 },
            { name: "사무엘하", chapters: 24 }, { name: "열왕기상", chapters: 22 }, { name: "열왕기하", chapters: 25 },
            { name: "역대상", chapters: 29 }, { name: "역대하", chapters: 36 }, { name: "에스라", chapters: 10 },
            { name: "느헤미야", chapters: 13 }, { name: "에스더", chapters: 10 }, { name: "욥기", chapters: 42 },
            { name: "시편", chapters: 150 }, { name: "잠언", chapters: 31 }, { name: "전도서", chapters: 12 },
            { name: "아가", chapters: 8 }, { name: "이사야", chapters: 66 }, { name: "예레미야", chapters: 52 },
            { name: "예레미야 애가", chapters: 5 }, { name: "에스겔", chapters: 48 }, { name: "다니엘", chapters: 12 },
            { name: "호세아", chapters: 14 }, { name: "요엘", chapters: 3 }, { name: "아모스", chapters: 9 },
            { name: "오바댜", chapters: 1 }, { name: "요나", chapters: 4 }, { name: "미가", chapters: 7 },
            { name: "나훔", chapters: 3 }, { name: "하박국", chapters: 3 }, { name: "스바냐", chapters: 3 },
            { name: "학개", chapters: 2 }, { name: "스가랴", chapters: 14 }, { name: "말라기", chapters: 4 }
        ],
        new: [
            { name: "마태복음", chapters: 28 }, { name: "마가복음", chapters: 16 }, { name: "누가복음", chapters: 24 },
            { name: "요한복음", chapters: 21 }, { name: "사도행전", chapters: 28 }, { name: "로마서", chapters: 16 },
            { name: "고린도전서", chapters: 16 }, { name: "고린도후서", chapters: 13 }, { name: "갈라디아서", chapters: 6 },
            { name: "에베소서", chapters: 6 }, { name: "빌립보서", chapters: 4 }, { name: "골로새서", chapters: 4 },
            { name: "데살로니가전서", chapters: 5 }, { name: "데살로니가후서", chapters: 3 }, { name: "디모데전서", chapters: 6 },
            { name: "디모데후서", chapters: 4 }, { name: "디도서", chapters: 3 }, { name: "빌레몬서", 관리: 1 },
            { name: "히브리서", chapters: 13 }, { name: "야고보서", chapters: 5 }, { name: "베드로전서", chapters: 5 },
            { name: "베드로후서", chapters: 3 }, { name: "요한1서", chapters: 5 }, { name: "요한2서", chapters: 1 },
            { name: "요한3서", chapters: 1 }, { name: "유다서", chapters: 1 }, { name: "요한계시록", chapters: 22 }
        ]
    };

    let currentTestament = '';
    let selectedBook = '';
    let selectedBookChapters = 0;

    /* --- Browser History API 연동 로직 --- */
    function pushState(step) {
        history.pushState({ modalStep: step, testament: currentTestament, book: selectedBook, chapters: selectedBookChapters }, null);
    }

    $(window).on('popstate', function(event) {
        const state = event.originalEvent.state;
        if (state && state.modalStep) {
            renderStep(state.modalStep, state.testament, state.book, state.chapters);
        } else {
            $('#longPracticeModal').modal('hide');
        }
    });

    $('#longPracticeModal').on('shown.bs.modal', function () {
        if (!history.state || !history.state.modalStep) {
            pushState(1);
        }
    });

    $('#longPracticeModal').on('hidden.bs.modal', function () {
        showStep1();
    });

    function handleBackBtn() {
        history.back();
    }

    /* --- 단계별 화면 렌더링 로직 --- */
    function renderStep(step, testament, book, chapters) {
        currentTestament = testament;
        selectedBook = book;
        selectedBookChapters = chapters;

        $('#step1, #step2, #step3').hide();

        if (step === 1) {
            $('#step1').show();
            $('#modalTitle').text("장문 연습 설정");
            $('#modalBodyContainer').removeClass('old-theme new-theme');
        } else if (step === 2) {
            const isOld = (testament === 'old');
            $('#modalBodyContainer').removeClass('old-theme new-theme').addClass(isOld ? 'old-theme' : 'new-theme');
            $('#testamentIconDisplay').text(isOld ? "📜" : "🕊️");
            $('#testamentNameDisplay').text(isOld ? "구약 성경 목록" : "신약 성경 목록");

            const list = isOld ? bibleData.old : bibleData.new;
            const grid = $('#bibleList').empty();
            list.forEach(b => {
                const item = $('<div class="grid-item"></div>').text(b.name);
                item.on('click', () => goToStep3(b.name, b.chapters));
                grid.append(item);
            });
            $('#step2').show();
        } else if (step === 3) {
            $('#selectedBookDisplay').text(book);
            const grid = $('#chapterList').empty();
            for (let i = 1; i <= chapters; i++) {
                const item = $('<div class="grid-item"></div>').text(i + "장");
                item.on('click', () => {
                    location.href = `/practice/long?book=\${encodeURIComponent(book)}&chapter=\${i}`;
                });
                grid.append(item);
            }
            $('#step3').show();
        }
    }

    function showStep1() {
        renderStep(1);
    }

    function goToStep2(testament) {
        currentTestament = testament;
        pushState(2);
        renderStep(2, testament);
    }

    function goToStep3(bookName, chapters) {
        selectedBook = bookName;
        selectedBookChapters = chapters;
        pushState(3);
        renderStep(3, currentTestament, bookName, chapters);
    }
</script>
</body>
</html>