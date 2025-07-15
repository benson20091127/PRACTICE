// 仙俠主題 GIF 動態背景
window.addEventListener('DOMContentLoaded', function() {
    const bgDiv = document.createElement('div');
    bgDiv.style.position = 'fixed';
    bgDiv.style.left = '0';
    bgDiv.style.top = '0';
    bgDiv.style.width = '100vw';
    bgDiv.style.height = '100vh';
    bgDiv.style.zIndex = '0';
    bgDiv.style.pointerEvents = 'none';
    bgDiv.style.overflow = 'hidden';
    bgDiv.innerHTML = `
        <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80"
            alt="武俠山水背景"
            style="width:100vw;height:100vh;object-fit:cover;opacity:0.18;pointer-events:none;">
    `;
    document.body.appendChild(bgDiv);

    // 可選：武俠主題音效（開啟自動播放需用者互動觸發）
    // const audio = document.createElement('audio');
    // audio.src = 'https://cdn.pixabay.com/audio/2022/10/16/audio_12b6b7e7e7.mp3'; // 仙俠古風背景音樂
    // audio.loop = true;
    // audio.volume = 0.15;
    // document.body.appendChild(audio);
    // document.body.addEventListener('click', () => { audio.play(); }, {once:true});
});
