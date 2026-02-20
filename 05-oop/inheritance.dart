// Level 5 - OOP: INHERITANCE
// Inheritance, super, override.
// Pewarisan memungkinkan class mewarisi properties dan methods dari class lain.

void main() {
  // 1. Inheritance dasar - extends keyword
  // Subclass mewarisi semua properties dan methods dari superclass.
  var kucing = Kucing('Meong', 2);
  kucing.info(); // Method dari Animal (superclass)
  kucing.bersuara(); // Method yang di-override
  print('---');

  // 2. super keyword - Memanggil constructor/method dari superclass
  // Di constructor: super(...) untuk memanggil constructor superclass.
  var anjing = Anjing('Doggy', 3);
  anjing.info(); // Dari Animal
  anjing.bersuara(); // Override dari Animal
  print('---');

  // 3. Override method - Mengganti implementasi method dari superclass
  // Gunakan @override annotation untuk kejelasan dan error checking.
  var burung = Burung('Tweety', 1);
  burung.bersuara(); // Override
  burung.info(); // Dari Animal
  print('---');

  // 4. Akses superclass properties dan methods
  // Subclass bisa akses properties/methods public dari superclass.
  var kuda = Kuda('Pony', 5);
  print('Nama: ${kuda.nama}'); // Property dari Animal
  print('Usia: ${kuda.usia}'); // Property dari Animal
  kuda.info(); // Method dari Animal
  kuda.bersuara(); // Override
  print('---');

  // 5. super.method() - Memanggil method superclass dari override
  // Berguna saat ingin menambah behavior, bukan mengganti sepenuhnya.
  var kucingLiar = KucingLiar('Tiger', 10);
  kucingLiar.bersuara(); // Override yang memanggil super.bersuara()
  print('---');

  // 6. Multiple level inheritance - Inheritance berantai
  var kucingRumah = KucingRumah('Kitty', 1, 'Persia');
  kucingRumah.info(); // Dari Animal
  kucingRumah.bersuara(); // Dari Kucing
  kucingRumah.infoKucing(); // Dari KucingRumah
}

class Animal {
  String nama;
  int usia;

  Animal(this.nama, this.usia);

  void bersuara() {
    print('$nama: Hewan bersuara');
  }

  void info() {
    print('Hewan: $nama, $usia tahun');
  }
}

class Kucing extends Animal {
  // Constructor dengan super - Memanggil constructor Animal
  Kucing(String nama, int usia) : super(nama, usia);

  // Override method dari Animal
  @override
  void bersuara() {
    print('$nama: Meong!');
  }
}

class Anjing extends Animal {
  Anjing(String nama, int usia) : super(nama, usia);

  @override
  void bersuara() {
    print('$nama: Guk guk!');
  }
}

class Burung extends Animal {
  Burung(String nama, int usia) : super(nama, usia);

  @override
  void bersuara() {
    print('$nama: Cuit cuit!');
  }
}

class Kuda extends Animal {
  Kuda(String nama, int usia) : super(nama, usia);

  @override
  void bersuara() {
    print('$nama: Hii hii!');
  }
}

class KucingLiar extends Kucing {
  KucingLiar(String nama, int usia) : super(nama, usia);

  @override
  void bersuara() {
    super.bersuara(); // Panggil method dari Kucing dulu
    print('$nama: (mengaum dengan keras)');
  }
}

class KucingRumah extends Kucing {
  String ras;

  KucingRumah(String nama, int usia, this.ras) : super(nama, usia);

  void infoKucing() {
    print('Kucing rumah: $nama, ras $ras');
  }
}
