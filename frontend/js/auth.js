const API = '/api';

function getToken() {
    return localStorage.getItem('token');
}

function getRole() {
    return localStorage.getItem('role');
}

function requireAuth(expectedRole) {
    const token = getToken();
    const role = getRole();
    if (!token) {
        window.location.href = '/login.html';
        return false;
    }
    if (expectedRole && role !== expectedRole) {
        window.location.href = '/login.html';
        return false;
    }
    return true;
}

function logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('role');
    window.location.href = '/login.html';
}

async function apiFetch(path, options = {}) {
    const token = getToken();
    const res = await fetch(`${API}${path}`, {
        ...options,
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`,
            ...(options.headers || {})
        }
    });
    const data = await res.json();
    if (!res.ok) {
        throw new Error(data.message || 'Request failed');
    }
    return data;
}

function showToast(message, type = 'success') {
    const toast = document.getElementById('toast');
    if (!toast) 
        return;
    toast.textContent = message;
    toast.className = `toast ${type} show`;
    setTimeout(() => toast.classList.remove('show'), 3000);
}