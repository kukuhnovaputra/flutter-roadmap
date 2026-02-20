# Level 16: Environment & Config (Flutter)

Level ini fokus pada **cara mengatur konfigurasi bergantung environment** di Flutter: base URL API, API key, flag debug/prod, dan rahasia lainnya. Di web sering dipakai file `.env`; di Flutter tidak ada mekanisme built-in. **Pendekatan paling aman** adalah menyuntikkan nilai **saat build** (bukan menyimpan file env di dalam app bundle).

**Level ini hanya berisi panduan tertulis (tidak ada project Flutter di folder ini).** Praktik env dipakai di Level 9 (API & Networking) dengan **--dart-define**.

## Kenapa environment penting?

- **Base URL** berbeda untuk development, staging, dan production.
- **API key / secret** tidak boleh di-hardcode di kode (risiko bocor ke repo atau binary).
- **Feature flag** atau mode debug perlu diubah tanpa rebuild kode bisnis.

Tanpa pemisahan config, satu build dipakai untuk semua environment dan rahasia bisa ikut ter-commit atau ter-bundle.

---

## 1. Pendekatan yang aman (direkomendasikan)

### 1.1. --dart-define (build-time)

- **Cara kerja:** Nilai dikirim saat build; **tidak ada file .env yang ikut ke app bundle**. Dibaca di kode dengan `String.fromEnvironment('KEY', defaultValue: '...')`.
- **Contoh:**  
  `flutter run --dart-define=BASE_URL=https://api.example.com`  
  `flutter build apk --release --dart-define=BASE_URL=https://api.prod.com`
- **Kapan dipakai:** Satu binary per environment; cocok untuk CI/CD: nilai diambil dari secret manager lalu di-pass ke perintah build. Nilai "di-bake" ke binary; tidak ada file konfig terpisah yang bisa diekstrak dari APK/IPA.
- **Kekurangan:** Harus rebuild untuk ganti nilai; tidak cocok untuk nilai yang sering berubah di satu binary.

**Contoh praktik:** Level 9 (`09-api-networking`) memakai `String.fromEnvironment('BASE_URL', defaultValue: 'https://jsonplaceholder.typicode.com')` untuk base URL Dio.

### 1.2. --dart-define-from-file (build-time, banyak variabel)

- **Cara kerja:** Sama seperti `--dart-define`, tapi nilai dari file JSON (mis. `env.json`) yang **tidak** didaftar sebagai asset — file hanya dipakai saat build, tidak ikut ke bundle.  
  `flutter run --dart-define-from-file=env.json`  
  `flutter build apk --release --dart-define-from-file=env.prod.json`
- **Format:** `{"BASE_URL": "https://api.dev.com", "API_KEY": "xxx"}`. Key dipakai sebagai nama variabel di `String.fromEnvironment('BASE_URL')`, dll.
- **Kapan dipakai:** Banyak variabel; menghindari command line yang sangat panjang. File `env.json` **jangan di-commit** jika berisi rahasia; di CI/CD isi dari secret manager atau generate file dari secrets.

### 1.3. Flavors (dev / staging / production)

