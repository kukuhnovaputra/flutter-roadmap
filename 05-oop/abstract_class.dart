// Level 5 - OOP: ABSTRACT CLASS
// Abstract class dan abstract methods.
// Abstract class tidak bisa diinstansiasi; digunakan sebagai blueprint untuk subclass.

void main() {
  // 1. Abstract class tidak bisa diinstansiasi langsung
  // var bentuk = Bentuk(); // ERROR! Abstract class tidak bisa diinstansiasi

  // 2. Implementasi abstract class - extends dan implement abstract methods
  var lingkaran = Lingkaran(5);
  lingkaran.hitungLuas(); // Abstract method yang diimplement
  lingkaran.info(); // Concrete method dari Bentuk
  print('---');

  var persegi = Persegi(4);
  persegi.hitungLuas(); // Abstract method yang diimplement
  persegi.info(); // Concrete method dari Bentuk
  print('---');

  // 3. Abstract class dengan beberapa abstract methods
  var mobil = Mobil('Toyota', 2020);
  mobil.start(); // Abstract method
  mobil.stop(); // Abstract method
  mobil.info(); // Concrete method
  print('---');

  // 4. Abstract class dengan properties
  var segitiga = Segitiga(3, 4);
  print('Alas: ${segitiga.alas}, Tinggi: ${segitiga.tinggi}');
  segitiga.hitungLuas();
  print('---');

  // 5. Multiple abstract methods - Semua harus diimplement
  var motor = Motor('Honda', 2021);
  motor.start();
  motor.stop();
  motor.klakson();
}

abstract class Bentuk {
  // Abstract method - Tidak ada body, harus diimplement oleh subclass
  void hitungLuas();

  // Concrete method - Sudah ada implementasi, bisa dipakai langsung atau di-override
  void info() {
    print('Ini adalah bentuk');
  }
}

class Lingkaran extends Bentuk {
  double radius;

  Lingkaran(this.radius);

  @override
  void hitungLuas() {
    const pi = 3.14159265359;
    double luas = pi * radius * radius;
    print('Luas lingkaran (r=$radius): $luas');
  }

  @override
  void info() {
    print('Ini adalah lingkaran dengan radius $radius');
  }
}

class Persegi extends Bentuk {
  double sisi;

  Persegi(this.sisi);

  @override
  void hitungLuas() {
    double luas = sisi * sisi;
    print('Luas persegi (s=$sisi): $luas');
  }
}

abstract class Kendaraan {
  String merk;
  int tahun;

  Kendaraan(this.merk, this.tahun);

  // Abstract methods - Harus diimplement
  void start();
  void stop();

  // Concrete method
  void info() {
    print('Kendaraan: $merk, tahun $tahun');
  }
}

class Mobil extends Kendaraan {
  Mobil(String merk, int tahun) : super(merk, tahun);

  @override
  void start() {
    print('$merk: Mesin mobil menyala');
  }

  @override
  void stop() {
    print('$merk: Mobil berhenti');
  }
}

abstract class Bentuk2D {
  // Abstract properties - Harus diimplement oleh subclass
  double get alas;
  double get tinggi;

  void hitungLuas();
}

class Segitiga extends Bentuk2D {
  @override
  final double alas;
  @override
  final double tinggi;

  Segitiga(this.alas, this.tinggi);

  @override
  void hitungLuas() {
    double luas = 0.5 * alas * tinggi;
    print('Luas segitiga: $luas');
  }
}

abstract class KendaraanBermotor {
  String merk;
  int tahun;

  KendaraanBermotor(this.merk, this.tahun);

  void start();
  void stop();
  void klakson(); // Abstract method
}

class Motor extends KendaraanBermotor {
  Motor(String merk, int tahun) : super(merk, tahun);

  @override
  void start() {
    print('$merk: Mesin motor menyala');
  }

  @override
  void stop() {
    print('$merk: Motor berhenti');
  }

  @override
  void klakson() {
    print('$merk: Tin tin!');
  }
}
