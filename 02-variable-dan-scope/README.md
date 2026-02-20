# Level 2: Variables & Scope (Ruang Simpan)

Variabel adalah sebuah **identifier** (nama) yang merujuk pada lokasi di memori untuk menyimpan sebuah **value** (nilai). Scope menentukan di mana variabel bisa diakses dan berapa lama hidupnya di memori. Mengelola lifecycle variabel dengan benar membantu menulis kode yang aman dari error null dan lebih mudah dipelihara.

**Tujuan Level 2:** Mengelola lifecycle variabel dan menulis kode aman dari error null.

**Panduan ini (README) tampil otomatis di GitHub saat folder ini dibuka.**

---

## 1. Keywords (var, final, const, late)

Keyword menentukan apakah variabel bisa diubah dan kapan nilainya ditentukan.

| Keyword | Mutability | Kapan nilai ditentukan | Kapan dipakai |
|---------|------------|------------------------|---------------|
| `var`   | Mutable (bisa diubah) | Saat assignment (tipe di-infer) | Nilai bisa berubah atau tipe sudah jelas dari konteks |
| `final` | Immutable (hanya sekali) | Saat runtime | Nilai tidak akan berubah setelah diisi, tapi butuh dihitung saat program jalan |
| `const` | Immutable (hanya sekali) | Saat compile-time | Konstanta yang benar-benar tetap (pi, konfigurasi) |
| `late`  | Bisa mutable/immutable | Nanti (sebelum digunakan) | Variabel yang tidak bisa langsung diisi tapi akan diisi nanti |

**Contoh kode:**

```dart
void main() {
  // var - Mutable, tipe di-infer
  var skor = 10;
  skor = 20; // Boleh diubah
  print('Skor: $skor');

  // final - Immutable, runtime
  final String nama = 'Kukuh';
  // nama = 'Nova'; // ERROR!
  final waktuSekarang = DateTime.now(); // Boleh, karena runtime
  print('Waktu: $waktuSekarang');

  // const - Immutable, compile-time
  const pi = 3.14;
  const maxRetry = 3;
  // const waktu = DateTime.now(); // ERROR! Tidak bisa dihitung saat compile
  print('Pi: $pi');

  // late - Janji akan diisi sebelum digunakan
  late String alamat;
  alamat = 'Jakarta'; // Harus diisi sebelum digunakan
  print('Alamat: $alamat');
}
```

**Tips:**

- Gunakan `const` untuk nilai yang benar-benar tetap (pi, konfigurasi).
- Gunakan `final` untuk nilai yang tidak akan berubah tapi perlu dihitung saat runtime.
- Gunakan `var` saat nilai bisa berubah atau tipe sudah jelas dari konteks.
- Gunakan `late` untuk lazy initialization atau variabel yang akan diisi nanti.

---

## 2. Null Safety

Sistem yang mencegah aplikasi crash akibat data yang kosong. Secara default, variabel di Dart tidak boleh berisi `null` (non-nullable). Gunakan nullable (`?`) jika nilai mungkin belum ada.

| Konsep | Simbol | Deskripsi | Contoh |
|--------|--------|-----------|--------|
| Non-nullable | (default) | Tidak boleh null | `String nama = 'Kukuh';` |
| Nullable | `?` | Boleh null | `String? hobi;` |
| Null assertion | `!` | Memaksa non-null (hati-hati!) | `judul!.toUpperCase()` |
| Null-aware default | `??` | Default jika null | `status ?? 'Belum ada'` |
| Null-aware call | `?.` | Safe call (tidak crash jika null) | `teks?.length` |

**Contoh kode:**

```dart
void main() {
  // Non-nullable (default)
  String pesan = 'Halo';
  // pesan = null; // ERROR!

  // Nullable (?)
  String? hobi; // default null
  hobi = 'Membaca';
  hobi = null; // Boleh

  // Null assertion (!) - Hanya jika YAKIN tidak null
  String? judul = 'Flutter';
  print(judul!.toUpperCase()); // OK karena judul tidak null
  // String? kosong;
  // print(kosong!.length); // Runtime error jika null!

  // Null-aware (??) - Default value
  String? status;
  String tampil = status ?? 'Belum ada status';
  print(tampil); // Belum ada status

  // Null-aware call (?.) - Safe call
  String? teks;
  print(teks?.length); // null jika teks null, tidak crash
  print(teks?.length ?? 0); // 0 jika null
}
```

**Tips:**

- Hindari `!` kecuali benar-benar yakin variabel tidak null.
- Gunakan `??` untuk memberikan nilai default yang aman.
- Gunakan `?.` untuk memanggil method/property pada nullable tanpa crash.

---

## 3. Scope (Cakupan Variabel)

Scope menentukan di mana variabel bisa diakses dan berapa lama hidupnya di memori.

| Scope | Lokasi | Akses | Lifetime |
|-------|--------|-------|----------|
| **Global** | Di luar fungsi/class (level atas file) | Di mana saja dalam file | Selama program berjalan |
| **Local** | Di dalam fungsi `{ }` | Hanya di dalam fungsi tersebut | Dari fungsi dipanggil sampai selesai |
| **Block** | Di dalam blok `if`, `for`, `while`, atau `{}` | Hanya di dalam blok tersebut | Dari blok dieksekusi sampai selesai |

**Shadowing:** Variabel dengan nama sama di scope lebih dalam menutupi variabel di scope luar.

**Contoh kode:**

```dart
// GLOBAL SCOPE - Bisa diakses di mana saja dalam file
String levelUser = 'Premium';

void main() {
  // LOCAL SCOPE - Hanya hidup di dalam fungsi main
  String namaLokal = 'Alice';
  
  print('Status: $levelUser'); // Akses Global
  print('Nama: $namaLokal');   // Akses Local

  // BLOCK SCOPE - Hanya hidup di dalam blok if
  if (true) {
    String kodeRahasia = 'XYZ123';
    
    // Shadowing: namaLokal di dalam blok menutupi namaLokal di scope main
    String namaLokal = 'Bob';
    
    print('Di dalam blok: $namaLokal'); // Mencetak 'Bob'
  }
  
  // print(kodeRahasia); // ERROR! Tidak bisa diakses di luar blok
  print('Di luar blok: $namaLokal'); // Kembali ke 'Alice'
}

void fungsiLain() {
  print(levelUser); // Bisa akses Global
  // print(namaLokal); // ERROR! Tidak bisa akses Local dari fungsi main
}
```

**Tips:**

- Hindari variabel Global sebisa mungkin (bisa menyebabkan bug yang sulit di-debug).
- Gunakan Local scope untuk variabel yang hanya dipakai di satu fungsi.
- Block scope berguna untuk variabel sementara di dalam loop atau kondisi.
- Shadowing bisa membingungkan, gunakan nama yang berbeda jika memungkinkan.

---

## File di folder ini (urutan belajar)

| File | Materi |
|------|--------|
| `1-variable.dart` | Keywords (var, final, const, late) + Null Safety (?, !, ??) |
| `2-scope.dart` | Scope (Global, Local, Block) + Shadowing |
| `README.md` | Dokumen ini (panduan level) |

Jalankan tiap file dengan: `dart run nama_file.dart` (atau lewat IDE). Semua contoh di atas bisa di-copy ke `void main() { }` dan dijalankan.
