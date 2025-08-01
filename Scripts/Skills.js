document.addEventListener('DOMContentLoaded', function() {
    // Animate skill bars on page load
    const skillBars = document.querySelectorAll('.skill-progress');

    // Function to animate skill bars
    function animateSkillBars() {
        skillBars.forEach((bar, index) => {
            setTimeout(() => {
                const width = bar.getAttribute('data-width');
                bar.style.width = width + '%';
            }, index * 200); // Stagger the animations
        });
    }

    // Start animation after a short delay
    setTimeout(animateSkillBars, 500);
    
    // Debug: Check if elements are found
    console.log('Found', skillBars.length, 'skill progress bars');
});