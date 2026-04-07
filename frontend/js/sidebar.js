function renderSidebar(activePage) {
    const links = [
        { href: '/admin/dashboard.html', label: 'Dashboard', icon: `<path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/>` },
        { href: '/admin/courses.html', label: 'Courses', icon: `<path d="M4 19.5A2.5 2.5 0 016.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 014 19.5v-15A2.5 2.5 0 016.5 2z"/>` },
        { href: '/admin/sections.html', label: 'Sections', icon: `<rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/>` },
        { href: '/admin/students.html', label: 'Students', icon: `<path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87"/><path d="M16 3.13a4 4 0 010 7.75"/>` },
        { href: '/admin/enrollments.html', label: 'Enrollments', icon: `<polyline points="9 11 12 14 22 4"/><path d="M21 12v7a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2h11"/>` },
    ];

    const html = `
    <aside style="background:#000908; border-right:1px solid #1A786D20; width:240px; min-height:100vh; display:flex; flex-direction:column; position:fixed; top:0; left:0; z-index:50;">
        <div style="padding:24px 20px; border-bottom:1px solid #1A786D20;">
            <div style="display:flex; align-items:center; gap:12px;">
                <div style="width:36px;height:36px;border-radius:50%;border:1.5px solid #1A786D;display:flex;align-items:center;justify-content:center;background:#1A786D15;">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#83C5BD" stroke-width="1.5"><path d="M12 2L2 7l10 5 10-5-10-5z"/><path d="M2 17l10 5 10-5"/><path d="M2 12l10 5 10-5"/></svg>
                </div>
                <div>
                    <div style="color:#D1EBE8;font-size:0.85rem;font-weight:600;font-family:'DM Serif Display',serif;">LAU Admin</div>
                    <div style="color:#2E8B80;font-size:0.7rem;">Spring 2026</div>
                </div>
            </div>
        </div>
        <nav style="flex:1;padding:16px 12px;display:flex;flex-direction:column;gap:4px;">
            ${links.map(l => {
                const active = activePage === l.href;
                return `<a href="${l.href}" style="display:flex;align-items:center;gap:10px;padding:10px 12px;border-radius:8px;text-decoration:none;font-size:0.85rem;transition:all 0.15s;
                    ${active
                        ? 'background:#1A786D25;color:#83C5BD;border:1px solid #1A786D40;'
                        : 'color:#2E8B80;border:1px solid transparent;'}
                    " onmouseover="if(!this.classList.contains('active')){this.style.background='#1A786D15';this.style.color='#62B1A8';}"
                       onmouseout="if(!this.classList.contains('active')){this.style.background='transparent';this.style.color='#2E8B80';}">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><${l.icon}</svg>
                    ${l.label}
                </a>`;
            }).join('')}
        </nav>
        <div style="padding:16px 12px;border-top:1px solid #1A786D20;">
            <button onclick="logout()" style="display:flex;align-items:center;gap:10px;padding:10px 12px;border-radius:8px;width:100%;background:transparent;border:1px solid transparent;color:#2E8B80;font-size:0.85rem;cursor:pointer;transition:all 0.15s;"
                onmouseover="this.style.background='#3F000015';this.style.color='#ff8080';this.style.borderColor='#ff444430';"
                onmouseout="this.style.background='transparent';this.style.color='#2E8B80';this.style.borderColor='transparent';">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/>
                </svg>
                Sign Out
            </button>
        </div>
    </aside>
    <div style="margin-left:240px;min-height:100vh;background:#000908;">
    `;
    document.body.insertAdjacentHTML('afterbegin', html);
}