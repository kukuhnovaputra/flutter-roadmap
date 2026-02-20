# Level 0: Tools & Setup Lingkungan (Prasyarat)

Level ini adalah **fondasi paling awal**: alat-alat apa saja yang diperlukan, cara menginstalnya di komputer kamu, dan verifikasi sampai project Flutter pertama bisa dijalankan. Tanpa tools yang benar, level-level berikutnya tidak bisa dijalankan dengan lancar.

**Panduan ini tampil otomatis di GitHub saat folder ini dibuka.**

---

## 🛠️ Tools yang Diperlukan

| Tool | Untuk apa | Wajib? |
|------|------------|--------|
| **Flutter SDK** | Menjalankan dan build aplikasi Flutter/Dart | Ya (kecuali hanya pakai DartPad) |
| **Dart SDK** | Sudah termasuk di dalam Flutter SDK | Ya (ikut Flutter) |
| **IDE / Editor** | Menulis kode: VS Code atau Android Studio | Salah satu cukup |
| **Emulator atau device** | Menjalankan app Flutter (Android/iOS) | Ya untuk Level 6 ke atas (UI) |
| **Git** | Clone repo, version control | Dianjurkan |
| **Terminal / Command line** | Menjalankan `flutter`, `dart`, `git` | Ya |

**Catatan:** Untuk **Level 1–5** (murni Dart: data type, variable, control flow, functions, OOP) kamu bisa belajar **tanpa install apa pun** dengan **[DartPad](https://dartpad.dev)** di browser. Level 6 ke atas (Widget, Flutter app, emulator) butuh Flutter SDK + IDE + emulator/device.

---

## 📱 Belajar dengan DartPad (Tanpa Install)

**[DartPad](https://dartpad.dev)** adalah editor Dart/Flutter online di browser. Cocok untuk:

- **Level 1: Data Types** — jalankan snippet Dart.
- **Level 2: Variables & Scope** — jalankan kode Dart.
- **Level 3: Operators & Control Flow** — logic, loop, error handling.
- **Level 4: Functions & Method** — fungsi, parameter, anonymous function.
- **Level 5: OOP** — class, inheritance, mixin, dll.

DartPad juga punya mode **Flutter** (preview UI sederhana di browser). Untuk latihan widget dasar (Level 6) bisa dipakai dengan batasan: tidak semua package/plugin tersedia, dan tidak menggantikan pengalaman jalankan di emulator/device.

**Kapan harus pakai VS Code / Android Studio + emulator?**

- Saat mulai **Level 6** (Widget, layout, user input) dan seterusnya.
- Saat butuh **package** dari pub.dev (Level 5.5 ke atas).
- Saat butuh **debug** penuh, DevTools, atau jalankan di device asli.

---

## 🪟 Instalasi: Windows

### 1. Flutter SDK

1. Download Flutter SDK: [https://docs.flutter.dev/get-started/install/windows](https://docs.flutter.dev/get-started/install/windows) (atau [flutter.dev](https://flutter.dev)).
2. Ekstrak ke folder, misalnya `C:\src\flutter` (hindari path yang ada spasi atau `Program Files`).
3. Tambahkan Flutter ke **PATH**:
   - Cari "Environment Variables" di Start.
   - Edit "Path" di variabel user atau system.
   - Tambah entry: `C:\src\flutter\bin` (sesuaikan path ekstrak).
4. Buka **Command Prompt** atau **PowerShell** baru, jalankan:
   ```bash
   flutter doctor
   ```

### 2. IDE

- **VS Code:** [code.visualstudio.com](https://code.visualstudio.com) → install extension "Flutter" dan "Dart".
- **Android Studio:** [developer.android.com/studio](https://developer.android.com/studio) → install plugin Flutter (dan Dart) dari File → Settings → Plugins.

### 3. Android Emulator (untuk Flutter app)

- Lewat Android Studio: **Device Manager** → Create Device → pilih image (mis. API 34) → selesai. Jalankan emulator dari Device Manager.
- Atau sambungkan **HP Android** dengan USB debugging aktif.

### 4. Cek lingkungan

```bash
flutter doctor
flutter doctor -v
```

Perbaiki item yang masih ada tanda `[!]` atau `✗`.

---

## 🍎 Instalasi: macOS

### 1. Flutter SDK

1. Download: [https://docs.flutter.dev/get-started/install/macos](https://docs.flutter.dev/get-started/install/macos).
2. Ekstrak ke folder, misalnya `~/development/flutter`.
3. Tambah ke PATH (biasanya di `~/.zshrc` atau `~/.bash_profile`):
   ```bash
   export PATH="$PATH:$HOME/development/flutter/bin"
   ```
   Lalu jalankan `source ~/.zshrc` (atau buka terminal baru).
4. Jalankan:
   ```bash
   flutter doctor
   ```

### 2. Xcode (untuk iOS Simulator / build iOS)

- Install **Xcode** dari App Store.
- Buka Xcode sekali dan terima **license**:
  ```bash
  sudo xcodebuild -license accept
  ```
- Install command line tools jika diminta:
  ```bash
  xcode-select --install
  ```
- **Buka iOS Simulator** dari terminal:
  ```bash
  open -a Simulator
  ```
  Atau dari Xcode: **Xcode → Open Developer Tool → Simulator**.

Setelah simulator terbuka, jalankan:
```bash
flutter devices
```
Pastikan ada device iOS Simulator.

### 3. CocoaPods (untuk iOS build)

Flutter iOS memakai CocoaPods. Install dengan:

```bash
sudo gem install cocoapods
```

Atau pakai Homebrew:

```bash
brew install cocoapods
```

### 4. IDE

- **VS Code:** [code.visualstudio.com](https://code.visualstudio.com) → extension "Flutter" + "Dart".
- **Android Studio:** [developer.android.com/studio](https://developer.android.com/studio) → plugin Flutter + Dart. Untuk Android emulator di Mac (M1/M2 bisa pakai ARM image).

### 5. Cek

```bash
flutter doctor
flutter doctor -v
```

---

## 🐧 Instalasi: Linux

### 1. Dependencies (Ubuntu/Debian)

Jalankan sekali:

```bash
sudo apt-get update
sudo apt-get install -y clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev
```

(Dokumentasi resmi: [Install Flutter on Linux](https://docs.flutter.dev/get-started/install/linux).)

### 2. Flutter SDK

1. Download dari [docs.flutter.dev/get-started/install/linux](https://docs.flutter.dev/get-started/install/linux).
2. Ekstrak, misalnya ke `~/development/flutter`.
3. Tambah ke PATH di `~/.bashrc` atau `~/.zshrc`:
   ```bash
   export PATH="$PATH:$HOME/development/flutter/bin"
   ```
4. `source ~/.bashrc` lalu `flutter doctor`.

### 3. Android Studio / Emulator

- Install Android Studio, lalu buat AVD (Android Virtual Device) untuk emulator.
- Atau sambungkan HP Android dengan USB debugging.

### 4. IDE

- VS Code + extension Flutter & Dart, atau Android Studio + plugin Flutter.

### 5. Cek

```bash
flutter doctor
flutter doctor -v
```

---

## ⚠️ Error Umum Saat Pertama Kali Konfigurasi

### macOS

| Error / Gejala | Penyebab umum | Solusi |
|----------------|----------------|--------|
| **Process exited abnormally** (saat run/doctor) | Xcode belum diterima atau path salah | Jalankan `sudo xcodebuild -license accept`. Pastikan Xcode terinstall dan `xcode-select -p` mengarah ke Xcode.app. |
| **xcodebuild: error / No Xcode** | Xcode belum di-install atau CLI tools salah | Install Xcode dari App Store. Lalu `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`. |
| **Simulator tidak muncul di `flutter devices`** | Simulator belum dibuka | Buka dulu: `open -a Simulator`. Tunggu boot, lalu `flutter devices` lagi. |
| **CocoaPods error / pod install gagal** | CocoaPods belum terinstall atau versi lama | `sudo gem install cocoapods` atau `brew install cocoapods`. Di M1/M2: bisa perlu `sudo gem install ffi` dulu. |
| **Android licenses not accepted** | License SDK Android belum diterima | Jalankan `flutter doctor --android-licenses` dan terima semua (y). |
| **cmdline-tools component is missing** | Android SDK tidak lengkap | Buka Android Studio → Settings → Android SDK → SDK Tools → centang "Android SDK Command-line Tools" → Apply. |

### Windows

| Error / Gejala | Penyebab umum | Solusi |
|----------------|----------------|--------|
| **'flutter' is not recognized** | Flutter belum di PATH | Tambah `flutter\bin` ke Environment Variables → Path. Restart terminal/IDE. |
| **Android licenses not accepted** | License belum diterima | `flutter doctor --android-licenses`, jawab y. |
| **Hyper-V / Virtualization** | Emulator butuh virtualisasi | Aktifkan Hyper-V atau Windows Hypervisor Platform (Windows Features). Restart. |
| **Emulator sangat lambat / tidak jalan** | Driver grafik / RAM | Pastikan GPU driver terbaru. Coba buat AVD dengan image "x86_64" dan cukup RAM. |

### Linux

| Error / Gejala | Penyebab umum | Solusi |
|----------------|----------------|--------|
| **Missing dependency (libgtk, liblzma, dll)** | Library development belum terinstall | Jalankan blok `apt-get install` di bagian Dependencies di atas. |
| **Android emulator tidak jalan** | KVM / akses device | Pastikan user dalam grup `kvm`: `sudo usermod -aG kvm $USER`, logout/login. |
| **Flutter doctor: Linux toolchain failed** | Compiler/GTK tidak ketemu | Install `build-essential`, `libgtk-3-dev`, dan paket yang disebut di dokumentasi Linux Flutter. |

### Semua OS

| Error / Gejala | Solusi |
|----------------|--------|
| **Doctor menunjukkan masalah** | Jalankan `flutter doctor -v`, baca pesan untuk setiap section (Android, iOS, VS Code, dll), lalu perbaiki satu per satu. |
| **Proyek pertama gagal run** | Pastikan emulator/device sudah muncul di `flutter devices`. Pilih device: `flutter run -d <device_id>`. |
| **Network / pub get gagal** | Cek proxy/firewall. Di beberapa wilayah bisa perlu mirror atau VPN untuk akses pub.dev. |

---

## ✅ Cek Akhir: Siap Belajar

1. **Hanya mau coba Dart (Level 1–5):** Buka [DartPad](https://dartpad.dev), tidak perlu install.
2. **Mau jalankan Flutter app di komputer:**
   - `flutter doctor` harus bersih (tanpa error merah).
   - Minimal satu device terdeteksi: `flutter devices` (emulator atau HP).
   - Untuk macOS + iOS: `open -a Simulator` lalu `flutter devices` harus tampil iOS Simulator.

Setelah ini kamu siap ke **Level 0: Setup Lingkungan (Prasyarat)** untuk membuat project pertama dengan `flutter create`, atau langsung ke **Level 1** dengan DartPad.

---

## 📚 Referensi

- [Flutter: Get started - Install](https://docs.flutter.dev/get-started/install)
- [DartPad](https://dartpad.dev)
- [Flutter doctor](https://docs.flutter.dev/get-started/install#flutter-doctor)
