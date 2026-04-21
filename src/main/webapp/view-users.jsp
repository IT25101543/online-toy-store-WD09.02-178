<%@ page import="toystore.user.User" %>
<%@ page import="toystore.user.UserService" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToyVault — Users</title>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --bg: #0d0d0f; --surface: #16161a; --surface2: #1e1e24;
            --border: rgba(255,255,255,0.07); --border2: rgba(255,255,255,0.12);
            --accent: #ff6b35; --accent2: #ffd166; --text: #f0ede8;
            --muted: #7a7880; --danger: #f87171; --info: #60a5fa;
        }
        body { font-family: 'DM Sans', sans-serif; background: var(--bg); color: var(--text); min-height: 100vh; }
        .topbar { position: sticky; top: 0; z-index: 100; background: rgba(13,13,15,0.85); backdrop-filter: blur(16px); border-bottom: 1px solid var(--border); padding: 0 2rem; height: 64px; display: flex; align-items: center; justify-content: space-between; }
        .logo { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 1.4rem; letter-spacing: -0.03em; color: var(--text); display: flex; align-items: center; gap: 10px; text-decoration: none; }
        .logo-dot { width: 10px; height: 10px; background: var(--info); border-radius: 50%; animation: pulse 2s ease-in-out infinite; }
        @keyframes pulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:0.5;transform:scale(0.8)} }
        @keyframes fadeIn { from{opacity:0;transform:translateY(12px)} to{opacity:1;transform:translateY(0)} }
        .nav-links { display: flex; align-items: center; gap: 8px; }
        .nav-link { color: var(--muted); font-size: 0.875rem; text-decoration: none; padding: 7px 14px; border-radius: 10px; border: 1px solid transparent; transition: all 0.2s; }
        .nav-link:hover, .nav-link.active { color: var(--text); border-color: var(--border); background: var(--surface); }
        .btn { display: inline-flex; align-items: center; gap: 6px; padding: 0 18px; height: 40px; border-radius: 10px; font-family: 'DM Sans', sans-serif; font-size: 0.875rem; font-weight: 500; cursor: pointer; text-decoration: none; border: none; transition: all 0.2s; white-space: nowrap; }
        .btn-primary { background: var(--info); color: #fff; }
        .btn-primary:hover { background: #93c5fd; transform: translateY(-1px); }
        .btn-ghost { background: var(--surface); color: var(--text); border: 1px solid var(--border); }
        .btn-ghost:hover { border-color: var(--border2); background: var(--surface2); }
        .btn-edit { background: rgba(255,209,102,0.12); color: var(--accent2); border: 1px solid rgba(255,209,102,0.2); padding: 0 12px; height: 32px; font-size: 0.8rem; border-radius: 8px; }
        .btn-edit:hover { background: rgba(255,209,102,0.2); }
        .btn-delete { background: rgba(248,113,113,0.1); color: var(--danger); border: 1px solid rgba(248,113,113,0.18); padding: 0 12px; height: 32px; font-size: 0.8rem; border-radius: 8px; }
        .btn-delete:hover { background: rgba(248,113,113,0.2); }
        .wrapper { max-width: 1300px; margin: 0 auto; padding: 3rem 2rem; animation: fadeIn 0.4s ease both; }
        .page-header { margin-bottom: 3rem; }
        .page-header h1 { font-family: 'Syne', sans-serif; font-weight: 800; font-size: clamp(2rem,4vw,3.2rem); letter-spacing: -0.04em; line-height: 1; margin-bottom: 0.5rem; }
        .page-header h1 span { color: var(--info); }
        .page-header p { color: var(--muted); font-size: 0.95rem; }
        .stats-row { display: grid; grid-template-columns: repeat(auto-fit, minmax(160px, 1fr)); gap: 1rem; margin-bottom: 2.5rem; }
        .stat-card { background: var(--surface); border: 1px solid var(--border); border-radius: 16px; padding: 1.25rem 1.5rem; }
        .stat-label { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.1em; color: var(--muted); margin-bottom: 0.5rem; }
        .stat-value { font-family: 'Syne', sans-serif; font-size: 1.8rem; font-weight: 700; color: var(--info); }
        .toolbar { display: flex; align-items: center; justify-content: space-between; margin-bottom: 1.25rem; flex-wrap: wrap; gap: 12px; }
        .search-box { display: flex; align-items: center; gap: 8px; background: var(--surface); border: 1px solid var(--border); border-radius: 10px; padding: 0 14px; height: 40px; min-width: 240px; transition: border-color 0.2s; }
        .search-box:focus-within { border-color: var(--info); }
        .search-box input { background: none; border: none; outline: none; color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 0.875rem; width: 100%; }
        .search-box input::placeholder { color: var(--muted); }
        .table-wrap { background: var(--surface); border: 1px solid var(--border); border-radius: 20px; overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        thead th { padding: 14px 20px; text-align: left; font-size: 0.72rem; font-weight: 500; text-transform: uppercase; letter-spacing: 0.1em; color: var(--muted); border-bottom: 1px solid var(--border); background: var(--surface2); }
        tbody tr { border-bottom: 1px solid var(--border); transition: background 0.15s; }
        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background: rgba(255,255,255,0.02); }
        tbody td { padding: 16px 20px; font-size: 0.9rem; }
        .user-cell { display: flex; align-items: center; gap: 10px; }
        .avatar { width: 34px; height: 34px; border-radius: 50%; background: rgba(96,165,250,0.15); border: 1px solid rgba(96,165,250,0.25); display: flex; align-items: center; justify-content: center; font-size: 0.72rem; font-weight: 600; color: var(--info); flex-shrink: 0; }
        .user-name { font-weight: 500; }
        .user-id { font-family: monospace; font-size: 0.78rem; color: var(--muted); background: var(--surface2); padding: 2px 8px; border-radius: 6px; border: 1px solid var(--border); }
        .email { color: var(--info); font-size: 0.875rem; }
        .address { color: var(--muted); font-size: 0.85rem; max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display: block; }
        .actions { display: flex; align-items: center; gap: 6px; }
        .empty-state { text-align: center; padding: 5rem 2rem; }
        .empty-state h3 { font-family: 'Syne', sans-serif; font-size: 1.2rem; margin-bottom: 0.5rem; }
        .empty-state p { color: var(--muted); font-size: 0.9rem; margin-bottom: 1.5rem; }
        .footer { text-align: center; padding: 2rem; color: var(--muted); font-size: 0.8rem; border-top: 1px solid var(--border); margin-top: 4rem; }
        @media(max-width:768px){ .wrapper{padding:1.5rem 1rem} .topbar{padding:0 1rem} }
    </style>
</head>
<body>
<%
    UserService service = new UserService();
    List<User> users = service.loadAllUsers();
%>
<nav class="topbar">
    <a href="view-toys.jsp" class="logo"><span class="logo-dot"></span>ToyVault</a>
    <div class="nav-links">
        <a href="view-toys.jsp" class="nav-link">Inventory</a>
        <a href="view-users.jsp" class="nav-link active">Users</a>
        <a href="register.jsp" class="btn btn-primary">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
            Add User
        </a>
    </div>
</nav>
<div class="wrapper">
    <div class="page-header">
        <h1>User <span>Management</span></h1>
        <p>Manage all registered customers and accounts</p>
    </div>
    <div class="stats-row">
        <div class="stat-card">
            <div class="stat-label">Total Users</div>
            <div class="stat-value"><%= users.size() %></div>
        </div>
    </div>
    <div class="toolbar">
        <div class="search-box">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="color:var(--muted);flex-shrink:0"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
            <input type="text" placeholder="Search users..." id="searchInput" onkeyup="filterTable()">
        </div>
        <a href="register.jsp" class="btn btn-ghost">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
            New User
        </a>
    </div>
    <div class="table-wrap">
        <table id="userTable">
            <thead>
                <tr>
                    <th>ID</th><th>Name</th><th>Email</th><th>Address</th><th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (users.isEmpty()) { %>
                <tr><td colspan="5">
                    <div class="empty-state">
                        <h3>No users yet</h3>
                        <p>No accounts registered. Add your first user to get started.</p>
                        <a href="register.jsp" class="btn btn-primary">Add First User</a>
                    </div>
                </td></tr>
                <% } else { for (User user : users) {
                    String[] nameParts = user.getFullName().trim().split("\\s+");
                    String initials = String.valueOf(nameParts[0].charAt(0)).toUpperCase() + (nameParts.length > 1 ? String.valueOf(nameParts[1].charAt(0)).toUpperCase() : "");
                %>
                <tr>
                    <td><span class="user-id"><%= user.getUserID() %></span></td>
                    <td>
                        <div class="user-cell">
                            <div class="avatar"><%= initials %></div>
                            <span class="user-name"><%= user.getFullName() %></span>
                        </div>
                    </td>
                    <td><span class="email"><%= user.getEmail() %></span></td>
                    <td><span class="address" title="<%= user.getAddress() %>"><%= user.getAddress() %></span></td>
                    <td>
                        <div class="actions">
                            <a href="edit-user.jsp?userId=<%= user.getUserID() %>" class="btn btn-edit">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                                Edit
                            </a>
                            <a href="UserDeleteServlet?userId=<%= user.getUserID() %>" class="btn btn-delete"
                               onclick="return confirm('Delete <%= user.getFullName() %>? This cannot be undone.')">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/></svg>
                                Delete
                            </a>
                        </div>
                    </td>
                </tr>
                <% } } %>
            </tbody>
        </table>
    </div>
</div>
<div class="footer">ToyVault &mdash; User Management</div>
<script>
function filterTable() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    document.querySelectorAll('#userTable tbody tr').forEach(r => {
        r.style.display = r.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}
</script>
</body>
</html>
