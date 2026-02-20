# Level 14: How Flutter Works

Level ini fokus pada **pemahaman mendalam** cara Flutter membangun dan merender UI. Dengan memahami widget tree, element tree, render tree, lifecycle, dan pipeline rendering, kamu bisa mengoptimalkan performa dan menyelesaikan masalah debug dengan tepat. Ini adalah langkah terakhir di [pathway resmi Flutter](https://docs.flutter.dev/learn/pathway/how-flutter-works).

**Level ini hanya berisi panduan tertulis (tidak ada project Flutter di folder ini);** materi bersifat konseptual dan praktik bisa dilakukan di project level 6 atau 7.

## Kenapa penting?

Tanpa memahami "bagaimana Flutter bekerja", kamu hanya menulis widget tanpa tahu kapan rebuild terjadi, di mana bottleneck, atau mengapa layout error. Level ini menjawab: **dari kode widget sampai piksel di layar**, proses apa yang terjadi?

---

## 1. Widget tree

- **Widget** adalah deskripsi immutable dari bagian UI (konfigurasi, bukan elemen yang benar-benar di layar).
- **Widget tree** adalah pohon (hierarchy) widget yang kamu tulis: `MaterialApp` → `Scaffold` → `Column` → `Text`, `ElevatedButton`, dll.
- Flutter **traverse** widget tree untuk membangun struktur yang dipakai untuk layout dan paint.
- Setiap `build()` mengembalikan widget tree baru; Flutter membandingkan dengan tree sebelumnya untuk memutuskan apa yang perlu di-update.

**Konsep:** Widget = blueprint. Banyak widget bisa dipakai ulang; mereka tidak "hidup" di memori seperti instance yang mutable.

---

## 2. Element tree

- **Element** adalah objek yang "menghidupkan" widget di dalam tree. Satu widget bisa berkorespondensi dengan satu Element (atau tidak, jika widget diganti).
- Element tree memegang **state** (referensi ke State untuk StatefulWidget) dan **slot** untuk child.
- Saat widget tree berubah (mis. setState), Flutter membandingkan widget lama vs baru dan **update** Element yang ada jika widget-nya sama tipe dan key; kalau beda, Element di-dispose dan dibuat baru.
- Memahami Element membantu saat debug: **Flutter Inspector** (DevTools) menampilkan widget tree yang sebenarnya merepresentasikan element/render object di balik layar.

---

## 3. Render tree (RenderObject)

- **RenderObject** bertanggung jawab untuk **layout** (ukuran, posisi) dan **paint** (menggambar ke layer).
- Setiap RenderObject tahu constraints dari parent, ukuran anak, dan posisi anak. Layout pass menghitung size dan position; paint pass menggambar.
- Widget yang "render" (mis. `Container`, `Text`, `CustomPaint`) akhirnya punya RenderObject di bawahnya. Widget yang hanya mengatur (mis. `Padding`, `Center`) mendelegasikan ke child.
- Masalah layout sering bisa dilacak ke constraint yang salah (unbounded height, dll.) di level RenderObject.

---

## 4. Lifecycle widget

- **StatelessWidget:** Hanya punya `build(BuildContext context)`. Tidak ada state; rebuild sepenuhnya dari parent.
- **StatefulWidget:** Punya pasangan `State<T>`. Lifecycle penting di State:
  - **initState()** — dipanggil sekali saat State pertama kali dimasukkan ke tree. Untuk setup (controller, listener).
  - **didChangeDependencies()** — dipanggil setelah initState dan setiap kali dependency (mis. InheritedWidget) berubah.
  - **build()** — dipanggil setiap kali State perlu rebuild (setState, parent rebuild, dependency change).
  - **dispose()** — dipanggil saat State dihapus dari tree. Wajib lepaskan resource (controller.dispose(), cancel subscription).
- Memahami lifecycle mencegah memory leak (mis. lupa dispose AnimationController) dan memastikan inisialisasi di tempat yang benar.

**Contoh singkat:**

```dart
class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  void initState() {
    super.initState();
    // Setup sekali
  }

  @override
  void dispose() {
    // Bersihkan resource
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

---

## 5. Rendering pipeline

- **Pipeline** singkat: **Build** (widget tree → element tree) → **Layout** (constraints turun, size naik) → **Paint** (layer tree, record per layer) → **Compositing** (gabung layer ke layar).
- **Layout:** Parent memberi constraint ke child; child memilih size; parent lalu memposisikan child.
- **Paint:** RenderObject menggambar ke Layer; Layer digabung (dengan transform, opacity) tanpa perlu repaint semuanya saat ada animasi.
- **Repaint vs Reflow:** Perubahan yang hanya memengaruhi paint (warna, opacity) lebih murah daripada yang mengubah layout (size/position), karena layout bisa mengakibatkan relayout subtree.

---

## 6. Mengapa Flutter "declarative"?

- **Declarative:** Kamu mendeskripsikan **apa** yang tampil (widget tree) untuk state saat ini; Flutter memutuskan **bagaimana** mengubah UI dari state sebelumnya ke state sekarang.
- Berbeda dengan **imperative** (contoh: langsung memanggil `button.setText("...")`). Di Flutter kamu tidak memanipulasi widget lama; kamu mengembalikan widget tree baru, dan framework mendiff lalu update hanya yang berubah.
- Dampak: satu sumber kebenaran (state), kode lebih mudah diprediksi, dan Flutter bisa mengoptimalkan update (hanya rebuild yang perlu).

---

## File di folder ini

| File | Deskripsi |
|------|-----------|
| `README.md` | Dokumen ini: Widget tree, Element tree, Render tree, Lifecycle, Rendering pipeline, Declarative. |

Tidak ada project Flutter di folder ini; materi bersifat konseptual. Praktik lifecycle dan build bisa dilakukan di project level 6 atau 7.

---

## Cara menggunakan panduan ini

1. Baca berurutan: Widget tree → Element tree → Render tree → Lifecycle → Pipeline → Declarative.
2. Saat menulis widget, ingat: widget = deskripsi; setState = minta rebuild; lifecycle initState/dispose untuk resource.
3. Saat debug layout, pakai Flutter DevTools (Widget Inspector, Layer view) untuk melihat tree dan constraint.
4. Referensi resmi: [How Flutter works](https://docs.flutter.dev/learn/pathway/how-flutter-works) dan [Flutter architectural overview](https://docs.flutter.dev/resources/architectural-overview).

---

## Referensi

- [How Flutter works (pathway)](https://docs.flutter.dev/learn/pathway/how-flutter-works)
- [Flutter architectural overview](https://docs.flutter.dev/resources/architectural-overview)
- [Flutter rendering pipeline](https://docs.flutter.dev/resources/inside-flutter)
- [Widget lifecycle (State)](https://api.flutter.dev/flutter/widgets/State-class.html)
