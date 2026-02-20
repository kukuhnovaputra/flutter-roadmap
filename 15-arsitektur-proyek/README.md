# Level 15: Arsitektur Proyek Flutter

Level ini fokus pada **mengorganisir kode dan layer** agar proyek Flutter scalable, mudah diuji, dan enak dipelihara—penting untuk aplikasi production dan kerja tim.

**Level ini hanya berisi panduan tertulis (tidak ada project Flutter di folder ini);** praktik arsitektur bisa diterapkan di project level 7, 9, 10, atau project baru.

## Kenapa arsitektur penting?

Tanpa struktur yang jelas, proyek cepat berantakan: UI tercampur dengan logika bisnis, data diambil di mana saja, dan sulit onboarding anggota baru. Arsitektur yang baik memberi **pola konsisten**, **separation of concerns**, dan **kemudahan testing** sehingga aplikasi siap berkembang.

---

## 1. Struktur folder

### Feature-based vs layer-based

- **Feature-based:** Folder di bawah `lib/` diorganisir per fitur (mis. `auth/`, `home/`, `profile/`). Setiap fitur bisa berisi UI, logic, dan data miliknya. Cocok untuk aplikasi dengan banyak fitur mandiri; tim bisa kerja per fitur.
- **Layer-based:** Folder diorganisir per "lapisan" (mis. `presentation/`, `domain/`, `data/`). Semua fitur digabung per layer. Cocok untuk aplikasi yang ingin batas layer sangat tegas (mis. Clean Architecture murni).

Banyak proyek Flutter memakai **gabungan**: folder feature-based, di dalam tiap fitur ada pemisahan layer (presentation / domain / data).

### Contoh pohon folder (feature-first + layer di dalam fitur)

```
lib/
├── core/                 # Shared: konstanta, theme, error, utils
│   ├── constants/
│   ├── theme/
│   └── utils/
├── features/
│   ├── auth/
│   │   ├── data/         # repository impl, data source, model
│   │   ├── domain/       # entity, use case / repository interface
│   │   └── presentation/ # screen, widget, bloc/cubit atau provider
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── profile/
│       └── ...
├── shared/               # Widget/komponen dipakai banyak fitur
│   └── widgets/
└── main.dart
```

---

## 2. Separation of concerns

- **Presentation (UI):** Hanya menampilkan data dan meneruskan aksi user ke layer bawah. Tidak boleh panggil API atau akses database langsung. Menggunakan state management (setState, Provider, Riverpod, Bloc) dan memanggil use case atau service.
- **Domain (logic):** Entity murni dan use case / aturan bisnis. Tidak tergantung Flutter atau package HTTP/database. Interface repository didefinisikan di sini; implementasi di layer data.
- **Data:** Implementasi repository, data source (API, lokal), model (DTO), mapping ke entity. Semua akses ke jaringan atau penyimpanan ada di sini.

Alur singkat: **UI → Use case / Service → Repository → Data source (API/DB)**. UI tidak tahu dari mana data berasal.

---

## 3. Clean Architecture / feature-first

- **Presentation:** Widget, state (Bloc/Cubit, Provider, dll.), binding/injection untuk layer ini.
- **Domain:** Entity, use case (interactor). Domain **tidak** mengimpor Flutter atau package data (http, sqflite). Hanya Dart murni.
- **Data:** Repository implementation, data source, model. Mengimplementasikan interface yang didefinisikan di domain.

**Dependensi:** Hanya mengalir ke dalam. Presentation bergantung ke domain (dan mungkin data lewat DI); data bergantung ke domain; domain tidak bergantung ke apa pun. Dengan begitu, aturan bisnis bisa diuji tanpa Flutter/API.

Feature-first berarti setiap fitur (auth, home, profile, …) punya "paket" presentation + domain + data sendiri, sehingga fitur bisa dikembangkan atau di-modularisasi per feature.

---

## 4. Dependency injection (DI)

