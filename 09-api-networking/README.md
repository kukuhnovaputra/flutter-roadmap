# Level 9: API & Networking (Flutter)

Level ini fokus pada **menghubungkan aplikasi ke internet**: HTTP request, parsing JSON, penggunaan Dio, dan penanganan error (timeout, status code, try/catch). Semua contoh dalam satu project Flutter di folder `09-api-networking/`.

**Panduan ini (README) tampil otomatis di GitHub saat folder ini dibuka.**

## Kenapa butuh API?

Aplikasi modern sering membutuhkan data dari server (login, daftar konten, sinkronisasi). Data itu diambil lewat **HTTP** (GET, POST, dll.) dan biasanya dalam format **JSON**. Flutter menyediakan package `http` untuk request dasar, dan **Dio** untuk fitur lebih lengkap (baseUrl, interceptors, timeout, dll.).

## Materi

### 1. HTTP Request (package http)

- Import: `import 'package:http/http.dart' as http;`
- GET: `http.get(Uri.parse('https://...'))` → mengembalikan `Future<Response>`.
- Gunakan **async/await**; tampilkan **loading state** saat request berjalan.
- Response: `response.statusCode`, `response.body` (string).

### 2. JSON Parsing

- Model class dengan **fromJson** (factory) dan **toJson** (Map).
- Decode: `jsonDecode(response.body)` dari `dart:convert` → dapat `Map<String, dynamic>`.
- Buat object: `Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>)`.
- Encode: `jsonEncode(object.toJson())` jika perlu kirim data ke server.

### 3. Dio

- Inisialisasi dengan **baseUrl**: `Dio(BaseOptions(baseUrl: 'https://...'))`.
- GET: `dio.get('/path')`, POST: `dio.post('/path', data: {...})`.
- **Interceptor**: untuk logging, auth header, dll. (onRequest, onResponse, onError).

### 4. Error Handling

- Selalu bungkus request dalam **try/catch**.
- Tangani: **timeout** (atur di BaseOptions atau http.Client), **status code != 200**, **format JSON invalid** (catch dari jsonDecode).
- Tampilkan pesan error ke user (SnackBar atau Text) agar jelas: "no connection", "timeout", "server error".

### 5. Environment / config

- **Base URL dan API key** sebaiknya tidak di-hardcode. Gunakan config yang **aman**: nilai disuntikkan **saat build** (tidak ada file env yang ikut ke app bundle). Di Flutter direkomendasikan **--dart-define** atau **--dart-define-from-file**; hindari file .env di assets (tidak aman untuk rahasia). Lihat modul **Environment & config** (Level 16).
- Di project ini, demo Dio memakai **--dart-define**: base URL dibaca dengan `String.fromEnvironment('BASE_URL', defaultValue: 'https://jsonplaceholder.typicode.com')`. Untuk development: `flutter run` (pakai default). Untuk API lain: `flutter run --dart-define=BASE_URL=https://api.example.com`. Untuk banyak variabel: `flutter run --dart-define-from-file=env.json` (lihat `env.json.example`).

---

## File di folder ini

| File | Deskripsi |
|------|-----------|
| `pubspec.yaml` | Flutter + http + dio |
| `lib/main.dart` | Menu: 4 demo (HTTP, JSON, Dio, Error Handling) |
| `lib/http_request.dart` | GET dengan http, loading, tampilkan response |
| `lib/json_parsing.dart` | Model Post fromJson/toJson, decode & tampilkan |
| `lib/dio_demo.dart` | Dio baseUrl dari dart-define, GET/POST, interceptor logging |
| `lib/error_handling.dart` | try/catch, timeout, 404, invalid JSON, pesan ke user |
| `env.json.example` | Template untuk --dart-define-from-file (copy ke env.json, jangan commit jika berisi rahasia) |
| `README.md` | Dokumen ini |

## Cara menjalankan

```bash
cd 09-api-networking && flutter pub get && flutter run
```

Demo memakai public API [JSONPlaceholder](https://jsonplaceholder.typicode.com) (tanpa API key). Base URL dari **--dart-define** (default di kode). Untuk API lain: `flutter run --dart-define=BASE_URL=https://api.example.com` atau pakai `--dart-define-from-file=env.json` (copy dari `env.json.example`; jangan commit `env.json` yang berisi rahasia).
