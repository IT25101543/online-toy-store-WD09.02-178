<%@ page import="toystore.order.Order" %>
<%@ page import="toystore.order.OrderService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToyVault — Edit Order</title>
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
            --info: #60a5fa;
            --success: #4ade80;
        }
        body { font-family: 'DM Sans', sans-serif; background: var(--bg); color: var(--text); min-height: 100vh; }
        .topbar { position: sticky; top: 0; z-index: 100; background: rgba(13,13,15,0.85); backdrop-filter: blur(16px); border-bottom: 1px solid var(--border); padding: 0 2rem; height: 64px; display: flex; align-items: center; justify-content: space-between; }
        .logo { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 1.4rem; letter-spacing: -0.03em; color: var(--text); display: flex; align-items: center; gap: 10px; text-decoration: none; }
        .logo-dot { width: 10px; height: 10px; background: var(--accent2); border-radius: 50%; animation: pulse 2s ease-in-out infinite; }
        @keyframes pulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:0.5;transform:scale(0.8)} }
        .nav-links { display: flex; align-items: center; gap: 8px; }
        .nav-link { color: var(--muted); font-size: 0.875rem; text-decoration: none; padding: 7px 14px; border-radius: 10px; border: 1px solid transparent; transition: all 0.2s; }
        .nav-link:hover, .nav-link.active { color: var(--text); border-color: var(--border); background: var(--surface); }
        .back-link { display: inline-flex; align-items: center; gap: 6px; color: var(--muted); font-size: 0.875rem; text-decoration: none; padding: 8px 14px; border-radius: 10px; border: 1px solid var(--border); background: var(--surface); }
        .back-link:hover { color: var(--text); border-color: var(--border2); }
        .wrapper { max-width: 600px; margin: 0 auto; padding: 3rem 2rem; }
        .page-header { margin-bottom: 2rem; }
        .breadcrumb { display: flex; align-items: center; gap: 6px; color: var(--muted); font-size: 0.8rem; margin-bottom: 1rem; }
        .breadcrumb a { color: var(--muted); text-decoration: none; }
        .page-header h1 { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 2rem; letter-spacing: -0.04em; }
        .page-header h1 span { color: var(--accent2); }
        .form-card { background: var(--surface); border: 1px solid rgba(255,209,102,0.1); border-radius: 24px; padding: 2rem; }
        .form-card::before { content: ''; position: absolute; top: 0; left: 0; right: 0; height: 3px; background: linear-gradient(90deg, var(--accent2), var(--accent)); }
        .form-card { position: relative; }
        .form-group { display: flex; flex-direction: column; gap: 6px; margin-bottom: 1.25rem; }
        label { font-size: 0.78rem; font-weight: 500; text-transform: uppercase; letter-spacing: 0.08em; color: var(--muted); }
        input, select { background: var(--surface2); border: 1px solid var(--border); border-radius: 12px; padding: 12px 16px; color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 0.9rem; outline: none; width: 100%; }
        input:focus, select:focus { border-color: var(--accent2); box-shadow: 0 0 0 3px rgba(255,209,102,0.1); }
        input[readonly] { opacity: 0.5; cursor: not-allowed; }
        .divider { height: 1px; background: var(--border); margin: 1.5rem 0; }
        .form-footer { display: flex; align-items: center; gap: 12px; flex-wrap: wrap; }
        .btn { display: inline-flex; align-items: center; gap: 8px; padding: 0 24px; height: 44px; border-radius: 12px; font-size: 0.9rem; font-weight: 500; cursor: pointer; text-decoration: none; border: none; transition: all 0.2s; }
        .btn-submit { background: var(--accent2); color: #1a1400; flex: 1; justify-content: center; }
        .btn-submit:hover { background: #ffe08a; transform: translateY(-1px); }
        .btn-cancel { background: var(--surface2); color: var(--muted); border: 1px solid var(--border); }
        .btn-cancel:hover { color: var(--text); border-color: var(--border2); }
        @media (max-width: 600px) { .wrapper { padding: 1.5rem 1rem; } }
    </style>
</head>
<body>

<%
    String orderID = request.getParameter("orderID");
    OrderService service = new OrderService();
    Order order = service.findOrderById(orderID);
    if (order == null) { response.sendRedirect("view-orders.jsp"); return; }
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
        <div class="breadcrumb"><a href="view-orders.jsp">Orders</a><span>/</span><span>Edit</span></div>
        <h1>Edit <span>Order</span> — <span style="font-size:1rem"><%= order.getOrderID() %></span></h1>
    </div>

    <div class="form-card">
        <form action="OrderEditServlet" method="post">
            <input type="hidden" name="orderID" value="<%= order.getOrderID() %>">
            <div class="form-group"><label>Order ID (locked)</label><input type="text" value="<%= order.getOrderID() %>" readonly></div>
            <div class="form-group"><label>User ID</label><input type="text" name="userID" value="<%= order.getUserID() %>" required></div>
            <div class="form-group"><label>Toy ID</label><input type="text" name="toyID" value="<%= order.getToyID() %>" required></div>
            <div class="form-group"><label>Quantity</label><input type="number" name="quantity" value="<%= order.getQuantity() %>" min="1" required></div>
            <div class="form-group"><label>Status</label>
                <select name="status">
                    <option value="Pending" <%= order.getStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
                    <option value="Shipped" <%= order.getStatus().equals("Shipped") ? "selected" : "" %>>Shipped</option>
                    <option value="Delivered" <%= order.getStatus().equals("Delivered") ? "selected" : "" %>>Delivered</option>
                </select>
            </div>
            <div class="divider"></div>
            <div class="form-footer">
                <a href="view-orders.jsp" class="btn btn-cancel">Cancel</a>
                <button type="submit" class="btn btn-submit">Save Changes</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>