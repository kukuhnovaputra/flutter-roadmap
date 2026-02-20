# Level 11: Firebase (Backend as a Service)

Level ini fokus pada **menghubungkan aplikasi ke Firebase**: autentikasi (Auth) dan database cloud (Firestore). Setelah Level 9 (API) dan Level 10 (Persistence lokal), Firebase memperkenalkan backend tanpa server: auth, database real-time, dan (opsional) notifikasi.

**Panduan ini (README) tampil otomatis di GitHub saat folder ini dibuka.**

## Kenapa Firebase?

Banyak aplikasi Flutter di industri memakai Firebase untuk: login/register (Auth), penyimpanan data di cloud (Firestore/Realtime Database), push notification (FCM), dan pelaporan crash (Crashlytics). Dengan Firebase kita tidak perlu mengelola server sendiri; cukup konfigurasi di konsol dan SDK di aplikasi.

## Prasyarat

1. **Akun Firebase:** Buat project di [Firebase Console](https://console.firebase.google.com).
2. **Konfigurasi di project:**  
   - **Android:** Download `google-services.json`, letakkan di `android/app/`.  
   - **iOS:** Download `GoogleService-Info.plist`, tambah ke Xcode (root project).  
   Atau gunakan [FlutterFire CLI](https://firebase.flutter.dev/docs/cli-setup): `dart run flutterfire_cli:flutterfire configure` — akan generate file konfigurasi dan (opsional) `lib/firebase_options.dart`.
3. Aktifkan **Authentication** (Email/Password) dan **Firestore Database** di Firebase Console.

## Materi

### 1. Setup Firebase di Flutter

- Package: `firebase_core`, `firebase_auth`, `cloud_firestore`.
- Di `main()`: `WidgetsFlutterBinding.ensureInitialized();` lalu `await Firebase.initializeApp();`.
- Tanpa konfigurasi (google-services / GoogleService-Info), app akan error saat startup — ikuti prasyarat di atas.

### 2. Firebase Auth

- **Register:** `FirebaseAuth.instance.createUserWithEmailAndPassword(email, password)`.
- **Login:** `FirebaseAuth.instance.signInWithEmailAndPassword(email, password)`.
- **Logout:** `FirebaseAuth.instance.signOut()`.
- **State auth:** `FirebaseAuth.instance.authStateChanges()` mengembalikan `Stream<User?>` — bisa didengarkan untuk tahu apakah user sudah login. Di aplikasi besar, stream ini sering di-wrap dengan state management (Provider/Riverpod — Level 7).

### 3. Cloud Firestore

- **Struktur:** Koleksi (collection) berisi dokumen (document); tiap dokumen punya ID dan field (key-value).
- **Referensi:** `FirebaseFirestore.instance.collection('nama_koleksi')`, `.doc('id')`.
- **Tambah:** `collection.add({ 'field': value })` atau `.doc(id).set({ ... })`.
- **Baca:** `.get()` (sekali) atau `.snapshots()` (stream, real-time).
- **Update/Hapus:** `.doc(id).update({ ... })`, `.doc(id).delete()`.
- **Rules:** Di Firebase Console → Firestore → Rules, atur siapa boleh baca/tulis (mis. hanya user login). Penting untuk keamanan.

### 4. Opsional (disebutkan saja)

- **Realtime Database:** Alternatif NoSQL real-time; berbeda struktur dengan Firestore (JSON tree).
- **FCM (Firebase Cloud Messaging):** Push notification — butuh konfigurasi tambahan (Android/iOS).
- **Crashlytics:** Pelaporan crash — tambah dependency dan inisialisasi di main.

## File di folder ini

| File | Deskripsi |
|------|-----------|
| `pubspec.yaml` | Flutter + firebase_core, firebase_auth, cloud_firestore |
| `lib/main.dart` | Inisialisasi Firebase, menu ke Auth demo & Firestore demo |
| `lib/auth_demo.dart` | Register, Login, Logout, auth state stream |
| `lib/firestore_demo.dart` | CRUD: tambah item, stream daftar, hapus |
| `README.md` | Dokumen ini |

## Cara menjalankan

1. Selesaikan prasyarat (Firebase project, Auth & Firestore diaktifkan, file konfigurasi di android/ios).
2. Di folder ini:

```bash
cd 11-firebase && flutter pub get && flutter run
```

Jalankan di device/emulator Android atau iOS. Web bisa dipakai dengan konfigurasi Firebase Web.

## Referensi

- [Firebase for Flutter](https://firebase.flutter.dev/)
- [FlutterFire CLI](https://firebase.flutter.dev/docs/cli-setup)
- [Firebase Auth](https://firebase.google.com/docs/auth)
- [Cloud Firestore](https://firebase.google.com/docs/firestore)
