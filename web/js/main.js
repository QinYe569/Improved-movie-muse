// Search functionality
function performSearch() {
    const searchInput = document.querySelector('.search-btn').previousElementSibling.querySelector('input');
    const query = searchInput.value.trim();
    if (query) {
        window.location.href = `search.html?q=${encodeURIComponent(query)}`;
    }
}

// Mobile Menu Toggle
const mobileMenuBtn = document.getElementById('mobileMenuBtn');
const mobileMenu = document.getElementById('mobileMenu');

if (mobileMenuBtn && mobileMenu) {
    mobileMenuBtn.addEventListener('click', () => {
        mobileMenu.classList.toggle('hidden');
        const icon = mobileMenuBtn.querySelector('i');
        icon.classList.toggle('fa-bars');
        icon.classList.toggle('fa-times');
    });
}

// Filter Tags Toggle
const filterTags = document.querySelectorAll('.filter-tag');

filterTags.forEach(tag => {
    tag.addEventListener('click', () => {
        filterTags.forEach(t => t.classList.remove('active'));
        tag.classList.add('active');
    });
});

// Parallax Effect for Characters
const illustrationArea = document.getElementById('illustrationArea');
const characters = document.querySelectorAll('.character');

if (illustrationArea) {
    illustrationArea.addEventListener('mousemove', (e) => {
        const rect = illustrationArea.getBoundingClientRect();
        const centerX = rect.width / 2;
        const centerY = rect.height / 2;

        const mouseX = e.clientX - rect.left;
        const mouseY = e.clientY - rect.top;

        const offsetX = (mouseX - centerX) / centerX;
        const offsetY = (mouseY - centerY) / centerY;

        characters.forEach((char, index) => {
            const depth = (index + 1) * 5;
            const scale = parseFloat(char.style.getPropertyValue('--scale')) || 1;
            const parallaxX = offsetX * depth * scale + 'px';
            const parallaxY = offsetY * depth * scale + 'px';

            char.style.setProperty('--parallax-x', parallaxX);
            char.style.setProperty('--parallax-y', parallaxY);
        });
    });

    illustrationArea.addEventListener('mouseleave', () => {
        characters.forEach(char => {
            char.style.setProperty('--parallax-x', '0px');
            char.style.setProperty('--parallax-y', '0px');
        });
    });
}
