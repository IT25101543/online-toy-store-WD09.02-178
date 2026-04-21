<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToyVault — Add New Toy</title>
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
        }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
        }

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
            width: 10px; height: 10px;
            background: var(--accent);
            border-radius: 50%;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.5; transform: scale(0.8); }
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: var(--muted);
            font-size: 0.875rem;
            text-decoration: none;
            padding: 8px 14px;
            border-radius: 10px;
            border: 1px solid var(--border);
            background: var(--surface);
            transition: all 0.2s;
        }

        .back-link:hover {
            color: var(--text);
            border-color: var(--border2);
        }

        .wrapper {
            max-width: 640px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }

        .page-header {
            margin-bottom: 2.5rem;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 6px;
            color: var(--muted);
            font-size: 0.8rem;
            margin-bottom: 1rem;
        }

        .breadcrumb a { color: var(--muted); text-decoration: none; }
        .breadcrumb a:hover { color: var(--text); }

        .page-header h1 {
            font-family: 'Syne', sans-serif;
            font-weight: 800;
            font-size: 2.4rem;
            letter-spacing: -0.04em;
            line-height: 1;
        }

        .page-header h1 span { color: var(--accent); }

        .page-header p {
            color: var(--muted);
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        .form-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 2rem;
            animation: slideUp 0.4s ease both;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.25rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .form-group.full { grid-column: 1 / -1; }

        label {
            font-size: 0.78rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: var(--muted);
        }

        input[type="text"],
        input[type="number"] {
            background: var(--surface2);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 12px 16px;
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            font-size: 0.9rem;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
            width: 100%;
        }

        input[type="text"]:focus,
        input[type="number"]:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(255,107,53,0.12);
        }

        input::placeholder { color: var(--muted); }

        .input-hint {
            font-size: 0.75rem;
            color: var(--muted);
        }

        .divider {
            height: 1px;
            background: var(--border);
            margin: 1.5rem 0;
        }

        .form-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 0 24px;
            height: 44px;
            border-radius: 12px;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            border: none;
            transition: all 0.2s;
        }

        .btn-submit {
            background: var(--accent);
            color: #fff;
            flex: 1;
            justify-content: center;
        }

        .btn-submit:hover { background: #ff8155; transform: translateY(-1px); }
        .btn-submit:active { transform: translateY(0); }

        .btn-cancel {
            background: var(--surface2);
            color: var(--muted);
            border: 1px solid var(--border);
        }

        .btn-cancel:hover { color: var(--text); border-color: var(--border2); }

        .tip-box {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            background: rgba(255,209,102,0.06);
            border: 1px solid rgba(255,209,102,0.15);
            border-radius: 12px;
            padding: 12px 16px;
            margin-top: 1.5rem;
        }

        .tip-icon { font-size: 14px; margin-top: 1px; flex-shrink: 0; }

        .tip-text {
            font-size: 0.8rem;
            color: rgba(255,209,102,0.7);
            line-height: 1.5;
        }

        @media (max-width: 600px) {
            .form-grid { grid-template-columns: 1fr; }
            .wrapper { padding: 1.5rem 1rem; }
            .topbar { padding: 0 1rem; }
        }
    </style>
</head>
<body>

<nav class="topbar">
    <a href="view-toys.jsp" class="logo">
        <span class="logo-dot"></span>
        ToyVault
    </a>
    <a href="view-toys.jsp" class="back-link">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="19" y1="12" x2="5" y2="12"/><polyline points="12 19 5 12 12 5"/></svg>
        Back to Inventory
    </a>
</nav>

<div class="wrapper">
    <div class="page-header">
        <div class="breadcrumb">
            <a href="view-toys.jsp">Inventory</a>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"/></svg>
            <span>Add New Toy</span>
        </div>
        <h1>Add New <span>Toy</span></h1>
        <p>Fill in the details to add a product to your inventory</p>
    </div>

    <div class="form-card">
        <form action="ToyServlet" method="post">
            <div class="form-grid">

                <div class="form-group">
                    <label for="id">Toy ID</label>
                    <input type="text" id="id" name="id" required placeholder="e.g. T003">
                    <span class="input-hint">Must be unique</span>
                </div>

                <div class="form-group">
                    <label for="brand">Brand</label>
                    <input type="text" id="brand" name="brand" required placeholder="e.g. Mattel">
                </div>

                <div class="form-group full">
                    <label for="name">Toy Name</label>
                    <input type="text" id="name" name="name" required placeholder="e.g. Remote Control Car">
                </div>

                <div class="form-group full">
                    <label for="category">Category</label>
                    <input type="text" id="category" name="category" required placeholder="e.g. Electronic, Soft Toys, Building Blocks">
                </div>

                <div class="form-group">
                    <label for="price">Price (USD)</label>
                    <input type="number" id="price" name="price" step="0.01" min="0" required placeholder="0.00">
                </div>

                <div class="form-group">
                    <label for="stock">Stock Quantity</label>
                    <input type="number" id="stock" name="stock" min="0" required placeholder="0">
                </div>

            </div>

            <div class="divider"></div>

            <div class="form-footer">
                <a href="view-toys.jsp" class="btn btn-cancel">Cancel</a>
                <button type="submit" class="btn btn-submit">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
                    Add to Inventory
                </button>
            </div>
        </form>
    </div>

    <div class="tip-box">
        <span class="tip-icon">💡</span>
        <span class="tip-text">Toy IDs must be unique. Use a consistent format like <strong>T001</strong>, <strong>T002</strong> to keep your inventory organized.</span>
    </div>
</div>

</body>
</html>