DI memisahkan **pembuatan objek** (repository, data source, use case) dari **pemakaiannya** di UI. Manfaat: gampang ganti implementasi (mock untuk testing), satu tempat konfigurasi, dan dependency jelas.

- **get_it:** Service locator. Daftar dependency di satu tempat (mis. `injection.dart`), widget ambil lewat `get_it<MyRepo>()`. Cocok untuk Bloc/Cubit + repository; setup manual.
- **Riverpod:** DI sekaligus state management. Provider mendefinisikan cara membuat objek; widget mengonsumsi lewat `ref.watch`/`ref.read`. Dependency dideklarasif dan bisa di-override untuk testing.

Contoh konsep (bukan project lengkap):

```dart
// get_it: daftar sekali di startup
getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));

// Riverpod: provider = definisi dependency
final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepositoryImpl());
```

Pilih salah satu (get_it atau Riverpod) dan konsisten di seluruh proyek.

---

## 5. Environment & config

Konfigurasi yang bergantung environment (API base URL, API key, debug/prod) sebaiknya dipusatkan dan **tidak** di-hardcode di layer data atau UI. Tempat lazim memakai env/config:

- **API base URL** — dev vs staging vs production (mis. di data source / Dio).
- **API key / secret** — layanan eksternal (maps, analytics, backend); jangan simpan di kode.
- **Feature flags / debug** — mis. `DEBUG=true` untuk logging atau perilaku dev.

**Rekomendasi:** Config production lewat **--dart-define** atau **--dart-define-from-file** (nilai disuntikkan saat build; tidak ada file env di bundle). File `.env` yang didaftar sebagai asset (flutter_dotenv) **tidak aman untuk rahasia** karena ikut ke app bundle dan bisa diekstrak. Simpan config di satu tempat (mis. `core/config/` atau service) dan inject ke repository/data source lewat DI. Lihat modul **Environment & config** (Level 16) untuk opsi aman dan Flavors.

---

## 6. Konvensi penamaan dan modularitas

- **File:** snake_case — `auth_repository.dart`, `login_screen.dart`, `user_profile_bloc.dart`.
- **Class:** PascalCase — `AuthRepository`, `LoginScreen`, `UserProfileBloc`.
- **Folder:** lowercase, bisa pakai underscore untuk multi-word — `data/`, `presentation/`, `user_profile/`.
- **Widget:** Akhiran deskriptif — `LoginScreen`, `ProfileHeader`, `TodoListItem`.
- **Repository/Use case:** Nama yang mencerminkan tanggung jawab — `AuthRepository`, `GetUserProfileUseCase`.

**Modularitas:** Satu fitur = satu modul (folder). Hindari fitur A mengimpor langsung dari "dalam" fitur B; ekspos lewat interface atau shared module. Untuk proyek besar, fitur bisa jadi package terpisah (`feature_a/`, `feature_b/`).

---

## File di folder ini

| File        | Deskripsi                                                                 |
|------------|----------------------------------------------------------------------------|
| `README.md` | Dokumen ini: struktur folder, separation of concerns, Clean Arch, DI, environment & config, konvensi. |

Tidak ada project Flutter di folder ini; materi bersifat konseptual. Praktik arsitektur bisa diterapkan di project Level 7, 9, 10, atau project baru.

---

## Cara menggunakan panduan ini

1. Baca berurutan: struktur folder → separation of concerns → Clean Architecture → DI → environment & config → konvensi.
2. Saat memulai proyek baru atau refactor, tentukan dulu: feature-based atau layer-based (atau gabungan), lalu konsisten.
3. Pisahkan UI, domain, dan data; gunakan DI untuk menyambungkan layer.
4. Ikuti konvensi penamaan agar codebase mudah dibaca oleh tim.

---

## Referensi

- [Flutter – Project structure](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options#architecture)
- [Effective Dart – Style](https://dart.dev/effective-dart/style)
- [Clean Architecture (Uncle Bob)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [get_it (pub.dev)](https://pub.dev/packages/get_it)
- [Riverpod – Dependency injection](https://riverpod.dev/docs/concepts/about_code_generation#dependency-injection)
