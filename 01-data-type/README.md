# Level 1: Data Type (Tipe Data)

Dalam pemrograman, **tipe data** adalah klasifikasi yang menentukan jenis nilai yang disimpan dan operasi yang bisa dilakukan. Di Dart/Flutter, pemahaman tipe data sangat krusial karena Dart adalah bahasa yang *statically typed*. Tanpa memahami ini, kita tidak tahu apa yang sedang diproses oleh aplikasi.

**Tujuan Level 1:** Mampu memilih tipe data yang tepat dan menghindari bug "Type Error".

**Panduan ini (README) tampil otomatis di GitHub saat folder ini dibuka.**

---

## 1. Primitive (Tipe Dasar)

Tipe paling dasar: angka, teks, dan logika.

| Tipe     | Deskripsi                    | Contoh nilai        |
| -------- | ---------------------------- | ------------------- |
| `int`    | Bilangan bulat               | `25`, `-10`         |
| `double` | Bilangan desimal             | `1.75`, `36.5`      |
| `num`    | Bisa int atau double         | `70.5` lalu `1500`  |
| `String` | Teks (kutip tunggal/ganda)   | `'Kukuh'`, `"Jum'at"` |
| `bool`   | Hanya `true` atau `false`    | `true`, `false`     |

**Contoh kode:**

```dart
void main() {
  int usia = 25;
  double tinggi = 1.75;
  num jarak = 1500;   // bisa diganti jadi 1500.5
  String nama = 'Kukuh';
  bool isAktif = true;

  // String interpolation: $variabel dan ${ekspresi}
  print('$nama, $usia tahun. Tinggi: $tinggi m.');
  print('Panjang nama: ${nama.length}');
}
```

**Tips String:** Gunakan kutip tunggal `' '` (konvensi Dart/Flutter). Untuk apostrof pakai escape `'Jum\'at'` atau kutip ganda `"Jum'at"`.

---

## 2. Collections (Kumpulan Data)

Untuk menyimpan banyak nilai. Gunakan **generics** (`List<String>`, dll.) agar type-safe.

| Tipe       | Ciri utama              | Simbol / contoh        |
| ---------- | ----------------------- | ---------------------- |
| `List<T>`  | Terurut, boleh duplikat | `['a', 'b', 'a']`      |
| `Set<T>`   | Unik, tidak duplikat    | `{'merah', 'biru'}`    |
| `Map<K,V>` | Pasangan key–value      | `{'nama': 'Kukuh'}`    |
| `Iterable` | Konsep "bisa di-loop"    | List/Set adalah Iterable |

**Contoh kode:**

```dart
void main() {
  List<String> nama = ['Andi', 'Budi', 'Andi'];
  print(nama[0]); // Andi (index dari 0)

  Set<String> warna = {'merah', 'biru', 'merah'};
  print(warna); // {merah, biru} — duplikat hilang

  Map<String, dynamic> user = {'nama': 'Kukuh', 'usia': 25};
  print(user['nama']); // Kukuh
  print(user['alamat'] ?? 'tidak ada'); // default jika key tidak ada

  // Iterable: .map(), .where(), .toList()
  List<int> angka = [1, 2, 3, 4, 5];
  Iterable<int> genap = angka.where((n) => n % 2 == 0);
  print(genap.toList()); // [2, 4]
}
```

---

## 3. Special (Tipe Khusus)

| Tipe      | Deskripsi                                      | Kapan dipakai                    |
| --------- | ---------------------------------------------- | --------------------------------- |
| `dynamic` | Bisa tipe apa saja, tidak dicek saat compile   | Interop; risiko runtime error     |
| `void`    | Tidak mengembalikan nilai                       | Fungsi yang hanya efek samping    |
| `Never`   | Tidak pernah selesai normal (selalu throw/exit)| Fungsi yang selalu throw         |
| `Object`  | Supertype semua tipe (kecuali null)             | Menampung nilai apa pun, akses terbatas |

**Contoh kode:**

