/**
 * VIP 会员系统 - 基于在线时长
 * 核心规则：累计浏览时间达到 100 小时后自动获得 VIP 资格
 */

// VIP 系统配置
const VIP_CONFIG = {
    VIP_THRESHOLD: 360000, // 100 小时 = 360000 秒
    DEBUG_THRESHOLD: 363600, // 101 小时 = 363600 秒（调试用）
    STORAGE_KEY: 'userWatchTime',
    VIP_STORAGE_KEY: 'isVip'
};

// VIP 系统主对象
const VIPSystem = {
    // 初始化
    init: function() {
        this.checkVipStatus();
        this.startTimer();
        this.createVipUI();
        this.setupDebugTool();
    },

    // 检查 VIP 状态
    checkVipStatus: function() {
        const totalTime = parseInt(localStorage.getItem(VIP_CONFIG.STORAGE_KEY) || '0');
        const isVip = totalTime >= VIP_CONFIG.VIP_THRESHOLD;
        localStorage.setItem(VIP_CONFIG.VIP_STORAGE_KEY, isVip.toString());
        return isVip;
    },

    // 启动计时器
    startTimer: function() {
        // 每秒更新一次在线时长
        setInterval(() => {
            const currentTime = parseInt(localStorage.getItem(VIP_CONFIG.STORAGE_KEY) || '0');
            const newTime = currentTime + 1;
            localStorage.setItem(VIP_CONFIG.STORAGE_KEY, newTime.toString());
            
            // 检查是否达到 VIP 条件
            if (newTime >= VIP_CONFIG.VIP_THRESHOLD) {
                localStorage.setItem(VIP_CONFIG.VIP_STORAGE_KEY, 'true');
                this.updateVipUI();
            }
            
            this.updateTimeDisplay();
        }, 1000);
    },

    // 创建 VIP 显示 UI
    createVipUI: function() {
        // 创建 VIP 状态显示容器
        const vipContainer = document.createElement('div');
        vipContainer.id = 'vip-status-container';
        vipContainer.style.cssText = `
            position: fixed;
            top: 80px;
            right: 20px;
            z-index: 9999;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            border-radius: 12px;
            padding: 15px 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.1);
            min-width: 280px;
            backdrop-filter: blur(10px);
        `;

        // VIP 内容 HTML
        vipContainer.innerHTML = `
            <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 10px;">
                <i id="vip-icon" class="fas fa-crown" style="font-size: 24px; color: #667eea;"></i>
                <span id="vip-title" style="color: #ffffff; font-weight: 600; font-size: 14px;">在线时长统计</span>
            </div>
            <div id="vip-progress-container" style="background: rgba(255, 255, 255, 0.1); border-radius: 8px; height: 8px; overflow: hidden; margin-bottom: 8px;">
                <div id="vip-progress-bar" style="background: linear-gradient(90deg, #667eea, #764ba2); height: 100%; width: 0%; transition: width 0.3s ease;"></div>
            </div>
            <div id="vip-time-text" style="color: rgba(255, 255, 255, 0.7); font-size: 12px; line-height: 1.5;"></div>
        `;

        document.body.appendChild(vipContainer);
        
        // 初始更新 UI
        this.updateVipUI();
        this.updateTimeDisplay();
    },

    // 更新 VIP UI 状态
    updateVipUI: function() {
        const isVip = this.checkVipStatus();
        const vipIcon = document.getElementById('vip-icon');
        const vipTitle = document.getElementById('vip-title');
        const vipContainer = document.getElementById('vip-status-container');
        const progressBar = document.getElementById('vip-progress-bar');

        if (isVip) {
            // VIP 状态
            if (vipIcon) vipIcon.style.color = '#FFD700';
            if (vipTitle) {
                vipTitle.textContent = '尊贵的 VIP 会员';
                vipTitle.style.background = 'linear-gradient(135deg, #FFD700, #FFA500)';
                vipTitle.style.webkitBackgroundClip = 'text';
                vipTitle.style.webkitTextFillColor = 'transparent';
            }
            if (vipContainer) {
                vipContainer.style.border = '1px solid rgba(255, 215, 0, 0.3)';
                vipContainer.style.boxShadow = '0 8px 32px rgba(255, 215, 0, 0.2)';
            }
            if (progressBar) {
                progressBar.style.background = 'linear-gradient(90deg, #FFD700, #FFA500)';
                progressBar.style.width = '100%';
            }
        } else {
            // 非 VIP 状态
            if (vipIcon) vipIcon.style.color = '#667eea';
            if (vipTitle) {
                vipTitle.textContent = '在线时长统计';
                vipTitle.style.background = 'none';
                vipTitle.style.webkitBackgroundClip = 'unset';
                vipTitle.style.webkitTextFillColor = 'unset';
                vipTitle.style.color = '#ffffff';
            }
            if (vipContainer) {
                vipContainer.style.border = '1px solid rgba(255, 255, 255, 0.1)';
                vipContainer.style.boxShadow = '0 8px 32px rgba(0, 0, 0, 0.3)';
            }
        }
    },

    // 更新时间显示
    updateTimeDisplay: function() {
        const totalTime = parseInt(localStorage.getItem(VIP_CONFIG.STORAGE_KEY) || '0');
        const hours = Math.floor(totalTime / 3600);
        const minutes = Math.floor((totalTime % 3600) / 60);
        const seconds = totalTime % 60;
        
        const timeText = document.getElementById('vip-time-text');
        const progressBar = document.getElementById('vip-progress-bar');
        
        if (timeText) {
            const isVip = this.checkVipStatus();
            if (isVip) {
                timeText.textContent = `累计在线：${hours}小时${minutes}分钟${seconds}秒`;
            } else {
                const remainingTime = VIP_CONFIG.VIP_THRESHOLD - totalTime;
                const remainingHours = Math.floor(remainingTime / 3600);
                const remainingMinutes = Math.floor((remainingTime % 3600) / 60);
                timeText.textContent = `当前：${hours}小时${minutes}分钟 | 距离 VIP 还差 ${remainingHours}小时${remainingMinutes}分钟`;
            }
        }
        
        if (progressBar) {
            const percentage = Math.min((totalTime / VIP_CONFIG.VIP_THRESHOLD) * 100, 100);
            progressBar.style.width = percentage + '%';
        }
    },

    // 设置调试工具
    setupDebugTool: function() {
        // 创建调试按钮
        const debugBtn = document.createElement('button');
        debugBtn.id = 'vip-debug-btn';
        debugBtn.textContent = '🔧 调试：一键 VIP';
        debugBtn.style.cssText = `
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 10000;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
            transition: all 0.3s ease;
        `;
        
        debugBtn.onmouseover = function() {
            this.style.transform = 'translateY(-2px)';
            this.style.boxShadow = '0 6px 20px rgba(102, 126, 234, 0.6)';
        };
        
        debugBtn.onmouseout = function() {
            this.style.transform = 'translateY(0)';
            this.style.boxShadow = '0 4px 15px rgba(102, 126, 234, 0.4)';
        };
        
        debugBtn.onclick = () => {
            localStorage.setItem(VIP_CONFIG.STORAGE_KEY, VIP_CONFIG.DEBUG_THRESHOLD.toString());
            localStorage.setItem(VIP_CONFIG.VIP_STORAGE_KEY, 'true');
            this.updateVipUI();
            this.updateTimeDisplay();
            alert('🎉 调试成功！您已成为 VIP 会员！\n（累计时长已设置为 101 小时）');
        };
        
        document.body.appendChild(debugBtn);

        // 控制台调试命令
        console.log('%c🎬 Movie-Muse VIP 系统调试工具', 'color: #667eea; font-size: 16px; font-weight: bold;');
        console.log('%c使用方法：在控制台输入以下命令直接成为 VIP:', 'color: #ffffff; font-size: 12px;');
        console.log('%cVIPSystem.debugBecomeVip()', 'color: #FFD700; font-size: 14px; font-weight: bold; background: #333; padding: 5px 10px; border-radius: 4px;');
    },

    // 调试：一键成为 VIP（控制台调用）
    debugBecomeVip: function() {
        localStorage.setItem(VIP_CONFIG.STORAGE_KEY, VIP_CONFIG.DEBUG_THRESHOLD.toString());
        localStorage.setItem(VIP_CONFIG.VIP_STORAGE_KEY, 'true');
        this.updateVipUI();
        this.updateTimeDisplay();
        console.log('%c✅ 调试成功！您已成为 VIP 会员！', 'color: #FFD700; font-size: 14px; font-weight: bold;');
        console.log(`当前累计时长：${VIP_CONFIG.DEBUG_THRESHOLD}秒 (101 小时)`);
    }
};

// 页面加载完成后初始化 VIP 系统
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => VIPSystem.init());
} else {
    VIPSystem.init();
}