- **Cara kerja:** Flutter mendukung **flavors** (build variants) untuk memisahkan dev, staging, dan production: bundle ID berbeda, nama app berbeda, dan config berbeda per flavor. Nilai config biasanya disuntikkan lewat **--dart-define** atau **--dart-define-from-file** per flavor (mis. satu file `env.dev.json`, `env.staging.json`, `env.prod.json` yang tidak di-commit).
- **Kapan dipakai:** Aplikasi dengan banyak environment; ingin satu codebase, banyak build (dev/staging/prod) dengan config dan identitas app terpisah.
- **Referensi:** [Flutter – Define environment variables](https://docs.flutter.dev/deployment/flavors#define-environment-variables), [Configure flavors](https://docs.flutter.dev/deployment/flavors).

---

## 2. Perbandingan dengan web (.env)

Di **web** (Vite, Next.js, CRA), file `.env` dibaca saat build atau runtime dan variabel disuntikkan ke kode. Flutter **tidak** punya mekanisme bawaan serupa. Jika kita memakai file `.env` dan mendaftarkannya di `pubspec.yaml` → assets agar dibaca di runtime (mis. lewat package flutter_dotenv), **file tersebut ikut ke dalam app bundle**. Siapa pun bisa ekstrak APK/IPa dan membaca isinya. Jadi **jangan** gunakan pola itu untuk rahasia atau config production.

---

## 3. Opsi yang tidak aman untuk rahasia: .env / flutter_dotenv

### flutter_dotenv (runtime, file .env di assets)

- **Cara kerja:** Baca file `.env` atau `.env.example` dari **assets** saat runtime. File harus didaftar di `pubspec.yaml` → `flutter.assets`.
- **Peringatan:** File env **ikut ke dalam app bundle**. Siapa pun bisa mengekstrak dan membaca isinya. **Tidak aman untuk API key, secret, atau URL production.** Jangan simpan rahasia di sana.
- **Jika tetap dipakai:** Hanya untuk **development**, dan hanya untuk nilai **non-sensitif** (mis. base URL development). Untuk production dan rahasia, wajib pakai **--dart-define** atau **--dart-define-from-file**.

---

## 4. Envied (compile-time)

- **Cara kerja:** Package [envied](https://pub.dev/packages/envied) generate kode Dart dari `.env`; nilai di-embed saat compile. File `.env` tidak ikut ke bundle; yang dipakai hanya generated class.
- **Kapan dipakai:** Ingin pola mirip web (satu file `.env`) tapi nilai tidak terbaca dari file di device. **Hati-hati:** nilai production jangan di-commit; generate di CI dari secret.

---

## 5. Di mana memakai environment?

| Tempat | Contoh |
|--------|--------|
| **API base URL** | Dev / staging / prod (mis. di Dio `BaseOptions`, data source). |
| **API key** | Layanan eksternal (maps, analytics, backend custom). Jangan hardcode. |
| **Feature flag / debug** | `DEBUG=true` untuk logging atau perilaku dev. |
| **Firebase / backend lain** | Selain file resmi (google-services.json, dll.), URL atau key tambahan bisa dari env. |

Simpan config di satu tempat (mis. `core/config/` atau service) dan inject ke repository/data source lewat dependency injection (lihat Level 15).

---

## 6. Praktik aman

- **Utamakan --dart-define / --dart-define-from-file** untuk production dan nilai sensitif. Nilai dari secret manager di CI/CD; tidak ada file env di bundle.
- **Jangan commit** file yang berisi rahasia (`.env`, `env.json`, dll.). Gunakan `.env.example` atau `env.json.example` hanya sebagai template (tanpa nilai sensitif).
- **.gitignore:** Pastikan `.env`, `.env.*`, dan file config berisi rahasia (mis. `env.json`, `env.*.json`) di-ignore.
- **Hindari** menyimpan rahasia di file yang didaftar sebagai asset (flutter_dotenv); file tersebut ikut ke bundle dan tidak aman.

---

## File di folder ini

| File        | Deskripsi                                                                 |
|------------|----------------------------------------------------------------------------|
| `README.md` | Dokumen ini: konsep environment, opsi aman (dart-define, Flavors), peringatan .env di bundle, praktik aman. |

Tidak ada project Flutter di folder ini. Untuk contoh praktik, lihat **Level 9 (API & Networking)** yang memakai **--dart-define** untuk base URL Dio.

---

## Referensi

- [Define environment variables - Flutter docs](https://docs.flutter.dev/deployment/flavors#define-environment-variables)
- [Configure flavors - Flutter](https://docs.flutter.dev/deployment/flavors)
- [envied](https://pub.dev/packages/envied)
- Level 9: [09-api-networking](../09-api-networking/README.md) — contoh base URL dari dart-define
- Level 13: [13-deployment-publishing](../13-deployment-publishing/README.md) — build release dan env
- Level 15: [15-arsitektur-proyek](../15-arsitektur-proyek/README.md) — tempat config dalam arsitektur