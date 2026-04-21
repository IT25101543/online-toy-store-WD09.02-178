<%@ page import="toystore.model1.Toy" %>
<%@ page import="toystore.model1.ToyService" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToyVault — Inventory</title>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --bg: #0d0d0f;
            --surface: #16161a;
            --surface2: #1e1e24;
            --border: rgba(255,255,255,0.07);
            --border2: rgba(255,255,255,0.12);
            --accent: #ff6b35;
            --accent2: #ffd166;
            --text: #f0ede8;
            --muted: #7a7880;
            --success: #4ade80;
            --danger: #f87171;
        }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
        }

        /* Top nav bar */
        .topbar {
            position: sticky;
            top: 0;
            z-index: 100;
            background: rgba(13,13,15,0.85);
            backdrop-filter: blur(16px);
            border-bottom: 1px solid var(--border);
            padding: 0 2rem;
            height: 64px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            font-family: 'Syne', sans-serif;
            font-weight: 800;
            font-size: 1.4rem;
            letter-spacing: -0.03em;
            color: var(--text);
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }

        .logo-dot {
            width: 10px;
            height: 10px;
            background: var(--accent);
            border-radius: 50%;
            display: inline-block;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.5; transform: scale(0.8); }
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-link {
            color: var(--muted);
            font-size: 0.875rem;
            text-decoration: none;
            padding: 7px 14px;
            border-radius: 10px;
            border: 1px solid transparent;
            transition: all 0.2s;
        }

        .nav-link:hover, .nav-link.active {
            color: var(--text);
            border-color: var(--border);
            background: var(--surface);
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        /* Main layout */
        .wrapper {
            max-width: 1300px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }

        .page-header {
            margin-bottom: 3rem;
        }

        .page-header h1 {
            font-family: 'Syne', sans-serif;
            font-weight: 800;
            font-size: clamp(2rem, 4vw, 3.2rem);
            letter-spacing: -0.04em;
            line-height: 1;
            margin-bottom: 0.5rem;
        }

        .page-header h1 span {
            color: var(--accent);
        }

        .page-header p {
            color: var(--muted);
            font-size: 0.95rem;
        }

        /* Stats row */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
            gap: 1rem;
            margin-bottom: 2.5rem;
        }

        .stat-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 1.25rem 1.5rem;
            transition: border-color 0.2s;
        }

        .stat-card:hover { border-color: var(--border2); }

        .stat-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--muted);
            margin-bottom: 0.5rem;
        }

        .stat-value {
            font-family: 'Syne', sans-serif;
            font-size: 1.8rem;
            font-weight: 700;
        }

        .stat-value.orange { color: var(--accent); }
        .stat-value.yellow { color: var(--accent2); }
        .stat-value.green { color: var(--success); }

        /* Toolbar */
        .toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.25rem;
            flex-wrap: wrap;
            gap: 12px;
        }

        .search-box {
            display: flex;
            align-items: center;
            gap: 8px;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 0 14px;
            height: 40px;
            min-width: 240px;
            transition: border-color 0.2s;
        }

        .search-box:focus-within { border-color: var(--accent); }

        .search-box input {
            background: none;
            border: none;
            outline: none;
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            font-size: 0.875rem;
            width: 100%;
        }

        .search-box input::placeholder { color: var(--muted); }

        .search-icon { color: var(--muted); font-size: 14px; }

        /* Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 0 18px;
            height: 40px;
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            border: none;
            transition: all 0.2s;
            white-space: nowrap;
        }

        .btn-primary {
            background: var(--accent);
            color: #fff;
        }

        .btn-primary:hover { background: #ff8155; transform: translateY(-1px); }

        .btn-ghost {
            background: var(--surface);
            color: var(--text);
            border: 1px solid var(--border);
        }

        .btn-ghost:hover { border-color: var(--border2); background: var(--surface2); }

        .btn-edit {
            background: rgba(255,209,102,0.12);
            color: var(--accent2);
            border: 1px solid rgba(255,209,102,0.2);
            padding: 0 12px;
            height: 32px;
            font-size: 0.8rem;
        }

        .btn-edit:hover { background: rgba(255,209,102,0.2); }

        .btn-delete {
            background: rgba(248,113,113,0.1);
            color: var(--danger);
            border: 1px solid rgba(248,113,113,0.18);
            padding: 0 12px;
            height: 32px;
            font-size: 0.8rem;
        }

        .btn-delete:hover { background: rgba(248,113,113,0.2); }

        /* Table */
        .table-wrap {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 20px;
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead th {
            padding: 14px 20px;
            text-align: left;
            font-size: 0.72rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--muted);
            border-bottom: 1px solid var(--border);
            background: var(--surface2);
        }

        tbody tr {
            border-bottom: 1px solid var(--border);
            transition: background 0.15s;
        }

        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background: rgba(255,255,255,0.02); }

        tbody td {
            padding: 16px 20px;
            font-size: 0.9rem;
        }

        .toy-name {
            font-weight: 500;
            color: var(--text);
        }

        .toy-id {
            font-family: 'DM Sans', monospace;
            font-size: 0.78rem;
            color: var(--muted);
            background: var(--surface2);
            padding: 2px 8px;
            border-radius: 6px;
            border: 1px solid var(--border);
        }

        .category-badge {
            background: rgba(255,107,53,0.12);
            color: var(--accent);
            border: 1px solid rgba(255,107,53,0.2);
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 0.78rem;
            font-weight: 500;
        }

        .price {
            font-family: 'Syne', sans-serif;
            font-weight: 600;
            color: var(--accent2);
        }

        .stock-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 0.82rem;
        }

        .stock-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
        }

        .stock-dot.high { background: var(--success); }
        .stock-dot.low { background: var(--accent); }
        .stock-dot.critical { background: var(--danger); }

        .actions {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .empty-state {
            text-align: center;
            padding: 5rem 2rem;
        }

        .empty-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.3;
        }

        .empty-state h3 {
            font-family: 'Syne', sans-serif;
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            color: var(--muted);
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
        }

        /* Footer */
        .footer {
            text-align: center;
            padding: 2rem;
            color: var(--muted);
            font-size: 0.8rem;
            border-top: 1px solid var(--border);
            margin-top: 4rem;
        }

        /* Animations */
        .fade-in {
            animation: fadeIn 0.4s ease both;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(12px); }
            to { opacity: 1; transform: translateY(0); }
        }

        tbody tr {
            animation: fadeIn 0.3s ease both;
        }

        tbody tr:nth-child(1) { animation-delay: 0.05s; }
        tbody tr:nth-child(2) { animation-delay: 0.1s; }
        tbody tr:nth-child(3) { animation-delay: 0.15s; }
        tbody tr:nth-child(4) { animation-delay: 0.2s; }
        tbody tr:nth-child(5) { animation-delay: 0.25s; }

        @media (max-width: 768px) {
            .wrapper { padding: 1.5rem 1rem; }
            .topbar { padding: 0 1rem; }
            table { font-size: 0.82rem; }
            thead th, tbody td { padding: 12px 14px; }
            .stats-row { grid-template-columns: repeat(2, 1fr); }
        }
    </style>
