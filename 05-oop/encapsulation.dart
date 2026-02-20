// Level 5 - OOP: ENCAPSULATION
// Encapsulation: data hiding dengan private members, getter, setter.
// Melindungi data internal dari akses langsung dan memungkinkan validasi.

void main() {
  // 1. Private members - Prefix underscore (_)
  // Variabel/method dengan _ hanya bisa diakses dalam file/library yang sama.
  var akun = AkunBank('12345');
  print('Nomor akun: ${akun.nomorAkun}'); // Public getter
  // print(akun._saldo); // ERROR! _saldo adalah private, tidak bisa diakses dari luar

  // 2. Getter - Akses read-only ke private property
  // Menggunakan get keyword untuk membuat property read-only.
  print('Saldo saat ini: ${akun.saldo}'); // Via getter
  print('---');

  // 3. Setter - Akses write dengan validasi
  // Menggunakan set keyword untuk mengontrol assignment dengan validasi.
  akun.setSaldo(1000); // Via setter dengan validasi
  print('Saldo setelah set: ${akun.saldo}');

  akun.setSaldo(-100); // Validasi: saldo tidak boleh negatif
  print('Saldo setelah set negatif: ${akun.saldo}'); // Tetap 1000
  print('---');

  // 4. Getter dan setter dengan nama sama - Property-like syntax
  // Bisa dipakai seperti property biasa: obj.nilai = x; print(obj.nilai);
  var suhu = Termometer();
  suhu.celsius = 25; // Setter
  print('Celsius: ${suhu.celsius}'); // Getter
  print('Fahrenheit: ${suhu.fahrenheit}'); // Getter computed
  print('---');

  // 5. Private methods - Method yang hanya bisa dipanggil dari dalam class
  var kalkulator = Kalkulator();
  print('Hasil: ${kalkulator.hitung(10, 5)}');
  // kalkulator._validasi(10); // ERROR! Private method tidak bisa dipanggil dari luar
  print('---');

  // 6. Public vs private - Tanpa _ = public, dengan _ = private
  var user = User('kukuh', 'password123');
  print('Username: ${user.username}'); // Public
  // print(user._password); // ERROR! Private
  print('Password valid: ${user.cekPassword('password123')}'); // Via public method
  print('---');

  // 7. Encapsulation dengan computed properties
  // Getter bisa menghitung nilai dari properties lain.
  var persegi = PersegiPanjang(5, 3);
  print('Panjang: ${persegi.panjang}, Lebar: ${persegi.lebar}');
  print('Luas: ${persegi.luas}'); // Computed getter
  print('Keliling: ${persegi.keliling}'); // Computed getter
}

class AkunBank {
  String _nomorAkun; // Private property
  double _saldo = 0; // Private property

  AkunBank(this._nomorAkun);

  // Public getter untuk nomor akun
  String get nomorAkun => _nomorAkun;

  // Public getter untuk saldo (read-only)
  double get saldo => _saldo;

  // Public setter dengan validasi
  void setSaldo(double nilai) {
    if (nilai >= 0) {
      _saldo = nilai;
      print('Saldo diubah menjadi: $_saldo');
    } else {
      print('Error: Saldo tidak boleh negatif');
    }
  }

  // Private method - Hanya bisa dipanggil dari dalam class
  void _validasiSaldo() {
    if (_saldo < 0) {
      _saldo = 0;
    }
  }
}

class Termometer {
  double _celsius = 0;

  // Getter dan setter dengan nama sama (property-like)
  double get celsius => _celsius;

  set celsius(double nilai) {
    if (nilai >= -273.15) {
      // Absolute zero
      _celsius = nilai;
    } else {
      print('Error: Suhu tidak bisa di bawah absolute zero');
    }
  }

  // Computed getter - Menghitung dari property lain
  double get fahrenheit => (_celsius * 9 / 5) + 32;
}

class Kalkulator {
  // Public method
  int hitung(int a, int b) {
    _validasi(a, b); // Memanggil private method
    return a + b;
  }

  // Private method - Hanya bisa dipanggil dari dalam class
  void _validasi(int a, int b) {
    if (a < 0 || b < 0) {
      throw ArgumentError('Angka tidak boleh negatif');
    }
  }
}

class User {
  String username; // Public property
  String _password; // Private property

  User(this.username, this._password);

  // Public method untuk validasi password
  bool cekPassword(String password) {
    return _password == password;
  }

  // Private method untuk hash password (contoh)
  String _hashPassword(String password) {
    // Simulasi hash
    return password.hashCode.toString();
  }
}

class PersegiPanjang {
  double panjang;
  double lebar;

  PersegiPanjang(this.panjang, this.lebar);

  // Computed getter - Menghitung luas dari panjang dan lebar
  double get luas => panjang * lebar;

  // Computed getter - Menghitung keliling
  double get keliling => 2 * (panjang + lebar);
}
