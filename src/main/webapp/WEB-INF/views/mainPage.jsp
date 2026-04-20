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
</head>

<body>

    <header>
        <div class="container d-flex justify-content-between align-items-center">
            <div class="navbar-brand-group">
                <img src="/images/bible3.png" class="logo-img">
                <span class="logo-text">BibleTyping</span>
            </div>
            <c:if test="${not empty sessionScope.loggedInUser}">
                <div class="d-flex align-items-center gap-3">
                    <span class="text-white" style="font-size: 0.95rem;">
                        <strong>${sessionScope.loggedInUser.userNm}</strong>님 환영합니다!
                    </span>
                    <a href="/logout" class="btn btn-outline-light btn-sm" style="border-radius: 20px;">로그아웃</a>
                </div>
            </c:if>
        </div>
    </header>

    <div class="container mt-5">

        <div class="row mb-5 text-center">
            <div class="col">
                <h2 class="fw-bold">오늘도 기록을 경신해볼까요? 🚀</h2>
                <p class="text-muted">최근 7일간의 평균 타수는 <strong>${avgWpm} WPM</strong>입니다.</p>
            </div>
        </div>

        <div class="row mb-5">
            <div class="col-md-4 mb-3">
                <div class="card-common text-center p-4">
                    <h5 class="text-muted mb-3" style="font-size: 1rem;">최고 타수</h5>
                    <h2 class="display-6 fw-bold text-primary">${maxWpm} <small style="font-size: 1rem">WPM</small></h2>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card-common text-center p-4">
                    <h5 class="text-muted mb-3" style="font-size: 1rem;">평균 정확도</h5>
                    <h2 class="display-6 fw-bold text-success">${avgAccuracy}%</h2>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card-common text-center p-4">
                    <h5 class="text-muted mb-3" style="font-size: 1rem;">전체 연습 시간</h5>
                    <h2 class="display-6 fw-bold text-info">${totalTime} <small style="font-size: 1rem">분</small></h2>
                </div>
            </div>
        </div>

        <div class="card-common text-center py-5">
            <h3 class="mb-4 fw-bold">연습 준비가 되셨나요?</h3>
            <div class="d-flex justify-content-center gap-4">
                <a href="/shortPractice" class="btn-start shadow-sm" style="width: 220px;">단문 연습 시작</a>
                <button type="button" class="btn-start shadow-sm" style="width: 220px;" data-bs-toggle="modal" data-bs-target="#topicModal">장문 연습 시작</button>
            </div>
        </div>

    </div>
	<div class="modal fade" id="topicModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content" style="border-radius: 20px; border: none;">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title fw-bold">연습 주제 및 장 선택</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <p class="text-muted mb-4">연습하고 싶은 성경 권을 먼저 선택하세요.</p>

                <div class="d-grid gap-3" id="bibleAccordion">

                    <div class="bible-item">
                        <button class="btn btn-outline-primary py-3 fw-bold w-100 mb-2"
                                type="button" data-bs-toggle="collapse" data-bs-target="#collapseGenesis"
                                style="border-radius: 12px;">
                            창세기 (Genesis)
                        </button>
                        <div class="collapse" id="collapseGenesis" data-bs-parent="#bibleAccordion">
                            <div class="card card-body border-0 bg-light chapter-grid">
                                <script>document.write(generateChapterLinks('창세기', 50));</script>
                            </div>
                        </div>
                    </div>

                    <div class="bible-item">
                        <button class="btn btn-outline-primary py-3 fw-bold w-100 mb-2"
                                type="button" data-bs-toggle="collapse" data-bs-target="#collapseJohn"
                                style="border-radius: 12px;">
                            요한복음 (John)
                        </button>
                        <div class="collapse" id="collapseJohn" data-bs-parent="#bibleAccordion">
                            <div class="card card-body border-0 bg-light chapter-grid">
                                <script>document.write(generateChapterLinks('요한복음', 21));</script>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>

<footer class="mt-5 mb-4 text-center text-muted" style="font-size: 0.85rem;">
	&copy; 2026 BibleTyping.
</footer>
</html>

<!-- // 1. 가상의 API 데이터 (나중에 실제 fetch/ajax 결과값으로 대체하세요) -->
<!-- const bibleDataExample = [ -->
<!--     { name: "창세기", chapters: 50 }, -->
<!--     { name: "출애굽기", chapters: 40 }, -->
<!--     { name: "시편", chapters: 150 }, -->
<!--     { name: "요한복음", chapters: 21 }, -->
<!--     { name: "요한계시록", chapters: 22 } -->
<!--     // ... API로부터 66권 데이터를 다 받았다고 가정 -->
<!-- ]; -->

<!-- // 2. 페이지 로드 시 또는 모달 열릴 때 API 호출 시뮬레이션 -->
<!-- $(document).ready(function() { -->
<!--     // 실제로는 여기서 $.ajax나 fetch를 사용하시면 됩니다. -->
<!--     setTimeout(() => { -->
<!--         renderBibleList(bibleDataExample); -->
<!--     }, 500);  -->
<!-- }); -->

<!-- // 3. 성경 목록 랜더링 함수 -->
<!-- function renderBibleList(data) { -->
<!--     const bibleGrid = document.getElementById('bibleGrid'); -->
<!--     bibleGrid.innerHTML = ''; // 로딩 스피너 제거 -->

<!--     data.forEach(bible => { -->
<!--         const btn = document.createElement('button'); -->
<!--         btn.className = 'btn btn-outline-primary'; -->
<!--         btn.innerText = bible.name; -->
<!--         // 클릭 시 해당 성경의 장 수를 넘겨줌 -->
<!--         btn.onclick = () => showStep2(bible.name, bible.chapters); -->
<!--         bibleGrid.appendChild(btn); -->
<!--     }); -->
<!-- } -->

<!-- // 4. 장 목록 랜더링 함수 -->
<!-- function showStep2(bibleName, maxChapter) { -->
<!--     document.getElementById('step1').style.display = 'none'; -->
<!--     document.getElementById('step2').style.display = 'block'; -->
<!--     document.getElementById('modalTitle').innerText = bibleName + " - 장 선택"; -->
<!--     document.getElementById('selectedBibleName').innerText = bibleName; -->

<!--     const chapterGrid = document.getElementById('chapterGrid'); -->
<!--     chapterGrid.innerHTML = '';  -->

<!--     for (let i = 1; i <= maxChapter; i++) { -->
<!--         const btn = document.createElement('a'); -->
<!--         // 실제 연습 페이지로 이동하는 주소 -->
<%--         btn.href = `/practice/long?bible=${encodeURIComponent(bibleName)}&chapter=${i}`; --%>
<!--         btn.className = 'btn btn-outline-secondary btn-sm'; -->
<!--         btn.innerText = i + "장"; -->
<!--         chapterGrid.appendChild(btn); -->
<!--     } -->
<!-- } -->

<!-- function showStep1() { -->
<!--     document.getElementById('step1').style.display = 'block'; -->
<!--     document.getElementById('step2').style.display = 'none'; -->
<!--     document.getElementById('modalTitle').innerText = "연습할 성경 권 선택"; -->
<!-- } -->