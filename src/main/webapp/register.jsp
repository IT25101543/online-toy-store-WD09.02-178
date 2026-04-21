<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToyVault — Register User</title>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --bg: #0d0d0f; --surface: #16161a; --surface2: #1e1e24;
            --border: rgba(255,255,255,0.07); --border2: rgba(255,255,255,0.12);
            --accent: #ff6b35; --text: #f0ede8; --muted: #7a7880; --info: #60a5fa;
        }
        body { font-family: 'DM Sans', sans-serif; background: var(--bg); color: var(--text); min-height: 100vh; }
        .topbar { position: sticky; top: 0; z-index: 100; background: rgba(13,13,15,0.85); backdrop-filter: blur(16px); border-bottom: 1px solid var(--border); padding: 0 2rem; height: 64px; display: flex; align-items: center; justify-content: space-between; }
        .logo { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 1.4rem; letter-spacing: -0.03em; color: var(--text); display: flex; align-items: center; gap: 10px; text-decoration: none; }
        .logo-dot { width: 10px; height: 10px; background: var(--info); border-radius: 50%; animation: pulse 2s ease-in-out infinite; }
        @keyframes pulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:0.5;transform:scale(0.8)} }
        @keyframes slideUp { from{opacity:0;transform:translateY(20px)} to{opacity:1;transform:translateY(0)} }
        .back-link { display: inline-flex; align-items: center; gap: 6px; color: var(--muted); font-size: 0.875rem; text-decoration: none; padding: 8px 14px; border-radius: 10px; border: 1px solid var(--border); background: var(--surface); transition: all 0.2s; }
        .back-link:hover { color: var(--text); border-color: var(--border2); }
        .wrapper { max-width: 600px; margin: 0 auto; padding: 3rem 2rem; }
        .page-header { margin-bottom: 2.5rem; }
        .breadcrumb { display: flex; align-items: center; gap: 6px; color: var(--muted); font-size: 0.8rem; margin-bottom: 1rem; }
        .breadcrumb a { color: var(--muted); text-decoration: none; }
        .breadcrumb a:hover { color: var(--text); }
        .page-header h1 { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 2.4rem; letter-spacing: -0.04em; line-height: 1; }
        .page-header h1 span { color: var(--info); }
        .page-header p { color: var(--muted); font-size: 0.9rem; margin-top: 0.5rem; }
        .form-card { background: var(--surface); border: 1px solid var(--border); border-radius: 24px; padding: 2rem; animation: slideUp 0.4s ease both; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem; }
        .form-group { display: flex; flex-direction: column; gap: 6px; }
        .form-group.full { grid-column: 1 / -1; }
        label { font-size: 0.78rem; font-weight: 500; text-transform: uppercase; letter-spacing: 0.08em; color: var(--muted); }
        input { background: var(--surface2); border: 1px solid var(--border); border-radius: 12px; padding: 12px 16px; color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 0.9rem; outline: none; transition: border-color 0.2s, box-shadow 0.2s; width: 100%; }
        input:focus { border-color: var(--info); box-shadow: 0 0 0 3px rgba(96,165,250,0.1); }
        input::placeholder { color: var(--muted); }
        .divider { height: 1px; background: var(--border); margin: 1.5rem 0; }
        .form-footer { display: flex; align-items: center; gap: 12px; flex-wrap: wrap; }
        .btn { display: inline-flex; align-items: center; gap: 8px; padding: 0 24px; height: 44px; border-radius: 12px; font-family: 'DM Sans', sans-serif; font-size: 0.9rem; font-weight: 500; cursor: pointer; text-decoration: none; border: none; transition: all 0.2s; }
        .btn-submit { background: var(--info); color: #fff; flex: 1; justify-content: center; }
        .btn-submit:hover { background: #93c5fd; transform: translateY(-1px); }
        .btn-cancel { background: var(--surface2); color: var(--muted); border: 1px solid var(--border); }
        .btn-cancel:hover { color: var(--text); border-color: var(--border2); }
        .password-wrap { position: relative; }
        .password-wrap input { padding-right: 44px; }
        .toggle-pw { position: absolute; right: 14px; top: 50%; transform: translateY(-50%); background: none; border: none; cursor: pointer; color: var(--muted); padding: 0; display: flex; align-items: center; }
        .toggle-pw:hover { color: var(--text); }
        @media(max-width:600px){ .form-grid{grid-template-columns:1fr} .wrapper{padding:1.5rem 1rem} .topbar{padding:0 1rem} }
    </style>
</head>
<body>
<nav class="topbar">
    <a href="view-toys.jsp" class="logo"><span class="logo-dot"></span>ToyVault</a>
    <a href="view-users.jsp" class="back-link">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="19" y1="12" x2="5" y2="12"/><polyline points="12 19 5 12 12 5"/></svg>
        Back to Users
    </a>
</nav>
<div class="wrapper">
    <div class="page-header">
        <div class="breadcrumb">
            <a href="view-users.jsp">Users</a>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"/></svg>
            <span>Register</span>
        </div>
        <h1>Register <span>User</span></h1>
        <p>Create a new customer or staff account</p>
    </div>
    <div class="form-card">
        <form action="UserServlet" method="post">
            <div class="form-grid">
                <div class="form-group">
                    <label for="userId">User ID</label>
                    <input type="text" id="userId" name="userId" required placeholder="e.g. U003">
                </div>
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" required placeholder="e.g. Jane Smith">
                </div>
                <div class="form-group full">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required placeholder="jane@example.com">
                </div>
                <div class="form-group full">
                    <label for="password">Password</label>
                    <div class="password-wrap">
                        <input type="password" id="password" name="password" required placeholder="Enter password">
                        <button type="button" class="toggle-pw" onclick="togglePw()">
                            <svg id="eyeIcon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                        </button>
                    </div>
                </div>
                <div class="form-group full">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" required placeholder="123 Main Street, City">
                </div>
            </div>
            <div class="divider"></div>
            <div class="form-footer">
                <a href="view-users.jsp" class="btn btn-cancel">Cancel</a>
                <button type="submit" class="btn btn-submit">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                    Register User
                </button>
            </div>
        </form>
    </div>
</div>
<script>
function togglePw() {
    const input = document.getElementById('password');
    input.type = input.type === 'password' ? 'text' : 'password';
}
</script>
</body>
</html>
