<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Deep Space Background Component</title>
    <style>
        /* EXTRACTED SPACE BACKGROUND STYLES
           To use this: 
           1. Copy this <style> block to your CSS.
           2. Copy the <div class="starfield-container"> to the top of your <body>.
           3. Copy the <script> block to the bottom of your <body>.
        */

        :root {
            --space-dark: #070914;
            --star-color: #FFFBE6;
            --nebula-pink: rgba(232, 37, 111, 0.18);
            --nebula-blue: rgba(0, 212, 170, 0.12);
        }

        body {
            margin: 0;
            background: var(--space-dark);
            min-height: 100vh;
        }

        /* Container for everything */
        .starfield-container {
            position: fixed;
            inset: 0;
            z-index: -1; /* Set to -1 so it stays behind content */
            pointer-events: none;
            overflow: hidden;
            background: radial-gradient(circle at 50% 50%, #111835 0%, #070914 100%);
        }

        /* Individual Star Style */
        .star {
            position: absolute;
            background: var(--star-color);
            border-radius: 50%;
            opacity: 0.5;
        }

        /* Twinkle Animation */
        .twinkle {
            animation: twinkle-anim var(--dur) ease-in-out infinite;
        }

        @keyframes twinkle-anim {
            0%, 100% { opacity: 0.2; transform: scale(0.8); }
            50% { opacity: 0.8; transform: scale(1.2); }
        }

        /* Shooting Star Trail */
        .shooting-star {
            position: absolute;
            width: 150px;
            height: 2px;
            background: linear-gradient(90deg, #ffffff, transparent);
            opacity: 0;
            z-index: 1;
            transform: rotate(-35deg);
        }

        .shooting-star-animate {
            animation: shoot 2s ease-out forwards;
        }

        @keyframes shoot {
            0% { transform: translateX(0) translateY(0) rotate(-35deg); opacity: 1; width: 0; }
            30% { width: 150px; }
            100% { transform: translateX(-800px) translateY(560px) rotate(-35deg); opacity: 0; width: 0; }
        }

        /* Nebula Clouds */
        .nebula {
            position: absolute;
            border-radius: 50%;
            filter: blur(100px);
            pointer-events: none;
            z-index: 0;
            opacity: 0.6;
        }

        .nebula-1 { width: 600px; height: 600px; background: var(--nebula-pink); top: -10%; right: -5%; animation: nebula-drift 40s infinite alternate; }
        .nebula-2 { width: 500px; height: 500px; background: var(--nebula-blue); bottom: 10%; left: -5%; animation: nebula-drift 35s infinite alternate-reverse; }

        @keyframes nebula-drift {
            from { transform: translate(0, 0) scale(1); }
            to { transform: translate(50px, 50px) scale(1.1); }
        }

        /* Subtle Static Noise/Grain */
        .starfield-container::after {
            content: '';
            position: absolute;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)'/%3E%3C/svg%3E");
            opacity: 0.05;
            z-index: 2;
        }
    </style>
</head>
<body>

    <!-- Space Background Element -->
    <div class="starfield-container" id="starfield">
        <div class="nebula nebula-1"></div>
        <div class="nebula nebula-2"></div>
    </div>

    <!-- Example Content Overlay -->
    <div style="position: relative; z-index: 10; display: flex; justify-content: center; align-items: center; height: 100vh; color: white; font-family: sans-serif; text-align: center;">
        <div>
            <h1>Space Background Active</h1>
            <p>Wait for a shooting star...</p>
        </div>
    </div>

    <script>
        /**
         * STARFIELD GENERATOR
         */
        function initSpaceBackground() {
            const starfield = document.getElementById('starfield');
            const starCount = 250;
            
            for (let i = 0; i < starCount; i++) {
                const star = document.createElement('div');
                star.className = 'star';
                
                const x = Math.random() * 100;
                const y = Math.random() * 100;
                const size = Math.random() * 2 + 0.5;
                
                if (Math.random() > 0.5) {
                    star.classList.add('twinkle');
                    star.style.setProperty('--dur', (Math.random() * 3 + 2) + 's');
                }

                star.style.left = x + '%';
                star.style.top = y + '%';
                star.style.width = size + 'px';
                star.style.height = size + 'px';
                star.style.opacity = Math.random() * 0.7 + 0.3;
                
                starfield.appendChild(star);
            }
        }

        /**
         * SHOOTING STAR LOGIC
         */
        function createShootingStar() {
            const starfield = document.getElementById('starfield');
            const shootingStar = document.createElement('div');
            shootingStar.className = 'shooting-star';
            
            shootingStar.style.top = Math.random() * 40 + '%';
            shootingStar.style.left = Math.random() * 30 + 70 + '%';
            
            starfield.appendChild(shootingStar);
            
            setTimeout(() => {
                shootingStar.classList.add('shooting-star-animate');
            }, 10);

            setTimeout(() => {
                shootingStar.remove();
            }, 2500);
        }

        // Start the effects
        initSpaceBackground();
        setInterval(() => {
            if (Math.random() > 0.4) createShootingStar();
        }, 6000);
    </script>
</body>
</html>