document.addEventListener('DOMContentLoaded', function() {
    // Simple fade-in animation on page load
    const credentialCard = document.querySelector('.credential-card');
    if (credentialCard) {
        setTimeout(() => {
            credentialCard.style.opacity = '1';
            credentialCard.style.transform = 'translateY(0)';
        }, 300);
    }
});

function openLightbox(imageSrc) {
    document.getElementById("lightboxModal").style.display = "block";
    document.getElementById("lightboxImage").src = imageSrc;
}

function closeLightbox() {
    document.getElementById("lightboxModal").style.display = "none";
}