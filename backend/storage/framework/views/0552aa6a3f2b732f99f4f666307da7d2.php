<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $__env->yieldContent('title', 'NOERA'); ?></title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Inter+Display:wght@600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --gray-50: #fafafa;
            --gray-100: #f5f5f5;
            --gray-200: #e5e5e5;
            --gray-300: #d4d4d4;
            --gray-400: #a3a3a3;
            --gray-500: #737373;
            --gray-600: #525252;
            --gray-700: #404040;
            --gray-800: #262626;
            --gray-900: #171717;

            --primary: #0066ff;
            --primary-dark: #0052cc;
            --primary-light: #e6f0ff;

            --success: #10b981;
            --success-bg: #ecfdf5;
            --warning: #f59e0b;
            --warning-bg: #fffbeb;
            --error: #ef4444;

            --surface: #ffffff;
            --surface-elevated: #ffffff;
            --surface-overlay: rgba(255, 255, 255, 0.8);

            --border-default: rgba(0, 0, 0, 0.08);
            --border-subtle: rgba(0, 0, 0, 0.04);

            --shadow-xs: 0 1px 2px rgba(0, 0, 0, 0.04);
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.06), 0 1px 2px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.06), 0 2px 4px -2px rgba(0, 0, 0, 0.04);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.08), 0 4px 6px -4px rgba(0, 0, 0, 0.04);

            --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            --font-display: 'Inter Display', 'Inter', sans-serif;

            --space-1: 4px;
            --space-2: 8px;
            --space-3: 12px;
            --space-4: 16px;
            --space-5: 20px;
            --space-6: 24px;
            --space-8: 32px;
            --space-10: 40px;
            --space-12: 48px;

            --radius-sm: 6px;
            --radius-md: 8px;
            --radius-lg: 12px;
            --radius-xl: 16px;
        }

        body {
            font-family: var(--font-sans);
            background: var(--gray-50);
            color: var(--gray-900);
            line-height: 1.5;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 56px;
            background: var(--surface);
            border-bottom: 1px solid var(--border-default);
            display: flex;
            align-items: center;
            padding: 0 var(--space-6);
            z-index: 100;
            gap: var(--space-6);
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: var(--space-3);
            min-width: 220px;
        }

        .navbar-logo {
            width: 32px;
            height: 32px;
            background: var(--primary);
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 16px;
            font-family: var(--font-display);
        }

        .navbar-brand-text {
            font-family: var(--font-display);
            font-size: 18px;
            font-weight: 700;
            color: var(--gray-900);
            letter-spacing: -0.02em;
        }

        .navbar-search {
            flex: 1;
            max-width: 480px;
            position: relative;
        }

        .navbar-search input {
            width: 100%;
            height: 36px;
            padding: 0 var(--space-4) 0 var(--space-10);
            border: 1px solid var(--border-default);
            border-radius: var(--radius-md);
            font-size: 13px;
            background: var(--gray-50);
            color: var(--gray-900);
            transition: all 0.15s ease;
            font-family: var(--font-sans);
        }

        .navbar-search input:hover {
            background: var(--surface);
            border-color: var(--gray-300);
        }

        .navbar-search input:focus {
            outline: none;
            background: var(--surface);
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .navbar-search input::placeholder {
            color: var(--gray-500);
        }

        .navbar-search svg {
            position: absolute;
            left: var(--space-3);
            top: 50%;
            transform: translateY(-50%);
            width: 16px;
            height: 16px;
            color: var(--gray-400);
        }

        .navbar-search kbd {
            position: absolute;
            right: var(--space-3);
            top: 50%;
            transform: translateY(-50%);
            padding: 2px 6px;
            background: var(--surface);
            border: 1px solid var(--border-default);
            border-radius: 4px;
            font-size: 11px;
            color: var(--gray-500);
            font-family: var(--font-sans);
            font-weight: 500;
        }

        .navbar-actions {
            display: flex;
            align-items: center;
            gap: var(--space-2);
            margin-left: auto;
        }

        .nav-icon-btn {
            width: 36px;
            height: 36px;
            border-radius: var(--radius-md);
            border: none;
            background: transparent;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--gray-600);
            position: relative;
            transition: all 0.1s ease;
        }

        .nav-icon-btn:hover {
            background: var(--gray-100);
            color: var(--gray-900);
        }

        .nav-icon-btn svg {
            width: 18px;
            height: 18px;
        }

        .badge-notification {
            position: absolute;
            top: 6px;
            right: 6px;
            width: 7px;
            height: 7px;
            background: var(--error);
            border-radius: 50%;
            border: 1.5px solid var(--surface);
        }

        .badge-count {
            position: absolute;
            top: 3px;
            right: 2px;
            min-width: 17px;
            height: 17px;
            background: var(--error);
            border-radius: 10px;
            border: 2px solid var(--surface);
            font-size: 10px;
            font-weight: 600;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0 4px;
            line-height: 1;
        }

        .navbar-user {
            display: flex;
            align-items: center;
            gap: var(--space-3);
            padding: var(--space-1) var(--space-3) var(--space-1) var(--space-1);
            border-radius: var(--radius-lg);
            cursor: pointer;
            transition: background 0.1s ease;
            margin-left: var(--space-2);
            border: 1px solid transparent;
        }

        .navbar-user:hover {
            background: var(--gray-50);
            border-color: var(--border-default);
        }

        .navbar-user-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: var(--gray-200);
            overflow: hidden;
            flex-shrink: 0;
        }

        .navbar-user-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .navbar-user-info {
            line-height: 1.3;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        .navbar-user-name {
            font-size: 13px;
            font-weight: 600;
            color: var(--gray-900);
            letter-spacing: -0.01em;
        }

        .navbar-user-role {
            font-size: 11px;
            color: var(--gray-500);
            font-weight: 500;
        }

        .navbar-user-arrow {
            color: var(--gray-400);
            margin-left: var(--space-1);
            width: 14px;
            height: 14px;
        }

        .layout {
            display: flex;
            margin-top: 56px;
            min-height: calc(100vh - 56px);
        }

        .sidebar {
            width: 232px;
            background: var(--surface);
            border-right: 1px solid var(--border-default);
            padding: var(--space-4) 0;
            position: fixed;
            height: calc(100vh - 56px);
            overflow-y: auto;
            display: flex;
            flex-direction: column;
        }

        .sidebar-section {
            margin-bottom: var(--space-6);
        }

        .sidebar-section-title {
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--gray-500);
            padding: 0 var(--space-4);
            margin-bottom: var(--space-2);
        }

        .sidebar-nav {
            list-style: none;
        }

        .sidebar-nav li a {
            display: flex;
            align-items: center;
            gap: var(--space-3);
            padding: var(--space-2) var(--space-4);
            margin: 0 var(--space-2);
            border-radius: var(--radius-md);
            color: var(--gray-700);
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.1s ease;
            position: relative;
        }

        .sidebar-nav li a:hover {
            background: var(--gray-50);
            color: var(--gray-900);
        }

        .sidebar-nav li a.active {
            background: var(--primary-light);
            color: var(--primary);
            font-weight: 600;
        }

        .sidebar-nav li a.active::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 3px;
            height: 20px;
            background: var(--primary);
            border-radius: 0 2px 2px 0;
        }

        .sidebar-nav li a svg {
            width: 18px;
            height: 18px;
            flex-shrink: 0;
        }

        .sidebar-badge {
            margin-left: auto;
            font-size: 11px;
            font-weight: 600;
            padding: 2px 7px;
            border-radius: 10px;
            line-height: 1.4;
        }

        .sidebar-badge-new {
            background: var(--gray-900);
            color: white;
            font-size: 10px;
            padding: 2px 6px;
        }

        .sidebar-badge-count {
            background: var(--gray-200);
            color: var(--gray-700);
        }

        .sidebar-promo {
            margin: 0 var(--space-3) var(--space-4);
            padding: var(--space-5);
            background: linear-gradient(135deg, var(--primary-light) 0%, #dbeafe 100%);
            border-radius: var(--radius-lg);
            border: 1px solid rgba(0, 102, 255, 0.15);
        }

        .sidebar-promo-title {
            font-size: 13px;
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: var(--space-2);
            display: flex;
            align-items: center;
            gap: var(--space-2);
            font-family: var(--font-display);
        }

        .sidebar-promo-desc {
            font-size: 12px;
            color: var(--gray-700);
            line-height: 1.5;
            margin-bottom: var(--space-3);
        }

        .sidebar-promo-btn {
            display: inline-flex;
            align-items: center;
            gap: var(--space-2);
            padding: var(--space-2) var(--space-4);
            background: var(--primary);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.1s ease;
        }

        .sidebar-promo-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
            box-shadow: var(--shadow-md);
        }

        .sidebar-bottom {
            margin-top: auto;
            border-top: 1px solid var(--border-default);
            padding-top: var(--space-4);
        }

        .sidebar-bottom a,
        .sidebar-bottom button {
            display: flex;
            align-items: center;
            gap: var(--space-3);
            padding: var(--space-2) var(--space-4);
            margin: 0 var(--space-2);
            border-radius: var(--radius-md);
            color: var(--gray-700);
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.1s ease;
        }

        .sidebar-bottom a:hover,
        .sidebar-bottom button:hover {
            background: var(--gray-50);
            color: var(--gray-900);
        }

        .sidebar-bottom .logout {
            color: var(--warning);
        }

        .sidebar-bottom .logout:hover {
            background: var(--warning-bg);
        }

        .sidebar-bottom a svg,
        .sidebar-bottom button svg {
            width: 18px;
            height: 18px;
        }

        .main {
            flex: 1;
            margin-left: 232px;
            padding: var(--space-8);
            max-width: 1400px;
        }

        .page-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            margin-bottom: var(--space-8);
            gap: var(--space-6);
        }

        .page-header-content h1 {
            font-family: var(--font-display);
            font-size: 24px;
            font-weight: 700;
            color: var(--gray-900);
            margin-bottom: var(--space-2);
            letter-spacing: -0.02em;
            line-height: 1.3;
        }

        .page-header-content p {
            font-size: 14px;
            color: var(--gray-600);
            max-width: 600px;
            line-height: 1.5;
        }

        .page-actions {
            display: flex;
            gap: var(--space-3);
            flex-shrink: 0;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: var(--space-2);
            padding: var(--space-2) var(--space-4);
            border-radius: var(--radius-md);
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: all 0.1s ease;
            text-decoration: none;
            font-family: var(--font-sans);
            white-space: nowrap;
            height: 36px;
        }

        .btn svg {
            width: 16px;
            height: 16px;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary {
            background: var(--gray-900);
            color: white;
        }

        .btn-secondary:hover {
            background: var(--gray-800);
            transform: translateY(-1px);
            box-shadow: var(--shadow-md);
        }

        .btn-ghost {
            background: transparent;
            color: var(--gray-700);
            border: 1px solid var(--border-default);
        }

        .btn-ghost:hover {
            background: var(--gray-50);
            border-color: var(--gray-300);
        }

        .btn-icon {
            width: 36px;
            height: 36px;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .partner-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: var(--space-4);
        }

        .partner-card {
            border: 1px solid var(--border-default);
            border-radius: var(--radius-lg);
            padding: var(--space-5);
            transition: all 0.15s ease;
            background: var(--surface);
        }

        .partner-card:hover {
            box-shadow: var(--shadow-md);
            border-color: var(--gray-200);
        }

        .partner-header {
            display: flex;
            align-items: flex-start;
            gap: var(--space-3);
            margin-bottom: var(--space-4);
        }

        .partner-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: var(--gray-200);
            overflow: hidden;
            flex-shrink: 0;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: var(--gray-600);
            font-family: var(--font-display);
        }

        .partner-avatar img { width: 100%; height: 100%; object-fit: cover; }

        .partner-info { flex: 1; min-width: 0; }

        .partner-name {
            font-family: var(--font-display);
            font-size: 15px;
            font-weight: 700;
            color: var(--gray-900);
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 2px;
            letter-spacing: -0.01em;
        }

        .partner-role {
            font-size: 13px;
            color: var(--gray-600);
            margin-bottom: 2px;
            font-weight: 500;
        }

        .partner-location {
            font-size: 12px;
            color: var(--gray-500);
            display: flex;
            align-items: center;
            gap: 4px;
            font-weight: 500;
        }

        .partner-match {
            padding: 6px 12px;
            background: var(--success-bg);
            border: 1px solid #a7f3d0;
            border-radius: var(--radius-md);
            text-align: center;
            flex-shrink: 0;
        }

        .partner-match-value {
            font-family: var(--font-display);
            font-size: 16px;
            font-weight: 700;
            color: var(--success);
            line-height: 1.2;
            letter-spacing: -0.02em;
        }

        .partner-match-label {
            font-size: 10px;
            font-weight: 600;
            color: var(--success);
            text-transform: uppercase;
            letter-spacing: 0.03em;
        }

        .partner-quote {
            font-size: 13px;
            color: var(--gray-700);
            background: var(--gray-50);
            border-radius: var(--radius-md);
            padding: var(--space-3) var(--space-4);
            margin-bottom: var(--space-4);
            line-height: 1.5;
            border-left: 3px solid var(--primary);
        }

        .partner-skills-section { margin-bottom: var(--space-3); }

        .partner-skills-label {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: var(--space-2);
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .partner-skills-label.teach { color: var(--success); }
        .partner-skills-label.learn { color: var(--warning); }
        .partner-skills-label svg { width: 14px; height: 14px; stroke-width: 2.5; }

        .partner-skill-tags { display: flex; gap: 6px; flex-wrap: wrap; }

        .partner-skill-tag {
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
        }

        .partner-skill-tag.teach {
            background: var(--success-bg);
            color: var(--success);
            border: 1px solid #a7f3d0;
        }

        .partner-skill-tag.learn {
            background: var(--warning-bg);
            color: var(--warning);
            border: 1px solid #fcd34d;
        }

        .partner-actions { display: flex; gap: var(--space-2); margin-top: var(--space-4); }
        .partner-actions .btn { flex: 1; justify-content: center; }

        .empty-state {
            padding: var(--space-6);
            text-align: center;
            color: var(--gray-500);
            font-size: 13px;
        }

        .search-bar-page {
            display: flex;
            gap: var(--space-3);
            margin-bottom: var(--space-6);
        }

        .search-bar-page input {
            flex: 1;
            height: 42px;
            padding: 0 var(--space-4);
            border: 1px solid var(--border-default);
            border-radius: var(--radius-md);
            font-size: 14px;
            font-family: var(--font-sans);
        }

        .search-bar-page input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-light);
        }
