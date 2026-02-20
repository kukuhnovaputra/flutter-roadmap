# Level 10: Persistence (Penyimpanan Lokal)

Level ini fokus pada **menyimpan data di perangkat** tanpa selalu mengandalkan API. Penting untuk preferensi pengguna, cache, dan data offline.

**Panduan ini (README) tampil otomatis di GitHub saat folder ini dibuka.**

## Kenapa butuh persistence?

Aplikasi perlu menyimpan data lokal untuk: pengaturan (theme, bahasa), cache (agar bisa dipakai offline), dan data yang dibuat pengguna (catatan, daftar). Flutter menyediakan beberapa cara: key-value (SharedPreferences), file (path_provider + File), dan database (SQLite via sqflite atau Hive).

## Materi

### 1. Key-value (SharedPreferences)

- Package: `shared_preferences`.
- Menyimpan tipe sederhana: `int`, `double`, `bool`, `String`, `List<String>`.
- API: `SharedPreferences.getInstance()` → `prefs.setString(key, value)`, `prefs.getString(key)`, `prefs.clear()`.
- Cocok untuk: preferensi, flag, counter kecil.

### 2. File (path_provider + dart:io File)

- Package: `path_provider` (lokasi direktori), `path` (join path). Untuk baca/tulis isi file pakai `dart:io` File (tidak tersedia di web; gunakan di Android/iOS/desktop).
- `getApplicationDocumentsDirectory()` → path ke folder dokumen app.
- `File(path).writeAsString(text)`, `File(path).readAsString()`.
- Cocok untuk: file teks, cache JSON, export/import.

### 3. Database lokal (SQLite via sqflite)

- Package: `sqflite`, `path`.
- `getDatabasesPath()` + `path.join` → path file database.
- `openDatabase(path, version: 1, onCreate: (db, v) => db.execute('CREATE TABLE ...'))`.
- Operasi: `insert`, `query`, `update`, `delete`.
- Cocok untuk: data terstruktur banyak (daftar catatan, history, dll.).

---

## File di folder ini

| File | Deskripsi |
|------|-----------|
| `pubspec.yaml` | Flutter + shared_preferences, path_provider, path, sqflite |
| `lib/main.dart` | Menu: 3 demo (Key-value, File, SQLite) |
| `lib/shared_preferences_demo.dart` | Simpan/load nama, counter, dark mode; clear |
| `lib/file_storage.dart` | Simpan/muat teks ke file di application documents |
| `lib/database_demo.dart` | SQLite: tabel notes, tambah, tampil, hapus |
| `README.md` | Dokumen ini |

## Cara menjalankan

```bash
cd 10-persistence && flutter pub get && flutter run
```

**Catatan:** Demo File Storage memakai `dart:io` File; jalankan di Android, iOS, atau desktop. SQLite tidak didukung di web out-of-the-box (bisa pakai sqflite_common_ffi_web untuk eksperimen).