</head>
<body>

<%
    ToyService service = new ToyService();
    List<Toy> toys = service.loadAllToys();
    int totalToys = toys.size();
    double totalValue = 0;
    int totalStock = 0;
    for (Toy t : toys) {
        totalValue += t.getPrice() * t.getStock();
        totalStock += t.getStock();
    }
%>

<nav class="topbar">
    <div class="logo">
        <span class="logo-dot"></span>
        ToyVault
    </div>
    <div class="nav-links">
        <a href="view-toys.jsp" class="nav-link active">Inventory</a>
        <a href="view-users.jsp" class="nav-link">Users</a>
    </div>
    <div class="nav-actions">
        <a href="add-toy.jsp" class="btn btn-primary">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
            Add Toy
        </a>
    </div>
</nav>

<div class="wrapper fade-in">
    <div class="page-header">
        <h1>Toy <span>Inventory</span></h1>
        <p>Manage your store's complete product catalogue</p>
    </div>

    <div class="stats-row">
        <div class="stat-card">
            <div class="stat-label">Total Products</div>
            <div class="stat-value orange"><%= totalToys %></div>
        </div>
        <div class="stat-card">
            <div class="stat-label">Units in Stock</div>
            <div class="stat-value yellow"><%= totalStock %></div>
        </div>
        <div class="stat-card">
            <div class="stat-label">Inventory Value</div>
            <div class="stat-value green">$<%= String.format("%.0f", totalValue) %></div>
        </div>
    </div>

    <div class="toolbar">
        <div class="search-box">
            <span class="search-icon">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
            </span>
            <input type="text" placeholder="Search toys..." id="searchInput" onkeyup="filterTable()">
        </div>
        <a href="add-toy.jsp" class="btn btn-ghost">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
            New Toy
        </a>
    </div>

    <div class="table-wrap">
        <table id="toyTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Brand</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (toys.isEmpty()) { %>
                <tr>
                    <td colspan="7">
                        <div class="empty-state">
                            <div class="empty-icon">🧸</div>
                            <h3>No toys yet</h3>
                            <p>Your inventory is empty. Add your first toy to get started.</p>
                            <a href="add-toy.jsp" class="btn btn-primary">Add First Toy</a>
                        </div>
                    </td>
                </tr>
                <% } else { for (Toy toy : toys) {
                    int stock = toy.getStock();
                    String dotClass = stock > 20 ? "high" : (stock > 5 ? "low" : "critical");
                %>
                <tr>
                    <td><span class="toy-id"><%= toy.getId() %></span></td>
                    <td><span class="toy-name"><%= toy.getName() %></span></td>
                    <td style="color: var(--muted)"><%= toy.getBrand() %></td>
                    <td><span class="category-badge"><%= toy.getCategory() %></span></td>
                    <td><span class="price">$<%= String.format("%.2f", toy.getPrice()) %></span></td>
                    <td>
                        <span class="stock-badge">
                            <span class="stock-dot <%= dotClass %>"></span>
                            <%= stock %>
                        </span>
                    </td>
                    <td>
                        <div class="actions">
                            <a href="edit-toy.jsp?id=<%= toy.getId() %>" class="btn btn-edit">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                                Edit
                            </a>
                            <a href="ToyDeleteServlet?id=<%= toy.getId() %>" class="btn btn-delete"
                               onclick="return confirm('Delete <%= toy.getName() %>? This cannot be undone.')">
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

<div class="footer">
    ToyVault &mdash; Inventory Management System
</div>

<script>
function filterTable() {
    const input = document.getElementById('searchInput').value.toLowerCase();
    const rows = document.querySelectorAll('#toyTable tbody tr');
    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(input) ? '' : 'none';
    });
}
</script>

</body>
</html>
