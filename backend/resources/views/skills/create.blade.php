<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Skill - NOERA</title>
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
            --success: #10b981;
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

        .card {
            width: 100%;
            max-width: 460px;
            background: #fff;
            border: 1px solid var(--border-default);
            border-radius: var(--radius-xl);
            padding: 36px;
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 6px;
        }

        .card-header .logo {
            width: 28px;
            height: 28px;
            background: var(--primary);
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-family: var(--font-display);
            font-size: 14px;
        }

        .card-header span {
            font-family: var(--font-display);
            font-weight: 700;
            font-size: 15px;
        }

        h1 {
            font-family: var(--font-display);
            font-size: 21px;
            font-weight: 700;
            margin: 16px 0 6px;
        }

        p.subtitle {
            font-size: 13px;
            color: var(--gray-600);
            margin-bottom: 24px;
        }

        .form-group { margin-bottom: 18px; }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: var(--gray-700);
            margin-bottom: 6px;
        }

        select, .radio-group {
            width: 100%;
        }

        select {
            height: 42px;
            padding: 0 14px;
            border: 1px solid var(--border-default);
            border-radius: var(--radius-md);
            font-size: 14px;
            font-family: var(--font-sans);
            background: var(--gray-50);
        }

        select:focus {
            outline: none;
            border-color: var(--primary);
            background: #fff;
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .radio-group {
            display: flex;
            gap: 10px;
        }

        .radio-option {
            flex: 1;
            border: 1px solid var(--border-default);
            border-radius: var(--radius-md);
            padding: 12px;
            cursor: pointer;
            text-align: center;
            transition: all 0.1s ease;
        }

        .radio-option input { display: none; }

        .radio-option span {
            font-size: 13px;
            font-weight: 600;
            color: var(--gray-700);
        }

        .radio-option:has(input:checked) {
            border-color: var(--primary);
            background: var(--primary-light);
        }

        .radio-option:has(input:checked) span {
            color: var(--primary-dark);
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

        .btn-cancel {
            display: block;
            text-align: center;
            font-size: 13px;
            color: var(--gray-600);
            text-decoration: none;
            margin-top: 14px;
            font-weight: 600;
        }

        .empty-note {
            font-size: 13px;
            color: var(--gray-600);
            background: var(--gray-50);
            border-radius: var(--radius-md);
            padding: 16px;
            text-align: center;
        }

        .error-box {
            background: var(--error-bg);
            border: 1px solid #fecaca;
            border-radius: var(--radius-md);
            padding: 12px 14px;
            margin-bottom: 16px;
        }

        .error-box p { font-size: 12.5px; color: var(--error); }
    </style>
</head>
<body>
    <div class="card">
        <div class="card-header">
            <div class="logo">N</div>
            <span>NOERA</span>
        </div>

        <h1>Tambah Skill</h1>
        <p class="subtitle">Pilih skill yang ingin kamu tambahkan ke profil.</p>

        @if ($errors->any())
            <div class="error-box">
                @foreach ($errors->all() as $error)
                    <p>{{ $error }}</p>
                @endforeach
            </div>
        @endif

        @if ($availableSkills->count() > 0)
            <form method="POST" action="{{ url('/skills') }}">
                @csrf

                <div class="form-group">
                    <label for="skill_id">Pilih Skill</label>
                    <select name="skill_id" id="skill_id" required>
                        <option value="">-- Pilih salah satu --</option>
                        @foreach ($availableSkills as $skill)
                            <option value="{{ $skill->id }}">{{ $skill->name }}</option>
                        @endforeach
                    </select>
                </div>

                <div class="form-group">
                    <label>Tipe Skill</label>
                    <div class="radio-group">
                        <label class="radio-option">
                            <input type="radio" name="type" value="teach" checked>
                            <span>Bisa Mengajari</span>
                        </label>
                        <label class="radio-option">
                            <input type="radio" name="type" value="learn">
                            <span>Ingin Belajar</span>
                        </label>
                    </div>
                </div>

                <div class="form-group">
                    <label for="level">Level (opsional, kalau bisa mengajari)</label>
                    <select name="level" id="level">
                        <option value="">-- Tidak diisi --</option>
                        <option value="pemula">Pemula</option>
                        <option value="menengah">Menengah</option>
                        <option value="mahir">Mahir</option>
                    </select>
                </div>

                <button type="submit" class="btn-submit">Simpan Skill</button>
            </form>
        @else
            <div class="empty-note">
                Semua skill yang tersedia sudah ada di profilmu. 🎉
            </div>
        @endif

        <a href="{{ url('/dashboard') }}" class="btn-cancel">← Kembali ke Dashboard</a>
    </div>
</body>
</html>
