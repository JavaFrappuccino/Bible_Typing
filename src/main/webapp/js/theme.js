(function () {
    // 1. 저장된 테마 또는 시스템 설정 확인
    const savedTheme = localStorage.getItem('theme') ||
        (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
    document.documentElement.setAttribute('data-theme', savedTheme);
})();

function toggleTheme() {
    const currentTheme = document.documentElement.getAttribute('data-theme') || 'light';
    const newTheme = currentTheme === 'light' ? 'dark' : 'light';
    document.documentElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
    updateThemeToggleIcons(newTheme);
}

function updateThemeToggleIcons(theme) {
    const btns = document.querySelectorAll('.theme-toggle-btn');
    btns.forEach(btn => {
        if (theme === 'dark') {
            btn.classList.add('dark');
            btn.innerHTML = '☀️ 라이트 모드';
            btn.setAttribute('title', '라이트 모드로 변경');
        } else {
            btn.classList.remove('dark');
            btn.innerHTML = '🌙 다크 모드';
            btn.setAttribute('title', '다크 모드로 변경');
        }
    });
}

document.addEventListener('DOMContentLoaded', function () {
    const theme = document.documentElement.getAttribute('data-theme') || 'light';
    updateThemeToggleIcons(theme);
});
