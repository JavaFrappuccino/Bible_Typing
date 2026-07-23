<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BibleTyping - 대시보드</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/css/style.css">

    <!-- 분리된 성경 데이터 스크립트 임포트 -->
    <script src="/js/bibleData.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


    <script src="/js/theme.js"></script>
</head>

<body>

<header class="practice-header">
    <div class="container-fluid px-4 d-flex justify-content-between align-items-center">
        <div class="navbar-brand-group d-flex align-items-center">
            <img src="/images/bible3.png" class="logo-img me-2" alt="Logo" onerror="this.src='https://cdn-icons-png.flaticon.com/512/3004/3004613.png'" style="height: 30px;">
            <span class="logo-text fs-5 fw-bold">BibleTyping - 대시보드</span>
        </div>

        <c:if test="${not empty sessionScope.loggedInUser}">
            <div class="d-flex align-items-center gap-2">
                <button type="button" class="theme-toggle-btn me-2" onclick="toggleTheme()" aria-label="테마 변경">
                    🌙 모드
                </button>
                <span class="me-3 text-white fw-bold small">${sessionScope.loggedInUser.userNic}님 환영합니다!</span>
                <a href="/logout" class="btn btn-light btn-sm fw-bold text-dark" style="border-radius: 20px; padding: 4px 12px; font-size: 0.8rem;">로그아웃</a>
            </div>
        </c:if>
    </div>
</header>

<main class="dashboard-content mt-5">
    <div class="container">
        <div class="row mb-5 text-center">
            <div class="col">
                <h2 class="fw-bold">오늘도 기록을 경신해볼까요? 🚀</h2>
                <p class="text-muted mt-2">최근 7일간의 평균 타수는 <strong class="text-dark">${history.sevenDayAvgSpeed != null ? history.sevenDayAvgSpeed : 0} WPM</strong>입니다.</p>
            </div>
        </div>

        <!-- 대시보드 주요 요약 카드 영역 (4단 구성) -->
        <div class="row mb-5">
            <!-- 1. 단문 최고 타수 -->
            <div class="col-md-3 col-sm-6 mb-3">
                <div class="card-common text-center p-4">
                    <h5 class="text-muted mb-3 fw-bold" style="font-size: 0.9rem;">단문 최고 타수</h5>
                    <h2 class="display-6 fw-bold text-primary">${user.maxSpeedShort != null ? user.maxSpeedShort : 0} <small class="text-muted" style="font-size: 1rem">WPM</small></h2>
                </div>
            </div>
            <!-- 2. 장문 최고 타수 -->
            <div class="col-md-3 col-sm-6 mb-3">
                <div class="card-common text-center p-4">
                    <h5 class="text-muted mb-3 fw-bold" style="font-size: 0.9rem;">장문 최고 타수</h5>
                    <h2 class="display-6 fw-bold text-primary">${user.maxSpeedLong != null ? user.maxSpeedLong : 0} <small class="text-muted" style="font-size: 1rem">WPM</small></h2>
                </div>
            </div>
            <!-- 3. 평균 정확도 -->
            <div class="col-md-3 col-sm-6 mb-3">
                <div class="card-common text-center p-4">
                    <h5 class="text-muted mb-3 fw-bold" style="font-size: 0.9rem;">평균 정확도</h5>
                    <h2 class="display-6 fw-bold text-success">${history.avgAccuracy != null ? history.avgAccuracy : 0}%</h2>
                </div>
            </div>
            <!-- 4. 전체 연습 시간 -->
            <div class="col-md-3 col-sm-6 mb-3">
                <div class="card-common text-center p-4">
                    <h5 class="text-muted mb-3 fw-bold" style="font-size: 0.9rem;">전체 연습 시간</h5>
                    <h2 class="display-6 fw-bold text-info">${history.totalDuration != null ? history.totalDuration : 0} <small class="text-muted" style="font-size: 1rem"></small></h2>
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
        <div class="modal-content shadow-lg border-0">
            <!-- 모달 헤더 -->
            <div class="modal-header modal-header-custom text-white" style="border-top-left-radius: 20px; border-top-right-radius: 20px; padding: 20px; background-color: #212529;">
                <div class="modal-header-side" style="width: 60px;">
                    <div id="headerBackBtn" onclick="handleBackBtn()" style="cursor: pointer; display: none; align-items: center; gap: 5px;">
                        <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                            <polyline points="15 18 9 12 15 6"></polyline>
                        </svg>
                        <span class="fw-bold">뒤로</span>
                    </div>
                </div>

                <h5 class="modal-title-center flex-grow-1 text-center m-0 fw-bold" id="modalTitle">장문 연습 설정</h5>

                <div class="modal-header-side text-end" style="width: 60px;">
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
            </div>

            <div class="modal-body p-4" id="modalBodyContainer">
                <!-- Step 1: 구약/신약 선택 -->
                <div id="step1">
                    <p class="text-center fw-bold text-secondary mb-4">구약 또는 신약을 선택해 주세요.</p>
                    <div class="row g-4 justify-content-center">
                        <div class="col-sm-5">
                            <div class="testament-btn p-4 text-center rounded-4" onclick="goToStep2('old')">
                                <span class="testament-icon d-block mb-2" style="font-size: 2.5rem;">📜</span>
                                <span class="testament-label fw-bold text-dark fs-5">구약 성경</span>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="testament-btn p-4 text-center rounded-4" onclick="goToStep2('new')">
                                <span class="testament-icon d-block mb-2" style="font-size: 2.5rem;">🕊️</span>
                                <span class="testament-label fw-bold text-dark fs-5">신약 성경</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Step 2: 성경 권 선택 -->
                <div id="step2" style="display: none;">
                    <div class="step-header fw-bold d-flex align-items-center">
                        <span id="testamentIconDisplay" class="me-2 fs-4"></span>
                        <span id="testamentNameDisplay"></span>
                    </div>
                    <div class="modern-grid" id="bibleList"></div>
                </div>

                <!-- Step 3: 장 선택 -->
                <div id="step3" style="display: none;">
                    <div class="step-header fw-bold d-flex align-items-center">
                        <span class="me-2 text-primary fs-5">📖</span>
                        <span><span id="selectedBookDisplay" class="text-primary"></span> 장 선택</span>
                    </div>
                    <div class="chapter-modern-grid" id="chapterList"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="mt-5 mb-4 text-center text-muted" style="font-size: 0.85rem;">
    &copy; 2026 BibleTyping.
