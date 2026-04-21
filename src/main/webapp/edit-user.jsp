<%@ page import="toystore.user.User" %>
<%@ page import="toystore.user.UserService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToyVault — Edit User</title>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --bg: #0d0d0f; --surface: #16161a; --surface2: #1e1e24;
            --border: rgba(255,255,255,0.07); --border2: rgba(255,255,255,0.12);
            --accent2: #ffd166; --text: #f0ede8; --muted: #7a7880; --info: #60a5fa;
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
        .page-header h1 span { color: var(--accent2); }
        .user-meta { display: inline-flex; align-items: center; gap: 8px; margin-top: 0.75rem; background: var(--surface); border: 1px solid var(--border); border-radius: 8px; padding: 6px 14px; font-size: 0.82rem; }
        .user-meta .id-tag { font-family: monospace; color: var(--accent2); font-weight: 600; }
        .user-meta .name-tag { color: var(--muted); }
        .form-card { background: var(--surface); border: 1px solid rgba(255,209,102,0.1); border-radius: 24px; padding: 2rem; animation: slideUp 0.4s ease both; position: relative; overflow: hidden; }
        .form-card::before { content: ''; position: absolute; top: 0; left: 0; right: 0; height: 3px; background: linear-gradient(90deg, var(--accent2), var(--info)); }
        .edit-notice { display: flex; align-items: center; gap: 8px; background: rgba(255,209,102,0.06); border: 1px solid rgba(255,209,102,0.15); border-radius: 10px; padding: 10px 14px; margin-bottom: 1.5rem; font-size: 0.82rem; color: rgba(255,209,102,0.7); }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem; }
        .form-group { display: flex; flex-direction: column; gap: 6px; }
        .form-group.full { grid-column: 1 / -1; }
        label { font-size: 0.78rem; font-weight: 500; text-transform: uppercase; letter-spacing: 0.08em; color: var(--muted); }
        input { background: var(--surface2); border: 1px solid var(--border); border-radius: 12px; padding: 12px 16px; color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 0.9rem; outline: none; transition: border-color 0.2s, box-shadow 0.2s; width: 100%; }
        input:focus { border-color: var(--accent2); box-shadow: 0 0 0 3px rgba(255,209,102,0.1); }
        input[readonly] { opacity: 0.5; cursor: not-allowed; }
        .divider { height: 1px; background: var(--border); margin: 1.5rem 0; }
        .form-footer { display: flex; align-items: center; gap: 12px; flex-wrap: wrap; }
        .btn { display: inline-flex; align-items: center; gap: 8px; padding: 0 24px; height: 44px; border-radius: 12px; font-family: 'DM Sans', sans-serif; font-size: 0.9rem; font-weight: 500; cursor: pointer; text-decoration: none; border: none; transition: all 0.2s; }
        .btn-submit { background: var(--accent2); color: #1a1400; flex: 1; justify-content: center; }
        .btn-submit:hover { background: #ffe08a; transform: translateY(-1px); }
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
<%
    String userId = request.getParameter("userId");
    UserService service = new UserService();
    User user = service.findUserById(userId);
    if (user == null) { response.sendRedirect("view-users.jsp"); return; }
%>
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
            <span>Edit User</span>
        </div>
        <h1>Edit <span>User</span></h1>
        <div class="user-meta">
            <span class="id-tag"><%= user.getUserID() %></span>
            <span style="color:var(--border2)">/</span>
            <span class="name-tag"><%= user.getFullName() %></span>
        </div>
    </div>
    <div class="form-card">
        <div class="edit-notice">
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            You're editing an existing account. The User ID cannot be changed.
        </div>
        <form action="UserEditServlet" method="post">
            <input type="hidden" name="userId" value="<%= user.getUserID() %>">
            <div class="form-grid">
                <div class="form-group full">
                    <label>User ID (locked)</label>
                    <input type="text" value="<%= user.getUserID() %>" readonly>
                </div>
                <div class="form-group full">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" value="<%= user.getFullName() %>" required>
                </div>
                <div class="form-group full">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
                </div>
                <div class="form-group full">
                    <label for="password">Password</label>
                    <div class="password-wrap">
                        <input type="password" id="password" name="password" value="<%= user.getPassword() %>" required>
                        <button type="button" class="toggle-pw" onclick="togglePw()">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                        </button>
                    </div>
                </div>
                <div class="form-group full">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" value="<%= user.getAddress() %>" required>
                </div>
            </div>
            <div class="divider"></div>
            <div class="form-footer">
                <a href="view-users.jsp" class="btn btn-cancel">Cancel</a>
                <button type="submit" class="btn btn-submit">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>
                    Save Changes
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
