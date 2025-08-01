document.addEventListener('DOMContentLoaded', function() {
    // For the typing effect
    const typingText = document.querySelector('.typing-text');
    const phrases = [
        'Web Developer',
        'CSE Undergraduate',
        'Frontend Enthusiast',
        'Problem Solver',
        'Tech Explorer'
    ];

    let phraseIndex = 0;
    let charIndex = 0;
    let isDeleting = false;

    function typeEffect() {
        const currentPhrase = phrases[phraseIndex];

        if (isDeleting) {
            typingText.textContent = currentPhrase.substring(0, charIndex - 1);
            charIndex--;
        } else {
            typingText.textContent = currentPhrase.substring(0, charIndex + 1);
            charIndex++;
        }

        let typeSpeed = 100;

        if (isDeleting) {
            typeSpeed /= 2;
        }

        if (!isDeleting && charIndex === currentPhrase.length) {
            typeSpeed = 2000;
            isDeleting = true;
        } else if (isDeleting && charIndex === 0) {
            isDeleting = false;
            phraseIndex = (phraseIndex + 1) % phrases.length;
            typeSpeed = 500;
        }

        setTimeout(typeEffect, typeSpeed);
    }

    // Start typing effect only if element exists
    if (typingText) {
        typeEffect();
    }

    // Enlarged Image Modal
    const profileImage = document.getElementById('profileImage');
    const modal = document.getElementById('imageModal');
    const modalImage = document.getElementById('modalImage');
    const closeBtn = document.querySelector('.close');

    // Check if elements exist before adding event listeners
    if (profileImage && modal && modalImage && closeBtn) {
        profileImage.addEventListener('click', () => {
            modal.style.display = 'block';
            modalImage.src = profileImage.src;
            document.body.style.overflow = 'hidden'; 
        });

        closeBtn.addEventListener('click', () => {
            modal.style.display = 'none';
            document.body.style.overflow = 'auto';
        });

        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.style.display = 'none';
                document.body.style.overflow = 'auto'; 
            }
        });

        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && modal.style.display === 'block') {
                modal.style.display = 'none';
                document.body.style.overflow = 'auto';
            }
        });
    }
});