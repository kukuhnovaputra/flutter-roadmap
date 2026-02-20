# Level 6: Widget Basics (Flutter)

**Widget Basics** adalah fondasi UI di Flutter. Semua yang tampil di layar adalah widget: teks, tombol, layout, dan bahkan halaman. Level ini mengenalkan dua jenis widget (Stateless vs Stateful), widget layout utama (Scaffold, Container, Row, Column, Padding, Center), dan cara menangani input pengguna (GestureDetector, TextField, Form, tombol).

**Tujuan Level 6:** Memahami cara membangun layout yang responsif dan menangani interaksi pengguna.

**Cara menjalankan:** Dari root repo, jalankan `cd 06-widget-basics && flutter run` (pastikan Flutter SDK terpasang dan device/emulator siap).

**Panduan ini (README) tampil otomatis di GitHub saat folder ini dibuka.**

---

## 1. Stateless vs Stateful

Di Flutter, widget ada dua jenis: yang tidak menyimpan state (StatelessWidget) dan yang menyimpan state yang bisa berubah (StatefulWidget).

| Konsep | Deskripsi | Kapan dipakai |
|--------|-----------|----------------|
| **StatelessWidget** | Widget yang tampilannya tidak bergantung pada data yang berubah | Teks statis, ikon, layout tetap |
| **StatefulWidget** | Widget yang punya state; UI bisa berubah (setState) | Counter, form, daftar yang berubah |
| **State** | Data yang disimpan di `State<T>`; memicu rebuild saat setState() | Variabel yang memengaruhi tampilan |
| **build()** | Method yang mengembalikan widget tree | Dipanggil setiap rebuild |

**Contoh StatelessWidget:**

```dart
class LabelStatis extends StatelessWidget {
  const LabelStatis({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Teks ini tidak pernah berubah');
  }
}
```

**Contoh StatefulWidget:**

```dart
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _nilai = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Nilai: $_nilai'),
        ElevatedButton(
          onPressed: () => setState(() => _nilai++),
          child: const Text('Tambah'),
        ),
      ],
    );
  }
}
```

---

## 2. Layout: Scaffold, Container, Row, Column, Padding, Center

Widget layout mengatur posisi dan ukuran child.

| Widget | Deskripsi | Penggunaan umum |
|--------|-----------|-----------------|
| **Scaffold** | Kerangka halaman Material: AppBar, body, FAB, drawer | Hampir setiap layar |
| **Container** | Kotak dengan padding, margin, decoration, constraints | Pembungkus dengan border/warna |
| **Row** | Child disusun horizontal | Baris ikon, tombol sejajar |
| **Column** | Child disusun vertikal | Daftar vertikal, form |
| **Padding** | Memberi jarak dalam (padding) pada child | Spacing di dalam widget |
| **Center** | Memusatkan child di ruang yang tersedia | Teks/ikon di tengah |

**Contoh Scaffold + Column + Row:**

```dart
Scaffold(
  appBar: AppBar(title: const Text('Judul')),
  body: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(child: Text('Tengah')),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.star),
            const Icon(Icons.favorite),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('Container dengan decoration'),
        ),
      ],
    ),
  ),
);
```

---

## 3. User Input: GestureDetector, TextField, Form, Tombol

Widget untuk menerima input dari pengguna.

| Widget / Konsep | Deskripsi | Penggunaan |
|-----------------|-----------|------------|
| **GestureDetector** | Mendeteksi tap, long press, drag, dll. | Area yang bisa diklik (bukan tombol) |
| **TextField** | Input teks satu baris | Nama, email, password |
| **Form** | Mengelompokkan field + validasi (GlobalKey) | Form login, registrasi |
| **ElevatedButton** | Tombol utama (filled) | Submit, konfirmasi |
| **TextButton** | Tombol teks (flat) | Batal, link-style |
| **OutlinedButton** | Tombol dengan border | Alternatif secondary |

**Contoh GestureDetector:**

```dart
GestureDetector(
  onTap: () => print('Area di-tap'),
  child: Container(
    padding: const EdgeInsets.all(24),
    color: Colors.blue.shade100,
    child: const Center(child: Text('Tap saya')),
  ),
)
```

**Contoh Form + TextField + validasi:**

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        decoration: const InputDecoration(labelText: 'Nama'),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Wajib diisi';
          return null;
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Lakukan submit
          }
        },
        child: const Text('Submit'),
      ),
    ],
  ),
)
```

---

## 4. DevTools

Flutter DevTools dipakai untuk debug layout (Widget Inspector) dan performance. Cara membuka dan fitur singkat ada di [devtools.md](devtools.md).

---

## File di folder ini (urutan belajar)

| File | Materi |
|------|--------|
| `lib/main.dart` | MaterialApp, daftar demo, navigasi ke tiap layar |
| `lib/stateless_stateful.dart` | StatelessWidget, StatefulWidget, setState, build |
| `lib/layout_widgets.dart` | Scaffold, Container, Row, Column, Padding, Center |
| `lib/user_input.dart` | GestureDetector, TextField, Form, ElevatedButton, TextButton, OutlinedButton |
| `README.md` | Dokumen ini (panduan level) |

Jalankan project: `cd 06-widget-basics && flutter run`.
