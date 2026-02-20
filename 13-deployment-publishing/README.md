# Level 13: Deployment & Publishing (Flutter)

Level ini fokus pada **mempublikasikan aplikasi**: build release, konfigurasi app icon dan splash screen, serta langkah menuju Play Store dan App Store. Tujuannya agar kamu memahami proses rilis aplikasi dari awal sampai akhir.

**Level ini hanya berisi panduan tertulis (tidak ada project Flutter di folder ini);** praktik build bisa dilakukan di project level lain (mis. 09-api-networking atau 11-testing).

## Kenapa deployment penting?

Aplikasi yang hanya jalan di mesin kamu belum sampai ke pengguna. Deployment berarti: membangun versi release, mengatur tampilan pertama (icon, splash), dan mengirimkan ke toko aplikasi (Play Store / App Store). Alur umum: **build release** → **atur icon & splash** → **upload ke store** → **isi listing & kebijakan**.

---

## 1. Build Release

Build release menghasilkan berkas yang siap dipasang atau di-upload ke store.

### Android

- **APK** (untuk instalasi langsung / testing):

  ```bash
  flutter build apk --release
  ```
  
  Output: `build/app/outputs/flutter-apk/app-release.apk`

- **App Bundle (AAB)** (untuk Google Play Store; direkomendasikan):

  ```bash
  flutter build appbundle --release
  ```

  Output: `build/app/outputs/bundle/release/app-release.aab`

- Debug build (hanya untuk development):

  ```bash
  flutter build apk
  ```

  atau `flutter run --release` untuk jalankan release di device.

### iOS

- **Persyaratan:** Xcode terpasang di macOS, Apple Developer account (berbayar) untuk distribusi.
- Build untuk iOS:

  ```bash
  flutter build ios --release
  ```

  Lalu buka Xcode, pilih menu **Product → Archive**, lalu **Distribute App** ke App Store Connect.

- Tanpa Mac/Apple account, build iOS tidak bisa dilakukan; fokus ke Android dulu jika perlu.

### Perintah umum

| Perintah | Kegunaan |
|----------|----------|
| `flutter build apk` | APK debug (development) |
| `flutter build apk --release` | APK release (Android) |
| `flutter build appbundle --release` | AAB untuk Play Store |
| `flutter build ios --release` | Build iOS (lanjut di Xcode) |

---

## 2. App Icon & Splash Screen

### App Icon

- **Android:** Gambar icon diletakkan di `android/app/src/main/res/` (mipmap-hdpi, mipmap-mdpi, dll.) dalam berbagai ukuran.
- **iOS:** Di Xcode, set di **Assets.xcassets → AppIcon**, dengan ukuran yang diminta Apple.
- **Praktis:** Pakai package [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons). Tambah di `pubspec.yaml` (dev_dependencies), konfigurasi path ke satu gambar sumber, lalu jalankan:

  ```bash
  dart run flutter_launcher_icons
  ```

  Package akan menghasilkan semua ukuran yang dibutuhkan.

### Splash Screen

- Tampilan pertama saat app dibuka.
- **Praktis:** Package [flutter_native_splash](https://pub.dev/packages/flutter_native_splash). Konfigurasi di `pubspec.yaml` (warna, gambar), lalu:

  ```bash
  dart run flutter_native_splash:create
  ```

- Bisa juga dikonfigurasi manual di project native (Android `styles.xml` / drawable, iOS `LaunchScreen`).

---

## 3. Play Store (Google)

1. **Google Play Console:** Daftar di [play.google.com/console](https://play.google.com/console). Bayar sekali (registrasi developer).
2. **Buat aplikasi:** Pilih "Create app", isi nama, bahasa, tipe (aplikasi/game).
3. **Upload AAB:** Di bagian "Release → Production" (atau testing track), upload file `app-release.aab` dari `flutter build appbundle --release`.
4. **Store listing:** Isi judul, deskripsi singkat, deskripsi panjang, screenshot, icon, kategori.
5. **Kebijakan:** Pastikan app memenuhi [kebijakan konten dan privasi](https://support.google.com/googleplay/android-developer/answer/9888170) Google Play.
6. **Submit for review:** Setelah semua wajib diisi, submit. Setelah disetujui, app bisa dipublikasikan.

Referensi resmi: [Flutter – Build and release an Android app](https://docs.flutter.dev/deployment/android).

---

## 4. App Store (Apple)

1. **Apple Developer Program:** Daftar di [developer.apple.com](https://developer.apple.com) (berlangganan tahunan).
2. **App Store Connect:** Buat app di [App Store Connect](https://appstoreconnect.apple.com) (bundle ID, nama, dll.).
3. **Build di Xcode:** Setelah `flutter build ios --release`, buka `ios/Runner.xcworkspace` di Xcode. Pilih device "Any iOS Device", lalu **Product → Archive**.
4. **Upload:** Dari Organizer, pilih archive → **Distribute App** → App Store Connect → Upload.
5. **Store listing & review:** Di App Store Connect isi metadata, screenshot, deskripsi. Lalu submit untuk review. Setelah disetujui, app bisa dipublikasikan.

Referensi resmi: [Flutter – Build and release an iOS app](https://docs.flutter.dev/deployment/ios).

---

## 5. Environment / config (dev vs production)

Saat build release, aplikasi sering butuh nilai berbeda untuk dev dan prod (API base URL, API key, feature flag). **Untuk production, gunakan --dart-define atau --dart-define-from-file** dengan nilai dari secret manager di CI/CD; nilai disuntikkan saat build dan tidak ada file env yang ikut ke app bundle.

- **--dart-define:** Nilai dikirim saat build, dibaca di kode dengan `String.fromEnvironment('BASE_URL', defaultValue: '...')`. Contoh: `flutter build apk --release --dart-define=BASE_URL=https://api.prod.com`.
- **--dart-define-from-file:** Sama, nilai dari file JSON (file hanya dipakai saat build, tidak ikut ke bundle). Praktis untuk banyak variabel.

**Hindari** menyimpan rahasia di file `.env` yang didaftar sebagai asset di `pubspec.yaml` — file tersebut ikut ke bundle dan bisa diekstrak dari APK/IPA (tidak aman). Lihat modul **Environment & config** (Level 16) untuk pendekatan aman dan Flavors.

---

## File di folder ini

| File | Deskripsi |
|------|-----------|
| `README.md` | Dokumen ini: panduan Build Release, App Icon, Splash, Play Store, App Store |

Tidak ada project Flutter di folder ini. Untuk berlatih build, gunakan project dari level lain (mis. `09-api-networking` atau `11-testing`).

---

## Cara menggunakan panduan ini

1. Pilih satu project Flutter (mis. `cd 09-api-networking` atau `cd 11-testing`).
2. Pastikan bisa jalan: `flutter pub get` dan `flutter run`.
3. Coba build Android: `flutter build apk --release` atau `flutter build appbundle --release`.
4. (Opsional) Atur app icon dan splash dengan `flutter_launcher_icons` dan `flutter_native_splash` di project tersebut.
5. Untuk Play Store: upload AAB ke Google Play Console dan isi store listing.
6. Untuk App Store: siapkan Mac, Xcode, dan Apple Developer account; build iOS lalu archive dan upload lewat Xcode.

---

## Referensi

- [Flutter – Deployment](https://docs.flutter.dev/deployment)
- [Flutter – Build and release for Android](https://docs.flutter.dev/deployment/android)
- [Flutter – Build and release for iOS](https://docs.flutter.dev/deployment/ios)
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
- [Google Play Console](https://play.google.com/console)
- [App Store Connect](https://appstoreconnect.apple.com)
