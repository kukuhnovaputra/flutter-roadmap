# Level 5: OOP (Jantung Flutter)

**OOP (Object-Oriented Programming)** adalah paradigma pemrograman yang mengorganisir kode dalam bentuk **class** dan **object**. Flutter adalah framework berbasis OOP; hampir semua yang kita pakai adalah class (Widget, State, dll.). Memahami OOP adalah kunci untuk memahami arsitektur Flutter dan membangun aplikasi skala besar.

**Tujuan Level 5:** Memahami arsitektur aplikasi skala besar (Enterprise).

**Panduan ini (README) tampil otomatis di GitHub saat folder ini dibuka.**

---

## 1. Class (Kelas)

Class adalah blueprint untuk membuat object. Class mendefinisikan properties (data) dan methods (perilaku).

| Konsep | Deskripsi | Contoh |
|--------|-----------|--------|
| **Class** | Blueprint untuk object | `class Mobil { }` |
| **Instance/Object** | Object yang dibuat dari class | `var mobil = Mobil(...)` |
| **Properties** | Data yang dimiliki object | `String merk; int tahun;` |
| **Methods** | Perilaku/fungsi object | `void info() { }` |
| **Constructor** | Fungsi khusus untuk membuat instance | `Mobil(this.merk, this.tahun)` |
| **Static** | Milik class, bukan instance | `static int total = 0;` |

**Contoh kode:**

```dart
void main() {
  var mobil = Mobil('Toyota', 2020);
  mobil.info();
  print('Total: ${Mobil.total}');
}

class Mobil {
  String merk;
  int tahun;
  static int total = 0;
  
  Mobil(this.merk, this.tahun) {
    total++;
  }
  
  void info() {
    print('$merk, tahun $tahun');
  }
}
```

**Constructor types:**

| Tipe | Sintaks | Kapan dipakai |
|------|---------|---------------|
| Default | `Mobil(this.merk)` | Constructor standar dengan parameter |
| Named | `Mobil.baru(String m)` | Constructor dengan nama khusus |
| Const | `const Point(0, 0)` | Untuk instance immutable (semua properties final) |

---

## 2. Inheritance (Pewarisan)

Inheritance memungkinkan class mewarisi properties dan methods dari class lain menggunakan `extends`.

| Konsep | Deskripsi | Keyword |
|--------|-----------|---------|
| **Superclass** | Class yang diwariskan | `class Animal { }` |
| **Subclass** | Class yang mewarisi | `class Kucing extends Animal { }` |
| **super** | Memanggil constructor/method superclass | `super(nama, usia)` |
| **override** | Mengganti method dari superclass | `@override void bersuara() { }` |

**Contoh kode:**

```dart
void main() {
  var kucing = Kucing('Meong', 2);
  kucing.info();     // Dari Animal
  kucing.bersuara(); // Override dari Animal
}

class Animal {
  String nama;
  int usia;
  Animal(this.nama, this.usia);
  
  void bersuara() => print('Hewan bersuara');
  void info() => print('$nama, $usia tahun');
}

class Kucing extends Animal {
  Kucing(String nama, int usia) : super(nama, usia);
  
  @override
  void bersuara() => print('$nama: Meong!');
}
```

**extends vs implements:**

| Keyword | Makna | Kapan dipakai |
|---------|-------|---------------|
| `extends` | Mewarisi implementasi | Class mewarisi dari class lain |
| `implements` | Kontrak (harus implement semua) | Class mengimplement interface |

---

## 3. Abstract Class

Abstract class tidak bisa diinstansiasi langsung; digunakan sebagai blueprint untuk subclass.

| Konsep | Deskripsi |
|--------|-----------|
| **Abstract class** | Class yang tidak bisa diinstansiasi | `abstract class Bentuk { }` |
| **Abstract method** | Method tanpa implementasi (harus diimplement subclass) | `void hitungLuas();` |
| **Concrete method** | Method dengan implementasi di abstract class | `void info() { print('...'); }` |

**Contoh kode:**

```dart
void main() {
  // var bentuk = Bentuk(); // ERROR! Tidak bisa diinstansiasi
  var lingkaran = Lingkaran(5);
  lingkaran.hitungLuas(); // Abstract method yang diimplement
  lingkaran.info();       // Concrete method dari Bentuk
}

abstract class Bentuk {
  void hitungLuas(); // Abstract - harus diimplement
  
  void info() {      // Concrete - sudah ada implementasi
    print('Ini adalah bentuk');
  }
}

class Lingkaran extends Bentuk {
  double radius;
  Lingkaran(this.radius);
  
  @override
  void hitungLuas() {
    print('Luas: ${3.14 * radius * radius}');
  }
}
```

---

## 4. Mixin

Mixin memungkinkan class menggunakan kode dari beberapa sumber tanpa multiple inheritance.

