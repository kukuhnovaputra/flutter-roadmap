// Level 5 - OOP: MIXIN
// Mixin untuk reusable code tanpa inheritance.
// Mixin memungkinkan class menggunakan kode dari beberapa sumber tanpa multiple inheritance.

void main() {
  // 1. Mixin dasar - Menggunakan with keyword
  // Class bisa menggunakan mixin untuk mendapatkan methods/properties tanpa inheritance.
  var burung = Burung('Merpati');
  burung.terbang(); // Method dari mixin Terbang
  burung.berenang(); // Method dari mixin Berenang
  print('---');

  // 2. Multiple mixins - Class bisa pakai beberapa mixin
  // Urutan mixin penting jika ada konflik nama method (yang terakhir menang).
  var pesawat = Pesawat('Boeing 737');
  pesawat.terbang(); // Dari Terbang mixin
  pesawat.mendarat(); // Dari Mendarat mixin
  print('---');

  // 3. Mixin dengan properties
  // Mixin bisa punya properties yang akan menjadi bagian dari class yang menggunakannya.
  var kucing = Kucing('Kitty');
  kucing.berlari(); // Dari Berlari mixin
  print('Kecepatan: ${kucing.kecepatan} km/jam'); // Property dari mixin
  print('---');

  // 4. Mixin dengan methods yang menggunakan properties class
  // Mixin bisa akses properties dari class yang menggunakannya.
  var mobil = Mobil('Toyota');
  mobil.berlari();
  print('Mobil ${mobil.nama} berlari dengan kecepatan ${mobil.kecepatan} km/jam');
  print('---');

  // 5. Mixin dengan constraint (on keyword) - Opsional untuk dasar
  // Mixin bisa membatasi class mana yang bisa menggunakannya.
  var kuda = Kuda('Pony');
  kuda.berlari(); // Dari Berlari mixin
  kuda.melompat(); // Dari Melompat mixin (hanya untuk Hewan)
  print('---');

  // 6. Kombinasi inheritance dan mixin
  // Class bisa extends class lain dan menggunakan mixin sekaligus.
  var superman = SuperHero('Superman');
  superman.terbang(); // Dari Terbang mixin
  superman.kekuatan(); // Dari Hero class
}

// Mixin dasar - Hanya methods
mixin Terbang {
  void terbang() {
    print('Terbang di udara!');
  }
}

mixin Berenang {
  void berenang() {
    print('Berenang di air!');
  }
}

mixin Mendarat {
  void mendarat() {
    print('Mendarat dengan mulus');
  }
}

// Mixin dengan properties
mixin Berlari {
  double kecepatan = 0;

  void berlari() {
    kecepatan = 20;
    print('Berlari dengan kecepatan $kecepatan km/jam');
  }
}

// Mixin dengan constraint (on keyword)
// Hanya class yang extends/implements Hewan yang bisa pakai mixin ini
mixin Melompat on Hewan {
  void melompat() {
    print('$nama melompat tinggi!');
  }
}

class Burung with Terbang, Berenang {
  String nama;
  Burung(this.nama);
}

class Pesawat with Terbang, Mendarat {
  String model;
  Pesawat(this.model);
}

class Kucing with Berlari {
  String nama;
  Kucing(this.nama);
}

class Mobil with Berlari {
  String nama;
  Mobil(this.nama);
}

class Hewan {
  String nama;
  Hewan(this.nama);
}

class Kuda extends Hewan with Berlari, Melompat {
  Kuda(String nama) : super(nama);
}

class Hero {
  String nama;
  Hero(this.nama);

  void kekuatan() {
    print('$nama memiliki kekuatan super!');
  }
}

class SuperHero extends Hero with Terbang {
  SuperHero(String nama) : super(nama);
}
