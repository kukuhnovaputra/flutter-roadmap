# Flutter DevTools (Level 6)

**Flutter DevTools** adalah set alat untuk debug dan profiling aplikasi Flutter. Setelah menjalankan `flutter run`, DevTools bisa dibuka untuk memeriksa layout dan performance.

---

## Cara membuka DevTools

1. Jalankan aplikasi: `cd 06-widget-basics && flutter run`.
2. Di terminal akan muncul pesan dengan link ke DevTools, misalnya:
   ```
   The Flutter DevTools debugger and profiler is available at: http://127.0.0.1:9100?uri=...
   ```
3. Buka link tersebut di browser (Chrome/Edge), atau jalankan:
   ```bash
   flutter pub global run devtools
   ```
   lalu pilih session yang sedang berjalan.

---

## Widget Inspector (Layout)

- **Fungsi:** Memeriksa pohon widget (widget tree) dan layout di layar.
- **Cara pakai:** Di DevTools, pilih tab **Flutter Inspector**. Klik "Select Widget Mode" (ikon pointer), lalu klik elemen di emulator/device; pohon widget akan menyorot widget yang diklik.
- **Berguna untuk:** Memastikan widget mana yang dipakai, constraint (ukuran/min/max), padding, alignment, dan menemukan overflow atau layout yang salah.

---

## Performance

- **Fungsi:** Menganalisis frame rate (jank), CPU usage, dan rebuild widget.
- **Cara pakai:** Di DevTools, pilih tab **Performance**. Rekam aktivitas (misalnya scroll atau tap), lalu hentikan rekaman. Timeline akan menampilkan berapa lama setiap frame di-render.
- **Berguna untuk:** Mendeteksi frame yang drop (misalnya di bawah 60 FPS) dan memastikan animasi/layout tetap halus.

---

## Referensi

- [Flutter DevTools documentation](https://docs.flutter.dev/tools/devtools/overview)
- [Layout debugging](https://docs.flutter.dev/tools/devtools/inspector)
