document.addEventListener('DOMContentLoaded', () => {
    // 0. Number Counter (Slot Machine Effect)
    const counters = document.querySelectorAll('.counter');
    const countObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const counter = entry.target;
                const target = +counter.getAttribute('data-target');
                const duration = 4000;
                const increment = target / (duration / 16);

                let current = 0;
                const updateCounter = () => {
                    current += increment;
                    if (current < target) {
                        counter.innerText = Math.ceil(current).toLocaleString();
                        requestAnimationFrame(updateCounter);
                    } else {
                        counter.innerText = target.toLocaleString();
                    }
                };
                updateCounter();
                observer.unobserve(counter);
            }
        });
    }, { threshold: 0.1, rootMargin: "0px 0px -100px 0px" });

    counters.forEach(counter => countObserver.observe(counter));

    // 1. 스크롤 시 요소 나타남 애니메이션 (Reveal)
    const reveals = document.querySelectorAll('.reveal');

    const revealObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('active');
            }
        });
    }, {
        threshold: 0.1
    });

    reveals.forEach(reveal => {
        revealObserver.observe(reveal);
    });

    // 2. FAQ 아코디언 (단순 토글)
    const faqItems = document.querySelectorAll('.faq-item');

    faqItems.forEach(item => {
        const question = item.querySelector('.faq-question');
        const answer = item.querySelector('.faq-answer');

        // Initial state: hidden
        answer.style.display = 'none';

        question.addEventListener('click', () => {
            const isOpen = answer.style.display === 'block';

            // Close all others
            faqItems.forEach(otherItem => {
                otherItem.querySelector('.faq-answer').style.display = 'none';
                otherItem.querySelector('i').style.transform = 'rotate(0deg)';
            });

            if (!isOpen) {
                answer.style.display = 'block';
                question.querySelector('i').style.transform = 'rotate(180deg)';
            }
        });
    });

    // 3. 포트폴리오 스타일 필터링 및 클릭 제어 (이벤트 위임 방식)
    const filterBtns = document.querySelectorAll('.filter-btn');
    const portfolioGrid = document.querySelector('.portfolio-db-grid');
    const projectCards = document.querySelectorAll('.project-card:not(.ongoing)');

    function applyFilter(filter) {
        // 타이틀 업데이트
        const titleMap = {
            'featured': '대표 사례 갤러리',
            'modern': '모던 사례 갤러리',
            'mediterranean': '지중해 사례 갤러리',
            'classic': '클래식 사례 갤러리',
            'all': '전체 건축 사례'
        };
        const galleryTitle = document.getElementById('gallery-title');
        if (galleryTitle && titleMap[filter]) {
            galleryTitle.textContent = titleMap[filter];
        }

        projectCards.forEach(card => {
            let isVisible = false;
            if (filter === 'all') {
                isVisible = true;
            } else if (filter === 'featured') {
                isVisible = card.getAttribute('data-featured') === 'true';
            } else {
                isVisible = card.getAttribute('data-category') === filter;
            }

            if (isVisible) {
                card.style.display = 'block';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            } else {
                card.style.display = 'none';
                card.style.opacity = '0';
            }
        });
    }

    filterBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            filterBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            applyFilter(btn.getAttribute('data-filter'));
        });
    });

    // 프로젝트 클릭 제어 (그리드 레벨에서 이벤트 위임)
    const modal = document.getElementById("project-modal");
    const iframe = document.getElementById("project-iframe");
    const closeModal = document.querySelector(".close-modal");
    const modalTitle = document.querySelector(".modal-title");

    if (portfolioGrid) {
        portfolioGrid.addEventListener('click', function (e) {
            const card = e.target.closest('.clickable-project');
            if (card) {
                const link = card.getAttribute("data-link");
                const title = card.querySelector('h3').textContent;

                if (link && link !== "#") {
                    // PC와 모바일 구분 처리
                    const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);

                    if (!isMobile) {
                        // PC 환경: 새 창으로 열기
                        window.open(link, '_blank');
                    } else {
                        // 모바일 환경: 기존 모달 방식 유지
                        modalTitle.innerHTML = `<i class="fas fa-external-link-alt"></i> ${title} - 상세 보기`;
                        iframe.src = link;
                        modal.style.display = "block";
                        document.body.style.overflow = "hidden"; // 배경 스크롤 방지
                    }
                }
            }
        });
    }

    if (closeModal) {
        closeModal.addEventListener("click", () => {
            modal.style.display = "none";
            iframe.src = ""; // 리소스 해제
            document.body.style.overflow = "auto";
        });
    }

    // 모달 바깥 클릭 시 닫기
    window.addEventListener("click", (event) => {
        if (event.target == modal) {
            if (modal.style.display === "block") {
                modal.style.display = "none";
                iframe.src = "";
                document.body.style.overflow = "auto";
            }
        }
    });

    // 초기 상태: 대표 사례 필터 적용
    applyFilter('featured');

    // 4. 기타 인터렉션 (3D 투어 및 호버)
    const tourCards = document.querySelectorAll('.clickable-tour');
    tourCards.forEach(card => {
        card.addEventListener('click', () => {
            const link = card.getAttribute("data-link");
            const label = card.querySelector('.tour-label').textContent;

            if (link && link !== "#") {
                const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);

                if (!isMobile) {
                    window.open(link, '_blank');
                } else {
                    modalTitle.innerHTML = `<i class="fas fa-vr-cardboard"></i> ${label} - 3D 가상 투어`;
                    iframe.src = link;
                    modal.style.display = "block";
                    document.body.style.overflow = "hidden";
                }
            } else {
                alert('해당 가상 투어 링크가 아직 준비되지 않았습니다.');
            }
        });
    });

    const hoverCards = document.querySelectorAll('.insight-card, .strategic-card, .award-card');
    hoverCards.forEach(card => {
        card.style.transition = 'all 0.3s ease';
    });

    // 5. 수상 경력 이미지 확대 (Lightbox)
    const awardImgContainer = document.querySelector('.clickable-award-img');
    const lightbox = document.createElement('div');
    lightbox.id = 'award-lightbox';
    lightbox.style.cssText = `
        display: none;
        position: fixed;
        z-index: 9999;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.9);
        justify-content: center;
        align-items: center;
    `;

    const lightboxImg = document.createElement('img');
    lightboxImg.style.cssText = `
        max-width: 90%;
        max-height: 90%;
        object-fit: contain;
        box-shadow: 0 0 30px rgba(0,0,0,0.5);
    `;

    const closeBtn = document.createElement('div');
    closeBtn.innerHTML = '<i class="fas fa-times"></i>';
    closeBtn.style.cssText = `
        position: absolute;
        top: 20px;
        right: 20px;
        color: #fff;
        font-size: 2rem;
        cursor: pointer;
        padding: 10px;
    `;

    lightbox.appendChild(lightboxImg);
    lightbox.appendChild(closeBtn);
    document.body.appendChild(lightbox);

    if (awardImgContainer) {
        awardImgContainer.addEventListener('click', () => {
            const img = awardImgContainer.querySelector('img');
            lightboxImg.src = img.src;
            lightbox.style.display = 'flex';
            document.body.style.overflow = 'hidden';
        });
    }

    const closeLightbox = () => {
        lightbox.style.display = 'none';
        document.body.style.overflow = 'auto';
    };

    closeBtn.addEventListener('click', closeLightbox);
    lightbox.addEventListener('click', (e) => {
        if (e.target === lightbox) closeLightbox();
    });
});
