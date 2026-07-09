// 初始化测试数据
function initTestData() {
    // 检查是否已存在测试数据
    if (!localStorage.getItem('testUserInitialized')) {
        // 创建测试普通用户
        const testUser = {
            username: 'user123',
            password: '123456',
            email: 'user@test.com',
            role: 'user',
            registerDate: '2024-01-15'
        };
        
        // 创建测试管理员
        const testAdmin = {
            username: 'admin',
            password: 'admin123',
            email: 'admin@test.com',
            role: 'admin',
            registerDate: '2024-01-01'
        };
        
        // 存储到 localStorage
        localStorage.setItem('testUser', JSON.stringify(testUser));
        localStorage.setItem('testAdmin', JSON.stringify(testAdmin));
        localStorage.setItem('testUserInitialized', 'true');
        
        console.log('测试数据初始化完成');
        console.log('普通用户：username=user123, password=123456');
        console.log('管理员：username=admin, password=admin123');
    }
}

// 检查登录状态（仅检查，不跳转）
// 注意：此函数仅在 userindex.html 入口页面调用，其他页面不应调用
function checkLogin() {
    const isLoggedIn = localStorage.getItem('isLoggedIn') === 'true';
    
    // 如果未登录，跳转到登录页
    if (!isLoggedIn) {
        window.location.href = 'login.jsp';
        return false;
    }
    
    return true;
}

// 检查是否是管理员
function checkAdmin() {
    const isLoggedIn = localStorage.getItem('isLoggedIn');
    const userRole = localStorage.getItem('userRole');
    
    if (!isLoggedIn || userRole !== 'admin') {
        // 根据当前路径返回首页
        if (window.location.pathname.includes('/admin/')) {
            window.location.href = '../index.html';
        } else {
            window.location.href = 'index.jsp';
        }
        return false;
    }
    return true;
}

// 获取当前用户信息
function getCurrentUser() {
    const username = localStorage.getItem('username');
    const userRole = localStorage.getItem('userRole');
    
    if (!username) {
        return null;
    }
    
    return {
        username: username,
        role: userRole
    };
}

// 退出登录
function logout() {
    console.log('退出登录，清除所有状态...');
    
    // 清除所有登录相关数据
    localStorage.removeItem('isLoggedIn');
    localStorage.removeItem('username');
    localStorage.removeItem('userRole');
    localStorage.removeItem('registerDate');
    
    // 强制跳转到主页（未登录状态）
    window.location.href = '/Movie_Muse/index.html';
}
