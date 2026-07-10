<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar - NOERA</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Inter+Display:wght@600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --primary: #0066ff;
            --primary-dark: #0052cc;
            --primary-light: #e6f0ff;
            --gray-50: #fafafa;
            --gray-200: #e5e5e5;
            --gray-300: #d4d4d4;
            --gray-500: #737373;
            --gray-600: #525252;
            --gray-700: #404040;
            --gray-900: #171717;
            --error: #ef4444;
            --error-bg: #fef2f2;
            --border-default: rgba(0, 0, 0, 0.08);
            --radius-md: 8px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            --font-display: 'Inter Display', 'Inter', sans-serif;
        }

        body {
            font-family: var(--font-sans);
            background: var(--gray-50);
            color: var(--gray-900);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        .auth-card {
            width: 100%;
            max-width: 420px;
            background: #fff;
            border: 1px solid var(--border-default);
            border-radius: var(--radius-xl);
            padding: 40px;
        }

        .auth-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 28px;
        }

        .auth-logo {
            width: 32px;
            height: 32px;
            background: var(--primary);
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-family: var(--font-display);
        }

        .auth-brand span {
            font-family: var(--font-display);
            font-size: 18px;
            font-weight: 700;
        }

        .auth-card h1 {
            font-family: var(--font-display);
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 6px;
        }

        .auth-card p.subtitle {
            font-size: 13px;
            color: var(--gray-600);
            margin-bottom: 24px;
        }

        .form-group { margin-bottom: 16px; }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: var(--gray-700);
            margin-bottom: 6px;
        }

        .form-group input {
            width: 100%;
            height: 42px;
            padding: 0 14px;
            border: 1px solid var(--border-default);
            border-radius: var(--radius-md);
            font-size: 14px;
            font-family: var(--font-sans);
            background: var(--gray-50);
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
            background: #fff;
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }

        .btn-submit {
            width: 100%;
            height: 44px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 8px;
            font-family: var(--font-sans);
        }

        .btn-submit:hover { background: var(--primary-dark); }

        .auth-footer {
            text-align: center;
            font-size: 13px;
            color: var(--gray-600);
            margin-top: 20px;
        }

        .auth-footer a {
            color: var(--primary);
            font-weight: 600;
            text-decoration: none;
        }

        .error-box {
            background: var(--error-bg);
            border: 1px solid #fecaca;
            border-radius: var(--radius-md);
            padding: 12px 14px;
            margin-bottom: 16px;
        }

        .error-box p {
            font-size: 12.5px;
            color: var(--error);
            margin-bottom: 4px;
        }

        .error-box p:last-child { margin-bottom: 0; }
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="auth-brand">
            <div class="auth-logo">N</div>
            <span>NOERA</span>
        </div>

        <h1>Buat Akun Baru</h1>
        <p class="subtitle">Daftar untuk mulai tukar skill dengan mahasiswa lain.</p>

        @if ($errors->any())
            <div class="error-box">
                @foreach ($errors->all() as $error)
                    <p>{{ $error }}</p>
                @endforeach
            </div>
        @endif

        <form method="POST" action="{{ url('/register') }}">
            @csrf

            <div class="form-group">
                <label for="name">Nama Lengkap</label>
                <input type="text" id="name" name="name" value="{{ old('name') }}" placeholder="Contoh: Lilis Puspitasari" required autofocus>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="{{ old('email') }}" placeholder="nama@email.com" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="university">Universitas</label>
                    <input type="text" id="university" name="university" value="{{ old('university') }}" placeholder="Contoh: UGM">
                </div>
                <div class="form-group">
                    <label for="major">Jurusan</label>
                    <input type="text" id="major" name="major" value="{{ old('major') }}" placeholder="Contoh: Teknik Informatika">
                </div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Minimal 8 karakter" required>
            </div>

            <div class="form-group">
                <label for="password_confirmation">Konfirmasi Password</label>
                <input type="password" id="password_confirmation" name="password_confirmation" placeholder="Ulangi password" required>
            </div>

            <button type="submit" class="btn-submit">Daftar Sekarang</button>
        </form>

        <div class="auth-footer">
            Sudah punya akun? <a href="{{ url('/login') }}">Masuk di sini</a>
        </div>
    </div>
</body>
</html>