```dart
void main() {
  dynamic data = 42;
  data = 'halo'; // boleh ganti tipe
  print(data);   // halo

  cetak('Belajar Dart!'); // fungsi void

  Object obj = 10;
  obj = 'teks'; // boleh, tapi obj.length error — perlu cast (obj as String).length
}

void cetak(String s) {
  print(s); // tidak return apa-apa (void)
}
```

---

## 4. Modern Dart (Nullable, Record, Enum, Typedef, Generics)

### 4.1 Nullable (`?`)

Variabel boleh berisi `null`. Operator: `??` (default), `?.` (safe call), `!` (assert non-null, hati-hati).

```dart
void main() {
  String? nama; // default null
  nama = 'Kukuh';

  String? status;
  String tampil = status ?? 'Belum ada'; // jika null, pakai 'Belum ada'
  print(tampil);

  String? teks;
  print(teks?.length); // null jika teks null (tidak crash)
}
```

### 4.2 Record Type (Dart 3+)

Mengelompokkan beberapa nilai tanpa class.

```dart
void main() {
  (int, String) pos = (1, 'satu');
  print(pos.$1); // 1

  ({String nama, int usia}) named = (nama: 'Budi', usia: 20);
  print(named.nama); // Budi
}
```

### 4.3 Enum

Himpunan nilai tetap (konstanta bernama). Sering dipakai untuk status, theme, dll. di Flutter.

```dart
enum Status { pending, dikirim, selesai }

void main() {
  Status order = Status.dikirim;
  switch (order) {
    case Status.pending:   print('Menunggu'); break;
    case Status.dikirim:   print('Dikirim');  break;
    case Status.selesai:   print('Selesai'); break;
  }
}
```

### 4.4 Typedef

Alias untuk tipe (terutama fungsi), agar kode lebih terbaca.

```dart
typedef Predicate = bool Function(int);

void main() {
  Predicate isPositif = (int n) => n > 0;
  print(isPositif(5));  // true
  print(isPositif(-3)); // false
}
```

### 4.5 Generics

Tipe parametrik: `List<T>`, `Future<T>`. Di Flutter sangat sering: `List<Widget>`, `Future<User>`.

```dart
void main() {
  List<int> bilangan = [1, 2, 3];
  List<String> label = ['a', 'b', 'c'];

  print(pertama(bilangan)); // 1
  print(pertama(label));    // a
}

T? pertama<T>(List<T> list) => list.isEmpty ? null : list.first;
```

---

## 5. Async Types (Future & Stream)

Untuk operasi yang selesai nanti (tidak blocking). Penting untuk HTTP, file, dan UI responsif.

| Tipe     | Deskripsi                          | Contoh penggunaan        |
| -------- | ---------------------------------- | ------------------------- |
| `Future<T>` | Nilai (atau error) yang tersedia nanti, **sekali** | HTTP request, baca file, delay |
| `Stream<T>` | Serangkaian nilai yang datang **berulang**        | Event, WebSocket, sensor       |

**Contoh kode:**

```dart
void main() async {
  // Future: async/await
  String hasil = await fetchData();
  print(hasil);

  // Future: .then()
  fetchData().then((value) => print(value));

  // Stream: await for
  final stream = Stream.periodic(Duration(milliseconds: 200), (i) => i).take(3);
  await for (final v in stream) {
    print('Stream: $v');
  }
}

Future<String> fetchData() async {
  await Future.delayed(Duration(milliseconds: 100));
  return 'Data dari server';
}
```

---

## File di folder ini (urutan belajar)

| File              | Materi                                      |
| ----------------- | ------------------------------------------- |
| `primitive.dart`  | int, double, num, String, bool              |
| `collections.dart`| List, Set, Map, Iterable                    |
| `special.dart`    | dynamic, void, Never, Object                 |
| `modern_dart.dart`| Nullable, Record, Enum, Typedef, Generics   |
| `async_types.dart`| Future, Stream                              |
| `README.md` | Dokumen ini (panduan level) |

Jalankan tiap file dengan: `dart run nama_file.dart` (atau lewat IDE). Semua contoh di atas bisa di-copy ke `void main() { }` dan dijalankan.