.opp-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: var(--space-4);
        }

        .opp-card {
            border: 1px solid var(--border-default);
            border-radius: var(--radius-lg);
            padding: var(--space-5);
            transition: all 0.15s ease;
            position: relative;
            background: var(--surface);
        }

        .opp-card:hover {
            box-shadow: var(--shadow-lg);
            border-color: var(--gray-200);
            transform: translateY(-2px);
        }

        .opp-card-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            margin-bottom: var(--space-3);
        }

        .opp-tag {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.03em;
        }

        .opp-tag-beasiswa { background: #dbeafe; color: #1e40af; }
        .opp-tag-kompetisi { background: #ffedd5; color: #c2410c; }
        .opp-tag-seminar { background: #d1fae5; color: #065f46; }
        .opp-tag-webinar { background: #d1fae5; color: #065f46; }

        .opp-tag svg { width: 12px; height: 12px; stroke-width: 2.5; }

        .opp-bookmark {
            width: 32px;
            height: 32px;
            border-radius: var(--radius-md);
            border: 1px solid var(--border-default);
            background: var(--surface);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--gray-400);
            transition: all 0.1s ease;
        }

        .opp-bookmark:hover {
            border-color: var(--primary);
            color: var(--primary);
            background: var(--primary-light);
        }

        .opp-bookmark svg { width: 16px; height: 16px; }

        .opp-title {
            font-family: var(--font-display);
            font-size: 15px;
            font-weight: 700;
            color: var(--gray-900);
            margin-bottom: var(--space-2);
            line-height: 1.3;
            letter-spacing: -0.01em;
        }

        .opp-org {
            font-size: 13px;
            color: var(--gray-600);
            margin-bottom: var(--space-3);
            display: flex;
            align-items: center;
            gap: 5px;
            font-weight: 500;
        }

        .opp-org svg { width: 14px; height: 14px; flex-shrink: 0; }

        .opp-tags {
            display: flex;
            gap: 6px;
            margin-bottom: var(--space-4);
            flex-wrap: wrap;
        }

        .opp-tag-sm {
            padding: 4px 9px;
            background: var(--gray-100);
            color: var(--gray-700);
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
        }

        .opp-meta {
            display: flex;
            justify-content: space-between;
            padding-top: var(--space-4);
            border-top: 1px solid var(--border-subtle);
            margin-bottom: var(--space-4);
        }

        .opp-meta-item label {
            font-size: 10px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--gray-500);
            display: block;
            margin-bottom: 3px;
        }

        .opp-meta-item span {
            font-size: 13px;
            font-weight: 600;
            color: var(--gray-900);
        }

        .opp-meta-item .deadline { color: var(--warning); font-weight: 700; }
        .opp-meta-item .benefit { color: var(--success); }

        @media (max-width: 1280px) {
            .sidebar-right { display: grid; grid-template-columns: repeat(2, 1fr); }
        }

        @media (max-width: 1024px) {
            .partner-grid { grid-template-columns: 1fr; }
        }

        @media (max-width: 768px) {
            .sidebar { display: none; }
            .main { margin-left: 0; padding: var(--space-5); }
            .navbar-brand-text { display: none; }
            .navbar-search { max-width: 200px; }
            .page-header { flex-direction: column; }
        }

        <?php echo $__env->yieldContent('extra-style'); ?>
    </style>
    <?php echo $__env->yieldPushContent('styles'); ?>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-brand">
            <div class="navbar-logo">N</div>
            <div class="navbar-brand-text">NOERA</div>
        </div>

        <div class="navbar-search">
            <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
            <input type="text" placeholder='Cari mahasiswa, skill ("React", "UI Design")...'>
            <kbd>⌘K</kbd>
        </div>

        <div class="navbar-actions">
            <button class="nav-icon-btn" title="Notifikasi">
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/></svg>
            </button>
            <a href="<?php echo e(route('messages.index')); ?>" class="nav-icon-btn" title="Pesan">
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M8 10h.01M12 10h.01M16 10h.01M9 16H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-5c-.512 0-1.024.195-1.414.586L13 16.414a2 2 0 01-2.828 0L9.586 15.586A2 2 0 008.172 15z"/></svg>

            </a>
            <div class="navbar-user">
                <div class="navbar-user-avatar">
                    <img src="https://ui-avatars.com/api/?name=<?php echo e(urlencode($user->name)); ?>&background=0066ff&color=fff" alt="<?php echo e($user->name); ?>">
                </div>
                <div class="navbar-user-info">
                    <div class="navbar-user-name"><?php echo e($user->name); ?></div>
                    <div class="navbar-user-role"><?php echo e($user->major ?? '-'); ?></div>
                </div>
                <svg class="navbar-user-arrow" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7"/></svg>
            </div>
        </div>
    </nav>

    <div class="layout">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-section">
                <div class="sidebar-section-title">Main Menu</div>
                <ul class="sidebar-nav">
                    <li>
                        <a href="<?php echo e(url('/dashboard')); ?>" class="<?php echo e(request()->is('dashboard') ? 'active' : ''); ?>">
                            <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"/></svg>
                            Dashboard
                        </a>
                    </li>
                    <li>
                        <a href="<?php echo e(url('/skill-exchange')); ?>" class="<?php echo e(request()->is('skill-exchange*') ? 'active' : ''); ?>">
                            <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                            Skill Exchange
                            <span class="sidebar-badge sidebar-badge-new">New</span>
                        </a>
                    </li>
                    <li>
                        <a href="<?php echo e(url('/peluang/beasiswa')); ?>" class="<?php echo e(request()->is('peluang/beasiswa') ? 'active' : ''); ?>">
                            <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 14l9-5-9-5-9 5 9 5z"/><path stroke-linecap="round" stroke-linejoin="round" d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z"/></svg>
                            Peluang Beasiswa
                        </a>
                    </li>
                    <li>
                        <a href="<?php echo e(url('/peluang/kompetisi')); ?>" class="<?php echo e(request()->is('peluang/kompetisi') ? 'active' : ''); ?>">
                            <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"/></svg>
                            Info Kompetisi
                            <span class="sidebar-badge sidebar-badge-count">12</span>
                        </a>
                    </li>
                    <li>
                        <a href="<?php echo e(url('/peluang/seminar-webinar')); ?>" class="<?php echo e(request()->is('peluang/seminar-webinar') ? 'active' : ''); ?>">
                            <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z"/></svg>
                            Seminar & Webinar
                        </a>
                    </li>
                    <li>
                        <a href="<?php echo e(route('study-club.index')); ?>" class="menu-item">
                            <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/></svg>
                            Study Club
                        </a>
                    </li>
                </ul>
            </div>

            <div class="sidebar-promo">
                <div class="sidebar-promo-title">
                    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                    Daftar Study Club
                </div>
                <p class="sidebar-promo-desc">Gabung grup belajar dan tukar ilmu mingguan bareng mentor mahasiswa.</p>
                <button class="sidebar-promo-btn">Explore Groups →</button>
            </div>

            <div class="sidebar-bottom">
                <a href="#">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                    Pengaturan Akun
                </a>
                <form method="POST" action="<?php echo e(url('/logout')); ?>" style="margin: 0;">
                    <?php echo csrf_field(); ?>
                    <button type="submit" class="logout" style="width: 100%; background: none; border: none; cursor: pointer; text-align: left; font-family: inherit;">
                        <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/></svg>
                        Keluar Sesi
                    </button>
                </form>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="main">
            <?php if(session('status')): ?>
                <div style="background: var(--success-bg); border: 1px solid #a7f3d0; color: var(--success); padding: 12px 16px; border-radius: var(--radius-md); margin-bottom: 20px; font-size: 13px; font-weight: 600;">
                    ✓ <?php echo e(session('status')); ?>

                </div>
            <?php endif; ?>
            <?php if(session('success')): ?>
                <div style="background: var(--success-bg); border: 1px solid #a7f3d0; color: var(--success); padding: 12px 16px; border-radius: var(--radius-md); margin-bottom: 20px; font-size: 13px; font-weight: 600;">
                    ✓ <?php echo e(session('success')); ?>

                </div>
            <?php endif; ?>
            <?php if(session('error')): ?>
                <div style="background: var(--warning-bg); border: 1px solid #fcd34d; color: var(--warning); padding: 12px 16px; border-radius: var(--radius-md); margin-bottom: 20px; font-size: 13px; font-weight: 600;">
                    ⚠ <?php echo e(session('error')); ?>

                </div>
            <?php endif; ?>

            <?php echo $__env->yieldContent('content'); ?>
        </main>
    </div>
</body>
</html><?php /**PATH D:\laragon\www\Project_Final_Web_2\resources\views/layouts/app.blade.php ENDPATH**/ ?>