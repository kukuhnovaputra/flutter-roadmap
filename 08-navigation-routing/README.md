# Level 8: Navigation & Routing (Flutter)

**Navigation** adalah cara aplikasi berpindah dari satu layar ke layar lain. Flutter menyediakan **Navigator** (stack-based): push = tambah layar di atas stack, pop = buang layar dan kembali. **Routing** adalah pengaturan nama atau path untuk tiap layar sehingga navigasi bisa dilakukan lewat nama (Named Routes) atau konfigurasi declarative (GoRouter).

**Tujuan Level 8:** Memahami Navigator (push/pop), Named Routes, dan GoRouter agar alur navigasi aplikasi rapi dan mudah dipelihara.

**Cara menjalankan:** `cd 08-navigation-routing && flutter pub get && flutter run`

**Panduan ini (README) tampil otomatis di GitHub saat folder ini dibuka.**

---

## 1. Navigator (push / pop)

Navigator mengelola **stack** of routes. Layar baru ditumpuk di atas layar saat ini.

| Method | Deskripsi |
|--------|-----------|
| **Navigator.push** | Menambah layar baru di atas stack; bisa kembali dengan pop |
| **Navigator.pop** | Membuang layar saat ini dan kembali ke layar sebelumnya |
| **Navigator.pushReplacement** | Mengganti layar saat ini dengan layar baru (tidak bisa back ke yang lama) |
| **MaterialPageRoute** | Route yang membangun widget dengan transisi material |

**Contoh singkat:**

```dart
// Ke layar baru
Navigator.push(
  context,
  MaterialPageRoute<void>(
    builder: (context) => const DetailScreen(),
  ),
);

// Kembali
Navigator.pop(context);
```

---

## 2. Named Routes

Route diberi **nama string** (mis. `'/'`, `'/detail'`) dan didefinisikan di `MaterialApp.routes`. Navigasi pakai `Navigator.pushNamed(context, '/detail')`.

| Konsep | Deskripsi |
|--------|-----------|
| **routes** | Map dari nama route ke builder: `{ '/': (ctx) => Home(), '/detail': (ctx) => Detail() }` |
| **initialRoute** | Route yang ditampilkan saat app dibuka (biasanya `'/'`) |
| **pushNamed** | Navigasi ke route berdasarkan nama |
| **pop** | Tetap dipakai untuk kembali |

**Contoh singkat:**

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const MenuScreen(),
    '/navigator-basics': (context) => const NavigatorBasicsScreen(),
    '/detail': (context) => const DetailScreen(),
  },
);

// Dari widget:
Navigator.pushNamed(context, '/detail');
```

---

## 3. GoRouter

**GoRouter** (package `go_router`) adalah routing declarative: semua route didefinisikan dalam satu konfigurasi. Navigasi pakai `context.go('/path')` atau `context.push('/path')`.

| Konsep | Deskripsi |
|--------|-----------|
| **GoRouter** | Konfigurasi routes (path + builder); dipakai di `MaterialApp.router` |
| **context.go(path)** | Navigasi ke path dan **mengganti** stack (seperti replace) |
| **context.push(path)** | Menambah layar ke stack |
| **context.pop()** | Kembali ke layar sebelumnya |
| **MaterialApp.router** | MaterialApp yang memakai `routerConfig: GoRouter(...)` |

**Contoh singkat:**

```dart
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
  ],
);

MaterialApp.router(routerConfig: router);

// Di widget:
context.push('/settings');
context.go('/');
context.pop();
```

Cocok untuk app dengan banyak layar, deep linking, dan URL-based navigation.

---

## Perbandingan singkat

| Pendekatan | Kapan dipakai |
|------------|----------------|
| **Navigator.push/pop** | Navigasi sederhana, sedikit layar, tanpa nama route |
| **Named Routes** | Ingin route bernama, satu peta route di MaterialApp |
| **GoRouter** | App besar, deep link, path/URL, declarative config |

---

## File di folder ini (urutan belajar)

| File | Materi |
|------|--------|
| `lib/main.dart` | MaterialApp dengan routes map, MenuScreen, initialRoute |
| `lib/navigator_basics.dart` | NavigatorBasicsScreen: push, pop, pushReplacement |
| `lib/named_routes.dart` | NamedRoutesScreen, NamedRoutesDetailScreen, pushNamed |
| `lib/gorouter_screen.dart` | GoRouterDemoApp: MaterialApp.router + GoRouter (/, /settings) |
| `README.md` | Dokumen ini (panduan level) |

Jalankan: `cd 08-navigation-routing && flutter pub get && flutter run`.
