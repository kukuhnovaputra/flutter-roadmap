// Level 4 - Functions & Method: ANONYMOUS FUNCTIONS
// Fungsi tanpa nama (lambda), closure, dan passing function sebagai argument.
// Sering dipakai di Flutter: callback, .map(), .where(), .forEach(), dll.

void main() {
  // 1. Anonymous function (lambda) - Fungsi tanpa nama
  // Bentuk: (parameter) { body } atau (parameter) => expression
  var jumlah = (int a, int b) {
    return a + b;
  };
  print('jumlah(3, 5) = ${jumlah(3, 5)}');

  var kali = (int a, int b) => a * b; // arrow untuk satu ekspresi
  print('kali(4, 5) = ${kali(4, 5)}');
  print('---');

  // 2. Passing function sebagai argument - Callback / higher-order function
  // Banyak API Dart/Flutter menerima fungsi sebagai parameter.
  var angka = [1, 2, 3, 4, 5];

  var dikaliDua = angka.map((n) => n * 2);
  print('map (*2): $dikaliDua');

  var genap = angka.where((n) => n % 2 == 0);
  print('where (genap): $genap');

  angka.forEach((n) => print('  forEach: $n'));
  print('---');

  // 3. Closure - Fungsi yang "mengingat" variabel dari scope luar
  // Variabel di luar fungsi tetap bisa diakses saat fungsi dipanggil nanti.
  var buatPenambah = (int tambahan) {
    return (int x) => x + tambahan;
  };
  var tambah10 = buatPenambah(10);
  var tambah5 = buatPenambah(5);
  print('tambah10(3) = ${tambah10(3)}'); // 13
  print('tambah5(3) = ${tambah5(3)}');     // 8
  print('---');

  // 4. Typedef / Function type - Tipe untuk fungsi (opsional, agar lebih jelas)
  // Sering dipakai untuk callback di Flutter (misalnya onPressed).
  IntOperator opTambah = (a, b) => a + b;
  IntOperator opKali = (a, b) => a * b;
  print('opTambah(2,3)=${opTambah(2, 3)}, opKali(2,3)=${opKali(2, 3)}');

  jalankanOperator(10, 5, opTambah);
  jalankanOperator(10, 5, opKali);
  // Inline anonymous function sebagai argument
  jalankanOperator(10, 5, (a, b) => a - b);
  print('---');

  // 5. Contoh praktis: simulasi callback (seperti onPressed di Flutter)
  tombolDitekan(() {
    print('Tombol diklik!');
  });
  hitungLaluPanggil(4, 5, (hasil) {
    print('Hasil perhitungan: $hasil');
  });
}

typedef IntOperator = int Function(int a, int b);

void jalankanOperator(int a, int b, IntOperator op) {
  print('Operator($a, $b) = ${op(a, b)}');
}

void tombolDitekan(VoidCallback action) {
  print('Simulasi: tombol ditekan...');
  action();
}

void hitungLaluPanggil(int a, int b, void Function(int) callback) {
  int hasil = a + b;
  callback(hasil);
}

typedef VoidCallback = void Function();
