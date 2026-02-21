# Level 12: Testing (Flutter)

Level ini fokus pada **pengujian kode dan UI**: unit test, widget test, dan integration test. Tujuannya agar aplikasi bisa diuji dan lebih mudah dipelihara (refactor aman, dokumentasi hidup, deteksi regresi).

**Panduan ini (README) tampil otomatis di GitHub saat folder ini dibuka.**

## Kenapa testing penting?

- **Regresi:** Perubahan kode tidak merusak fitur yang sudah ada.
- **Refactor aman:** Bisa mengubah struktur kode dengan percaya diri.
- **Dokumentasi hidup:** Test menggambarkan perilaku yang diharapkan.

## Materi

### 1. Unit test

- Menguji **logic murni** (fungsi, class) tanpa widget/UI.
- Package: `flutter_test` (menyediakan `test`, `expect`, `group`).
- Contoh: `test('increment returns value + 1', () { expect(increment(0), 1); });`
- `group('Counter', () { ... });` untuk mengelompokkan test terkait.

### 2. Widget test

- Menguji **satu widget atau pohon widget** dalam lingkungan test.
- API: `testWidgets()`, `pumpWidget()`, `find` (byType, byKey, text), `tester.tap()`, `tester.pump()`.
- Contoh: pump app → cari teks "0" → tap FAB → pump → cari teks "1".
- Gunakan `Key` pada widget agar `find.byKey()` stabil.

### 3. Integration test

- Menguji **alur lengkap** aplikasi (seperti pengguna memakai app).
- Package: `integration_test` (SDK).
- `IntegrationTestWidgetsFlutterBinding.ensureInitialized();` di awal.
- Dijalankan dengan **flutter drive** (app berjalan di device/emulator, test di host).

---

## File di folder ini

| File | Deskripsi |
|------|-----------|
| `pubspec.yaml` | Flutter + integration_test (dev_dependencies) |
| `lib/main.dart` | Counter app (target widget/integration test) |
| `lib/counter.dart` | Logic murni: increment(), class Counter (target unit test) |
| `test/unit_test_test.dart` | Unit test: increment, Counter |
| `test/widget_test_test.dart` | Widget test: counter screen, FAB tap |
| `integration_test/app_test.dart` | Integration test: full app flow |
| `test_driver/integration_test.dart` | Driver untuk `flutter drive` |
| `README.md` | Dokumen ini |

## Cara menjalankan

**Unit test + Widget test:**

```bash
cd 12-testing && flutter pub get && flutter test
```

**Integration test** (butuh device/emulator):

```bash
cd 12-testing
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart
```

Integration test akan menjalankan app di device/emulator dan menjalankan skenario test (tap, assert teks).
