// Level 5 - OOP: CLASS
// Class, Constructor, Properties, Methods.
// Flutter adalah framework berbasis OOP. Level ini adalah yang terpenting.

void main() {
  // 1. Class dasar - Membuat instance
  // Di Dart, keyword 'new' opsional (bisa dipakai atau tidak).
  var mobil1 = Mobil('Toyota', 2020);
  mobil1.info();

  var mobil2 = new Mobil('Honda', 2021); // 'new' opsional
  mobil2.info();
  print('---');

  // 2. Constructor dengan parameter - this keyword
  // this.merk = merk adalah shortcut untuk assign parameter ke property.
  var mobil3 = Mobil('Suzuki', 2022);
  print('Merk: ${mobil3.merk}, Tahun: ${mobil3.tahun}');
  print('---');

  // 3. Named constructor - Constructor dengan nama khusus
  // Berguna untuk membuat instance dengan cara berbeda (misalnya dari JSON, default value, dll).
  var mobilBaru = Mobil.baru('Mazda', 2024);
  mobilBaru.info();

  var mobilDefault = Mobil.defaultMobil();
  mobilDefault.info();
  print('---');

  // 4. Const constructor - Untuk instance yang immutable dan compile-time constant
  // Semua properties harus final.
  const titik1 = Point(0, 0);
  const titik2 = Point(0, 0);
  print('titik1: (${titik1.x}, ${titik1.y})');
  print('titik2: (${titik2.x}, ${titik2.y})');
  print('titik1 == titik2: ${titik1 == titik2}'); // true (const instances sama)
  print('---');

  // 5. Instance properties - Setiap instance punya copy sendiri
  var mobilA = Mobil('A', 2020);
  var mobilB = Mobil('B', 2021);
  mobilA.merk = 'Toyota'; // Hanya mengubah mobilA
  print('mobilA.merk: ${mobilA.merk}');
  print('mobilB.merk: ${mobilB.merk}');
  print('---');

  // 6. Static properties - Milik class, bukan instance
  // Digunakan untuk data yang sama untuk semua instance (misalnya counter, konfigurasi).
  print('Total mobil dibuat: ${Mobil.total}');
  Mobil.total = 0; // Reset counter
  print('Total setelah reset: ${Mobil.total}');
  print('---');

  // 7. Instance methods - Method yang dipanggil pada instance
  mobil1.klakson();
  mobil2.klakson();
  print('---');

  // 8. Static methods - Method yang dipanggil pada class, bukan instance
  // Tidak bisa akses instance properties/methods, hanya static.
  Mobil.resetTotal();
  print('Total setelah resetTotal(): ${Mobil.total}');
  print('---');

  // 9. this keyword - Referensi ke instance saat ini
  // Berguna saat nama parameter sama dengan property.
  var mobilC = Mobil('C', 2023);
  mobilC.setMerk('Citroen');
  print('Merk setelah setMerk: ${mobilC.merk}');
}

class Mobil {
  String merk;
  int tahun;
  static int total = 0; // Static property - milik class

  // Constructor dengan parameter - shortcut this.merk = merk
  Mobil(this.merk, this.tahun) {
    total++; // Increment counter setiap instance dibuat
  }

  // Named constructor - Constructor dengan nama khusus
  Mobil.baru(String merk, int tahun) : this(merk, tahun);

  // Named constructor dengan default value
  Mobil.defaultMobil()
      : merk = 'Unknown',
        tahun = 2000;

  // Instance method
  void info() {
    print('Mobil: $merk, tahun $tahun');
  }

  void klakson() {
    print('$merk: Beep beep!');
  }

  // Method dengan this untuk kejelasan
  void setMerk(String merk) {
    this.merk = merk; // this.merk = property, merk = parameter
  }

  // Static method - Dipanggil pada class, bukan instance
  static void resetTotal() {
    total = 0;
  }
}

class Point {
  final int x;
  final int y;

  // Const constructor - Semua properties harus final
  const Point(this.x, this.y);
}
