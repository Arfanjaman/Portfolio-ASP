document.addEventListener('DOMContentLoaded', function () {
    console.log('Project.js loaded');

    // GitHub button functionality
    const githubButtons = document.querySelectorAll('.github-btn');
    githubButtons.forEach(button => {
        button.addEventListener('click', (e) => {
            e.stopPropagation();
            const repoUrl = button.getAttribute('data-repo');
            if (repoUrl) {
                window.open(repoUrl, '_blank');
            }
        });
    });

    // Animation for project cards
    const projectCards = document.querySelectorAll('.project-card');
    projectCards.forEach((card, index) => {
        setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, index * 200);
    });

    console.log('Found', projectCards.length, 'project cards');
});