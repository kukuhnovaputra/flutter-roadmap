// Level 5 - OOP: INTERFACE
// Interface (kontrak yang harus diimplement).
// Di Dart, interface dibuat dengan abstract class atau class biasa. implements memaksa implement semua methods.

void main() {
  // 1. Interface via abstract class - implements keyword
  // implements memaksa class untuk mengimplement SEMUA methods dari interface.
  var printer = Printer();
  printer.cetak(); // Implement dari ICetak
  printer.scan(); // Implement dari IScan
  print('---');

  // 2. Multiple interfaces - Class bisa implement beberapa interface
  // Semua methods dari semua interface harus diimplement.
  var scanner = Scanner();
  scanner.scan(); // Dari IScan
  scanner.fax(); // Dari IFax
  print('---');

  // 3. Perbedaan extends vs implements
  // extends: mewarisi implementasi (bisa pakai method yang sudah ada)
  // implements: kontrak (harus implement semua methods sendiri)
  var kucing = Kucing('Meong');
  kucing.bersuara(); // Implement sendiri (tidak inherit)
  kucing.info(); // Dari Animal (extends)

  var anjing = Anjing('Doggy');
  anjing.bersuara(); // Implement sendiri
  anjing.info(); // Dari Animal
  print('---');

  // 4. Interface dengan properties
  // Interface bisa mendefinisikan properties yang harus diimplement.
  var mobil = MobilListrik('Tesla', 100);
  print('Merk: ${mobil.merk}');
  print('Baterai: ${mobil.baterai}%');
  mobil.charge();
  print('---');

  // 5. Interface sebagai type - Polymorphism
  // Variabel bisa bertipe interface, bisa diisi dengan class yang implement interface tersebut.
  ICetak alatCetak1 = Printer();
  ICetak alatCetak2 = PrinterLaser();
  alatCetak1.cetak();
  alatCetak2.cetak();
}

// Interface via abstract class
abstract class ICetak {
  void cetak();
}

abstract class IScan {
  void scan();
}

abstract class IFax {
  void fax();
}

// Class implements interface - Harus implement semua methods
class Printer implements ICetak, IScan {
  @override
  void cetak() {
    print('Printer: Mencetak dokumen...');
  }

  @override
  void scan() {
    print('Printer: Mengscan dokumen...');
  }
}

class Scanner implements IScan, IFax {
  @override
  void scan() {
    print('Scanner: Mengscan...');
  }

  @override
  void fax() {
    print('Scanner: Mengirim fax...');
  }
}

// Perbedaan extends vs implements
class Animal {
  String nama;
  Animal(this.nama);

  void info() {
    print('Hewan: $nama');
  }
}

// implements: Harus implement semua methods sendiri (termasuk yang ada di Animal)
class Kucing extends Animal implements IBersuara {
  Kucing(String nama) : super(nama);

  @override
  void bersuara() {
    print('$nama: Meong!');
  }
}

class Anjing extends Animal implements IBersuara {
  Anjing(String nama) : super(nama);

  @override
  void bersuara() {
    print('$nama: Guk guk!');
  }
}

abstract class IBersuara {
  void bersuara();
}

// Interface dengan properties
abstract class IKendaraanListrik {
  String get merk;
  int get baterai;
  void charge();
}

class MobilListrik implements IKendaraanListrik {
  @override
  final String merk;
  @override
  int baterai;

  MobilListrik(this.merk, this.baterai);

  @override
  void charge() {
    if (baterai < 100) {
      baterai = 100;
      print('$merk: Baterai terisi penuh!');
    } else {
      print('$merk: Baterai sudah penuh');
    }
  }
}

// Polymorphism dengan interface
class PrinterLaser implements ICetak {
  @override
  void cetak() {
    print('Printer Laser: Mencetak dengan teknologi laser...');
  }
}
