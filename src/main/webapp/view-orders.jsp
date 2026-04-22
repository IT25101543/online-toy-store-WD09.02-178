<%@ page import="toystore.order.Order" %>
<%@ page import="toystore.order.OrderService" %>
<%@ page import="java.util.List" %>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToyVault — Orders</title>
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
            --info: #60a5fa;
        }
        body { font-family: 'DM Sans', sans-serif; background: var(--bg); color: var(--text); min-height: 100vh; }
        .topbar { position: sticky; top: 0; z-index: 100; background: rgba(13,13,15,0.85); backdrop-filter: blur(16px); border-bottom: 1px solid var(--border); padding: 0 2rem; height: 64px; display: flex; align-items: center; justify-content: space-between; }
        .logo { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 1.4rem; letter-spacing: -0.03em; color: var(--text); display: flex; align-items: center; gap: 10px; text-decoration: none; }
        .logo-dot { width: 10px; height: 10px; background: var(--accent); border-radius: 50%; animation: pulse 2s ease-in-out infinite; }
        @keyframes pulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:0.5;transform:scale(0.8)} }
        .nav-links { display: flex; align-items: center; gap: 8px; }
        .nav-link { color: var(--muted); font-size: 0.875rem; text-decoration: none; padding: 7px 14px; border-radius: 10px; border: 1px solid transparent; transition: all 0.2s; }
        .nav-link:hover, .nav-link.active { color: var(--text); border-color: var(--border); background: var(--surface); }
        .wrapper { max-width: 1300px; margin: 0 auto; padding: 3rem 2rem; }
        .page-header { margin-bottom: 2rem; }
        .page-header h1 { font-family: 'Syne', sans-serif; font-weight: 800; font-size: clamp(2rem,4vw,3.2rem); letter-spacing: -0.04em; line-height: 1; }
        .page-header h1 span { color: var(--accent); }
        .stats-row { display: flex; gap: 1rem; margin-bottom: 2rem; flex-wrap: wrap; }
        .stat-card { background: var(--surface); border: 1px solid var(--border); border-radius: 16px; padding: 1rem 1.5rem; }
        .stat-value { font-family: 'Syne', sans-serif; font-size: 1.8rem; font-weight: 700; color: var(--accent); }
        .stat-label { font-size: 0.75rem; text-transform: uppercase; color: var(--muted); }
        .toolbar { display: flex; align-items: center; justify-content: space-between; margin-bottom: 1.25rem; flex-wrap: wrap; gap: 12px; }
        .search-box { display: flex; align-items: center; gap: 8px; background: var(--surface); border: 1px solid var(--border); border-radius: 10px; padding: 0 14px; height: 40px; min-width: 240px; }
        .search-box input { background: none; border: none; outline: none; color: var(--text); width: 100%; }
        .btn { display: inline-flex; align-items: center; gap: 6px; padding: 0 18px; height: 40px; border-radius: 10px; font-size: 0.875rem; font-weight: 500; cursor: pointer; text-decoration: none; border: none; transition: all 0.2s; }
        .btn-primary { background: var(--accent); color: #fff; }
        .btn-primary:hover { background: #ff8155; }
        .btn-edit { background: rgba(255,209,102,0.12); color: var(--accent2); border: 1px solid rgba(255,209,102,0.2); padding: 0 12px; height: 32px; font-size: 0.8rem; border-radius: 8px; }
        .btn-edit:hover { background: rgba(255,209,102,0.2); }
        .btn-delete { background: rgba(248,113,113,0.1); color: var(--danger); border: 1px solid rgba(248,113,113,0.18); padding: 0 12px; height: 32px; font-size: 0.8rem; border-radius: 8px; }
        .btn-delete:hover { background: rgba(248,113,113,0.2); }
        .table-wrap { background: var(--surface); border: 1px solid var(--border); border-radius: 20px; overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        thead th { padding: 14px 20px; text-align: left; font-size: 0.72rem; font-weight: 500; text-transform: uppercase; color: var(--muted); border-bottom: 1px solid var(--border); background: var(--surface2); }
        tbody tr { border-bottom: 1px solid var(--border); }
        tbody tr:hover { background: rgba(255,255,255,0.02); }
        tbody td { padding: 16px 20px; font-size: 0.9rem; }
        .status-badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 500; }
        .status-pending { background: rgba(255,107,53,0.15); color: var(--accent); }
        .status-shipped { background: rgba(96,165,250,0.15); color: var(--info); }
        .status-delivered { background: rgba(74,222,128,0.15); color: var(--success); }
        .empty-state { text-align: center; padding: 4rem; }
        .footer { text-align: center; padding: 2rem; color: var(--muted); font-size: 0.8rem; border-top: 1px solid var(--border); margin-top: 3rem; }
        @media (max-width: 768px) { .wrapper { padding: 1rem; } thead th, tbody td { padding: 10px 12px; } }
    </style>
</head>
<body>

<%
    OrderService service = new OrderService();
    List<Order> orders = service.loadAllOrders();
%>

<nav class="topbar">
    <a href="view-toys.jsp" class="logo"><span class="logo-dot"></span>ToyVault</a>
    <div class="nav-links">
        <a href="view-toys.jsp" class="nav-link">Inventory</a>
        <a href="view-users.jsp" class="nav-link">Users</a>
        <a href="view-orders.jsp" class="nav-link active">Orders</a>
    </div>
</nav>

<div class="wrapper">
    <div class="page-header">
        <h1>Order <span>Management</span></h1>
    </div>

    <div class="stats-row">
        <div class="stat-card"><div class="stat-value"><%= orders.size() %></div><div class="stat-label">Total Orders</div></div>
    </div>

    <div class="toolbar">
        <div class="search-box"><input type="text" placeholder="Search orders..." id="searchInput" onkeyup="filterTable()"></div>
        <a href="place-order.jsp" class="btn btn-primary">+ New Order</a>
    </div>

    <div class="table-wrap">
        <table id="orderTable">
            <thead><tr><th>Order ID</th><th>User ID</th><th>Toy ID</th><th>Qty</th><th>Date</th><th>Status</th><th>Actions</th></tr></thead>
            <tbody>
                <% if (orders.isEmpty()) { %>
                    <tr><td colspan="7"><div class="empty-state">No orders yet. <a href="place-order.jsp">Place your first order</a></div></td></tr>
                <% } else { for (Order o : orders) {
                    String statusClass = "status-pending";
                    if (o.getStatus().equals("Shipped")) statusClass = "status-shipped";
                    else if (o.getStatus().equals("Delivered")) statusClass = "status-delivered";
                %>
                    <tr>
                        <td><%= o.getOrderID() %></td>
                        <td><%= o.getUserID() %></td>
                        <td><%= o.getToyID() %></td>
                        <td><%= o.getQuantity() %></td>
                        <td><%= o.getOrderDate().toString().replace("T", " ") %></td>
                        <td><span class="status-badge <%= statusClass %>"><%= o.getStatus() %></span></td>
                        <td>
                            <a href="edit-order.jsp?orderID=<%= o.getOrderID() %>" class="btn-edit">Edit</a>
                            <a href="OrderDeleteServlet?orderID=<%= o.getOrderID() %>" class="btn-delete" onclick="return confirm('Delete order?')">Delete</a>
                        </td>
                    </tr>
                <% } } %>
            </tbody>
        </table>
    </div>
</div>

<div class="footer">ToyVault — Order Management</div>

<script>
function filterTable() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    document.querySelectorAll('#orderTable tbody tr').forEach(row => {
        row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}
</script>
</body>
</html>