</footer>

<script>
    // JS 데이터는 js/bibleData.js에서 bibleData 객체로 불러왔습니다.
    let currentTestament = '';
    let selectedBookObj = null;
    let isNavigating = false; // 페이지 이동 중 상태 플래그

    function pushState(step) {
        history.pushState({ modalStep: step, testament: currentTestament, bookObj: selectedBookObj }, null);
    }

    $(window).on('popstate', function(event) {
        if (isNavigating) return; // 페이지 이동을 위해 히스토리를 되감을 때는 모달 렌더링 무시

        const state = event.originalEvent.state;
        if (state && state.modalStep) {
            renderStep(state.modalStep, state.testament, state.bookObj);
        } else {
            $('#longPracticeModal').modal('hide');
        }
    });

    // BFCache(뒤로가기로 화면 복귀) 대응 및 페이지 로드 시 상태 초기화
    $(window).on('pageshow', function(event) {
        isNavigating = false;

        // 뒤로가기로 대시보드에 복귀했을 때, 백그라운드에서 모달 UI를 1단계로 강제 리셋
        showStep1();

        if (event.originalEvent.persisted || (!history.state || !history.state.modalStep)) {
            // 브라우저 캐시로 인해 모달이 열린 채 복원되었다면 강제 종료
            $('#longPracticeModal').modal('hide');
            $('.modal-backdrop').remove();
            $('body').removeClass('modal-open').css('padding-right', '');
        }
    });

    // 장문 연습 시작 버튼을 눌러 모달을 새로 열 때, 잔여 캐시를 무시하고 항상 1단계 구약/신약 선택 화면이 뜨도록 보장
    $('#longPracticeModal').on('show.bs.modal', function () {
        showStep1();
    });

    $('#longPracticeModal').on('shown.bs.modal', function () {
        if (!history.state || !history.state.modalStep) {
            pushState(1);
        }
    });

    $('#longPracticeModal').on('hidden.bs.modal', function () {
        if (!isNavigating) {
            showStep1();
        }
    });

    function handleBackBtn() {
        history.back();
    }

    // 객체를 넘겨받아 단계별 UI 렌더링
    function renderStep(step, testament, bookObj) {
        currentTestament = testament;
        selectedBookObj = bookObj;

        $('#step1, #step2, #step3').hide();

        if (step === 1) {
            $('#headerBackBtn').hide();
            $('#modalTitle').text("장문 연습 설정");
            $('#step1').show();
        } else {
            $('#headerBackBtn').css('display', 'flex');

            if (step === 2) {
                const isOld = (testament === 'old');
                $('#testamentIconDisplay').text(isOld ? "📜" : "🕊️");
                $('#testamentNameDisplay').text(isOld ? "구약 성경 목록" : "신약 성경 목록");

                const list = isOld ? bibleData.old : bibleData.new;
                const grid = $('#bibleList').empty();

                // 세련된 그리드 버튼 스타일 적용
                list.forEach(bookItem => {
                    const item = $('<div class="modern-btn"></div>').text(bookItem.bookNameKo);
                    item.on('click', () => goToStep3(bookItem));
                    grid.append(item);
                });
                $('#step2').show();
            } else if (step === 3) {
                $('#selectedBookDisplay').text(bookObj.bookNameKo);
                const grid = $('#chapterList').empty();

                // 장 번호 버튼 생성
                for (let i = 1; i <= bookObj.chapters; i++) {
                    const item = $('<div class="chapter-btn"></div>').text(i + "장");

                    item.on('click', (e) => {
                        e.preventDefault();

                        // 1. 중복 클릭 방지 플래그 설정
                        if (isNavigating) return;
                        isNavigating = true;

                        // 2. BFCache 스냅샷 방지: 화면에서 모달 및 백드롭(어두운 배경) 즉시 강제 파괴
                        $('#longPracticeModal').modal('hide');
                        $('.modal-backdrop').remove();
                        $('body').removeClass('modal-open').css('padding-right', '');

                        // 3. 쌓여있는 모달 히스토리 스택(보통 3단계) 파악 후 한 번에 뒤로 되감기
                        const stepsToRewind = (history.state && history.state.modalStep) ? -history.state.modalStep : -3;
                        history.go(stepsToRewind);

                        // JSP EL과 충돌을 막기 위해 템플릿 리터럴을 제거하고 일반 문자열 덧셈 연산으로 쿼리스트링 생성
                        const queryString = "?bookCodeEn=" + encodeURIComponent(bookObj.bookCodeEn) + "&chapter=" + i;

                        // 4. 히스토리가 완전히 백지화된 후 연습 페이지로 안전하게 이동 (150ms 대기)
                        setTimeout(() => {
                            location.href = "/longPractice" + queryString;
                        }, 150);
                    });

                    grid.append(item);
                }
                $('#step3').show();
            }
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

    function goToStep3(bookItem) {
        selectedBookObj = bookItem;
        pushState(3);
        renderStep(3, currentTestament, bookItem);
    }
</script>
</body>
</html>