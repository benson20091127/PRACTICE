// 仙俠主題動態背景與古風雪景特效
window.addEventListener('DOMContentLoaded', function () {
    // 雪山背景圖（使用本地圖片）
    const bgDiv = document.createElement('div');
    bgDiv.style.position = 'fixed';
    bgDiv.style.left = '0';
    bgDiv.style.top = '0';
    bgDiv.style.width = '100vw';
    bgDiv.style.height = '100vh';
    bgDiv.style.zIndex = '-10';
    bgDiv.style.pointerEvents = 'none';
    bgDiv.style.overflow = 'hidden';
    bgDiv.style.backgroundImage = 'url("image.jpg")'; // 使用你的本地圖片
    bgDiv.style.backgroundSize = '100% 100%'; // 強制拉伸填滿整個畫面
    bgDiv.style.backgroundRepeat = 'no-repeat';
    bgDiv.style.backgroundPosition = 'center';
    document.body.appendChild(bgDiv);

    // 飄雪動畫特效（自然雪花）
    const snowContainer = document.createElement('div');
    snowContainer.style.position = 'fixed';
    snowContainer.style.top = '0';
    snowContainer.style.left = '0';
    snowContainer.style.width = '100vw';
    snowContainer.style.height = '100vh';
    snowContainer.style.pointerEvents = 'none';
    snowContainer.style.zIndex = '2147483646';
    snowContainer.style.overflow = 'hidden';
    document.body.appendChild(snowContainer);

    function createSnowflake() {
        const snow = document.createElement('div');
        snow.style.position = 'absolute';
        snow.style.left = Math.random() * 100 + 'vw';
        snow.style.top = '-10px';
        const size = Math.random() * 4 + 2; // 2~6px 小雪花
        snow.style.width = size + 'px';
        snow.style.height = size + 'px';
        snow.style.backgroundColor = '#ffffff';
        snow.style.borderRadius = '50%';
        snow.style.opacity = Math.random() * 0.8 + 0.2;
        snow.style.boxShadow = `0 0 ${size}px rgba(255,255,255,0.6)`;
        const duration = Math.random() * 3 + 6; // 6~9秒
        const drift = Math.random() * 100 - 50; // 左右飄動
        snow.style.transition = `transform ${duration}s linear, opacity 1s`;
        snowContainer.appendChild(snow);

        setTimeout(() => {
            snow.style.transform = `translateY(calc(100vh + 20px)) translateX(${drift}px) rotate(${Math.random() * 360}deg)`;
            snow.style.opacity = 0.1;
        }, 10);

        setTimeout(() => {
            snow.remove();
        }, duration * 1000 + 1500);
    }
    setInterval(createSnowflake, 80);

    // 動態CSS動畫樣式
    const style = document.createElement('style');
    style.textContent = `
        @keyframes glow {
            0%, 100% { text-shadow: 0 0 8px #e6f3ff, 0 0 16px #cce7ff; }
            50% { text-shadow: 0 0 18px #ffffff, 0 0 32px #b3d9ff; }
        }
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-8px); }
        }
        h1, h2, h3, .story-title {
            animation: glow 2.5s ease-in-out infinite alternate;
            font-family: "Ma Shan Zheng", "Noto Serif TC", "STKaiti", "微軟正黑體", serif;
            letter-spacing: 4px;
        }
        .btn {
            animation: float 3s ease-in-out infinite;
            font-family: "Ma Shan Zheng", "Noto Serif TC", "STKaiti", "微軟正黑體", serif;
            letter-spacing: 2px;
        }
        .music-player-fixed {
            position: fixed;
            left: 18px;
            bottom: 18px;
            z-index: 2147483647;
            background: rgba(255,255,255,0.9);
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(100,150,200,0.18);
            padding: 6px 12px 2px 12px;
        }
    `;
    document.head.appendChild(style);

    // 古風音效播放器
    const musicDiv = document.createElement('div');
    musicDiv.className = 'music-player-fixed';
    musicDiv.innerHTML = `
        <audio id="guqinAudio" src="guqin.mp3" controls loop preload="auto" autoplay style="width:180px;vertical-align:middle;">
            您的瀏覽器不支援音樂播放
        </audio>
        <span style="font-family:'Ma Shan Zheng','Noto Serif TC',serif;font-size:1.1em;color:#bfa76f;margin-left:8px;">墨雨雲間-觀雪</span>
    `;
    document.body.appendChild(musicDiv);
});
