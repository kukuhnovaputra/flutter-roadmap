# Level 3: Operators & Control Flow

**Operators** dipakai untuk berhitung dan menggabungkan kondisi. **Control flow** mengatur alur eksekusi kode: percabangan (if/switch) dan pengulangan (loop). **Error handling** menangani kegagalan agar aplikasi tidak crash. Bersama-sama mereka memberi "otak" pada aplikasi untuk mengambil keputusan.

**Tujuan Level 3:** Menguasai logika alur aplikasi yang kompleks.

**Panduan ini (README) tampil otomatis di GitHub saat folder ini dibuka.**

---

## 1. Operators (Operator)

### 1.1 Aritmatika

Untuk perhitungan angka.

| Operator | Makna | Contoh |
| -------- | ----- | ------ |
| `+` | Tambah | `10 + 3` → 13 |
| `-` | Kurang | `10 - 3` → 7 |
| `*` | Kali | `10 * 3` → 30 |
| `/` | Bagi (hasil double) | `10 / 3` → 3.333... |
| `~/` | Bagi bulat (hasil int) | `10 ~/ 3` → 3 |
| `%` | Sisa bagi (modulo) | `10 % 3` → 1 |
| `++` / `--` | Increment / decrement | `i++`, `--i` |

**Contoh kode:**

```dart
void main() {
  int a = 10, b = 3;
  print(a + b);   // 13
  print(a / b);   // 3.333...
  print(a ~/ b);  // 3
  print(a % b);   // 1
  a++;            // 11
}
```

### 1.2 Perbandingan

Hasilnya `bool` (true/false).

| Operator | Makna |
| -------- | ----- |
| `==` | Sama dengan |
| `!=` | Tidak sama |
| `>`, `<` | Lebih besar / lebih kecil |
| `>=`, `<=` | Lebih besar/kecil atau sama |

```dart
void main() {
  print(10 == 20);  // false
  print(10 < 20);   // true
  print('halo' == 'halo'); // true
}
```

### 1.3 Logika

Menggabungkan kondisi boolean.

| Operator | Makna | Contoh |
| -------- | ----- | ------ |
| `!` | NOT (membalik) | `!false` → true |
| `&&` | AND (keduanya true) | keduanya harus true |
| `\|\|` | OR (salah satu true) | salah satu true maka true |

```dart
void main() {
  bool login = true, admin = false;
  print(login && admin);  // false
  print(login || admin); // true
  print(!admin);         // true
}
```

### 1.4 Null-aware

Aman dipakai saat nilai bisa null.

| Operator | Makna | Contoh |
| -------- | ----- | ------ |
| `??` | Default jika null | `nama ?? 'Anonim'` |
| `?.` | Safe call (tidak crash jika null) | `teks?.length` |
| `??=` | Assign hanya jika masih null | `status ??= 'pending'` |

```dart
void main() {
  String? nama;
  print(nama ?? 'Anonim');  // Anonim
  print(nama?.length);     // null
  nama ??= 'User';
  print(nama);             // User
}
```

---

## 2. Control Flow (Alur Kendali)

### 2.1 If - Else

Eksekusi berdasarkan kondisi.

```dart
void main() {
  int nilai = 85;
  if (nilai >= 75) {
    print('Lulus');
  } else {
    print('Tidak lulus');
  }

  // else if
  if (nilai >= 90) {
    print('A');
  } else if (nilai >= 80) {
    print('B');
  } else {
    print('C atau kurang');
  }
}
```

### 2.2 Loop

| Jenis | Kapan dipakai |
| ----- | -------------- |
| `for` | Jumlah iterasi jelas atau iterate list |
| `for-in` | Loop setiap elemen list/set |
| `while` | Kondisi dicek di awal |
| `do-while` | Kondisi dicek di akhir (minimal 1x jalan) |

```dart
void main() {
  for (int i = 0; i < 3; i++) print('i=$i');
  for (var x in [1, 2, 3]) print('x=$x');

  int j = 0;
  while (j < 2) { print('j=$j'); j++; }

  int k = 0;
  do { print('k=$k'); k++; } while (k < 2);

  for (int i = 0; i < 5; i++) {
    if (i == 2) continue; // lewati 2
    if (i == 4) break;    // hentikan
    print(i);
  }
}
```

### 2.3 Switch - Case

Pilih satu cabang berdasarkan nilai. Di Dart 3+ mendukung **pattern matching** (tipe, record, guard).

```dart
void main() {
  String hari = 'Senin';
  switch (hari) {
    case 'Senin':
      print('Awal minggu');
      break;
    case 'Sabtu':
    case 'Minggu':
      print('Akhir minggu');
      break;
    default:
      print('Hari kerja');
  }

  // Switch expression (Dart 3+)
  int skor = 85;
  String grade = switch (skor) {
    >= 90 => 'A',
    >= 80 => 'B',
    >= 70 => 'C',
    _ => 'D',
  };
  print(grade); // B

  // Pattern: type check
  Object obj = 42;
  switch (obj) {
    case int n: print('int: $n'); break;
    case String s: print('String: $s'); break;
    default: print('Lainnya');
  }
}
```

---

## 3. Error Handling (Penanganan Error)

Menangkap dan melempar exception agar program tidak crash. Konteks lanjutan (misalnya HTTP) dibahas di Level 9.

| Sintaks | Makna |
| ------- | ----- |
| `try { }` | Blok kode yang mungkin error |
| `catch (e)` | Tangkap error (e = object error) |
| `on TipeException` | Tangkap hanya tipe exception tertentu |
| `finally { }` | Selalu dijalankan (dengan atau tanpa error) |
| `throw` | Melempar exception |
| `rethrow` | Lempar ulang exception yang baru ditangkap |

**Contoh kode:**

```dart
void main() {
  try {
    int x = 10 ~/ 0; // IntegerDivisionByZeroException
  } catch (e) {
    print('Error: $e');
  }

  try {
    int.parse('abc'); // FormatException
  } on FormatException {
    print('Bukan angka valid');
  } catch (e) {
    print('Lain: $e');
  } finally {
    print('Selesai');
  }

  try {
    validasi(-1);
  } catch (e) {
    print(e);
  }
}

void validasi(int umur) {
  if (umur < 0) throw ArgumentError('Umur tidak valid: $umur');
}
```

**Rethrow** — menangkap untuk log/cleanup lalu lempar lagi ke pemanggil:

```dart
void panggil() {
  try {
    throw Exception('Error');
  } catch (e) {
    print('Log: $e');
    rethrow;
  }
}
```

---

## File di folder ini (urutan belajar)

| File | Materi |
| ------ | -------- |
| `operators.dart` | Aritmatika, Perbandingan, Logika, Null-aware |
| `control_flow.dart` | If-Else, For, While, do-while, Switch, Pattern matching |
| `error_handling.dart` | try/catch/finally, throw, rethrow |
| `README.md` | Dokumen ini (panduan level) |

Jalankan: `dart run nama_file.dart` (atau lewat IDE).