| Konsep | Deskripsi | Keyword |
|--------|-----------|---------|
| **Mixin** | Reusable code tanpa inheritance | `mixin Terbang { }` |
| **with** | Menggunakan mixin | `class Burung with Terbang { }` |
| **Multiple mixins** | Bisa pakai beberapa mixin | `class X with A, B, C { }` |
| **on** | Constraint mixin (opsional) | `mixin M on Hewan { }` |

**Contoh kode:**

```dart
void main() {
  var burung = Burung('Merpati');
  burung.terbang();  // Dari Terbang mixin
  burung.berenang(); // Dari Berenang mixin
}

mixin Terbang {
  void terbang() => print('Terbang!');
}

mixin Berenang {
  void berenang() => print('Berenang!');
}

class Burung with Terbang, Berenang {
  String nama;
  Burung(this.nama);
}
```

**Mixin vs Inheritance:**

| Fitur | Inheritance (extends) | Mixin (with) |
|-------|------------------------|--------------|
| Jumlah | Hanya satu superclass | Bisa beberapa mixin |
| Tujuan | "is-a" relationship | Reusable behavior |
| Contoh | Kucing adalah Animal | Burung bisa Terbang dan Berenang |

---

## 5. Interface

Interface adalah kontrak yang harus diimplement class. Di Dart, interface dibuat dengan abstract class atau class biasa.

| Konsep | Deskripsi | Keyword |
|--------|-----------|---------|
| **Interface** | Kontrak yang harus diimplement | `abstract class ICetak { }` |
| **implements** | Mengimplement interface | `class Printer implements ICetak { }` |
| **Multiple interfaces** | Bisa implement beberapa interface | `class X implements A, B { }` |

**Contoh kode:**

```dart
void main() {
  var printer = Printer();
  printer.cetak(); // Implement dari ICetak
  printer.scan();  // Implement dari IScan
}

abstract class ICetak {
  void cetak();
}

abstract class IScan {
  void scan();
}

class Printer implements ICetak, IScan {
  @override
  void cetak() => print('Mencetak...');
  
  @override
  void scan() => print('Mengscan...');
}
```

**Perbedaan extends vs implements:**

| Aspek | extends | implements |
|-------|---------|------------|
| Implementasi | Mewarisi implementasi | Harus implement sendiri |
| Methods | Bisa pakai method yang sudah ada | Harus implement semua methods |
| Use case | "is-a" relationship | "can-do" contract |

---

## 6. Encapsulation (Enkapsulasi)

Encapsulation melindungi data internal dari akses langsung menggunakan private members, getter, dan setter.

| Konsep | Deskripsi | Sintaks |
|--------|-----------|---------|
| **Private** | Hanya bisa diakses dalam file/library | `_variabel`, `_method()` |
| **Public** | Bisa diakses dari mana saja | `variabel`, `method()` |
| **Getter** | Akses read-only | `get nilai => _nilai;` |
| **Setter** | Akses write dengan validasi | `set nilai(int n) { if (n > 0) _nilai = n; }` |

**Contoh kode:**

```dart
void main() {
  var akun = AkunBank('12345');
  print(akun.saldo);    // Via getter
  akun.setSaldo(1000);  // Via setter dengan validasi
  // akun._saldo = -100; // ERROR! Private
}

class AkunBank {
  String _nomorAkun; // Private
  double _saldo = 0; // Private
  
  AkunBank(this._nomorAkun);
  
  double get saldo => _saldo; // Getter
  
  void setSaldo(double nilai) { // Setter dengan validasi
    if (nilai >= 0) {
      _saldo = nilai;
    }
  }
}
```

**Getter/setter dengan nama sama (property-like):**

```dart
class Termometer {
  double _celsius = 0;
  
  double get celsius => _celsius;
  set celsius(double n) {
    if (n >= -273.15) _celsius = n;
  }
  
  double get fahrenheit => (_celsius * 9/5) + 32; // Computed getter
}

void main() {
  var suhu = Termometer();
  suhu.celsius = 25;        // Setter
  print(suhu.celsius);      // Getter
  print(suhu.fahrenheit);   // Computed getter
}
```

---

## File di folder ini (urutan belajar)

| File | Materi |
|------|--------|
| `class.dart` | Class dasar, Constructor (default/named/const), Properties (instance/static), Methods (instance/static), this keyword |
| `inheritance.dart` | Inheritance (extends), super, override, multiple level inheritance |
| `abstract_class.dart` | Abstract class, abstract methods, concrete methods, abstract properties |
| `mixin.dart` | Mixin definition, with keyword, multiple mixins, mixin dengan properties, on constraint |
| `interface.dart` | Interface via abstract class, implements keyword, multiple interfaces, extends vs implements |
| `encapsulation.dart` | Private members (_), getter, setter, public vs private, computed properties |
| `README.md` | Dokumen ini (panduan level) |

Jalankan: `dart run nama_file.dart` (atau lewat IDE).
