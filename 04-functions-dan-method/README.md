# Level 4: Functions & Method

**Fungsi** mengelompokkan kode yang bisa dipanggil ulang sehingga kita menerapkan prinsip **DRY (Don't Repeat Yourself)**. Parameter mengontrol input (positional, named, optional); arrow syntax mempersingkat fungsi satu ekspresi. **Anonymous functions** dipakai sebagai callback dan di API seperti `.map()`, `.where()`.

**Tujuan Level 4:** Menulis kode yang modular, rapi, dan mudah diuji.

**Panduan ini (README) tampil otomatis di GitHub saat folder ini dibuka.**

---

## 1. Dasar Fungsi

Fungsi punya nama, parameter (opsional), dan body. Bisa mengembalikan nilai (`return`) atau `void`.

```dart
void sapa() {
  print('Halo!');
}

int tambah(int a, int b) {
  return a + b;
}

void main() {
  sapa();
  print(tambah(3, 5)); // 8
}
```

---

## 2. Parameter

| Jenis | Sintaks | Kapan dipakai |
| ----- | ------- | -------------- |
| **Positional** | `(a, b)` | Urutan argument tetap, parameter sedikit |
| **Named** | `({nama, usia})` | Banyak parameter, urutan bebas, lebih terbaca |
| **Optional positional** | `[a, b]` | Parameter opsional, urutan tetap |
| **Optional named** | `{nama?, usia?}` | Opsional dengan nama, bisa default value |
| **required named** | `{required nama}` | Named tapi wajib diisi |

**Contoh kode:**

```dart
// Positional
void cetak(String nama, int usia) {
  print('$nama, $usia tahun');
}

// Named (optional)
void biodata({String? nama, int? usia, String kota = 'Jakarta'}) {
  print('$nama, $usia, $kota');
}

// Optional positional
void greet(String nama, [String? salam]) {
  print('${salam ?? 'Halo'}, $nama!');
}

void main() {
  cetak('Kukuh', 25);
  biodata(nama: 'Budi', usia: 20);
  biodata(usia: 30, nama: 'Citra'); // urutan bebas
  greet('Alice');
  greet('Bob', 'Selamat malam');
}
```

**Default value:** Untuk parameter optional, beri nilai default dengan `= nilai`.

```dart
void order(String item, {int jumlah = 1, String? catatan}) {
  print('$jumlah x $item');
}
```

---

## 3. Arrow Syntax (Expression Body)

Fungsi yang hanya mengembalikan satu ekspresi bisa ditulis dengan `=>` (return implisit).

```dart
int tambah(int a, int b) => a + b;
bool isGenap(int n) => n % 2 == 0;
double luasLingkaran(double r) => 3.14 * r * r;

void main() {
  print(tambah(10, 20));   // 30
  print(isGenap(8));       // true
  print(luasLingkaran(7)); // 153.86
}
```

---

## 4. Anonymous Functions (Lambda)

Fungsi tanpa nama. Bentuk: `(parameter) { body }` atau `(parameter) => expression`. Sering dipakai sebagai callback atau argument (misalnya di `.map()`, `.where()`, `.forEach()`).

```dart
void main() {
  var jumlah = (int a, int b) => a + b;
  print(jumlah(3, 5)); // 8

  var angka = [1, 2, 3, 4, 5];
  var dikaliDua = angka.map((n) => n * 2);
  var genap = angka.where((n) => n % 2 == 0);
  angka.forEach((n) => print(n));
}
```

---

## 5. Closure

Fungsi yang "mengingat" variabel dari scope luar. Berguna untuk factory function (fungsi yang mengembalikan fungsi).

```dart
void main() {
  Function(int) buatPenambah(int tambahan) {
    return (int x) => x + tambahan;
  }
  var tambah10 = buatPenambah(10);
  print(tambah10(3)); // 13
}
```

---

## 6. Function Type & Typedef

Fungsi bisa disimpan di variabel atau di-pass sebagai argument. Typedef memberi nama untuk tipe fungsi agar lebih terbaca.

```dart
typedef IntOperator = int Function(int a, int b);

void jalankan(int a, int b, IntOperator op) {
  print(op(a, b));
}

void main() {
  IntOperator tambah = (a, b) => a + b;
  jalankan(10, 5, tambah);      // 15
  jalankan(10, 5, (a, b) => a - b); // 5 (anonymous inline)
}
```

---

## File di folder ini (urutan belajar)

| File | Materi |
| ------ | -------- |
| `functions.dart` | Positional, Named, Optional parameters; Default value; Arrow syntax |
| `anonymous_functions.dart` | Anonymous functions, closure, callback, typedef function type |
| `README.md` | Dokumen ini (panduan level) |

Jalankan: `dart run nama_file.dart` (atau lewat IDE).
