// Level 4 - Functions & Method: FUNCTIONS
// Positional, Named, dan Optional Parameters. Arrow Syntax.
// Menerapkan prinsip DRY (Don't Repeat Yourself). Kode modular, rapi, mudah diuji.

void main() {
  // 1. Fungsi dasar - Tanpa parameter, tanpa return (void)
  sapa();
  print('---');

  // 2. Positional Parameters - Urutan argument sesuai urutan parameter
  // Posisi menentukan nilai yang diterima.
  cetakPenjumlahan(10, 5);
  cetakInfo('Kukuh', 25);
  print('---');

  // 3. Named Parameters - Memanggil dengan nama: nama: nilai
  // Urutan tidak harus sama; lebih terbaca untuk parameter banyak.
  cetakBiodata(nama: 'Budi', usia: 20, kota: 'Bandung');
  cetakBiodata(usia: 30, kota: 'Jakarta', nama: 'Citra'); // urutan bebas
  print('---');

  // 4. Optional Parameters
  // 4a. Optional positional - pakai [ ] (default null atau harus default value)
  greet('Alice');
  greet('Bob', 'Selamat malam');
  print('---');

  // 4b. Optional named - pakai { } dan bisa beri default
  hitungLuas(5, 3);
  hitungLuas(5, 3, satuan: 'm²');
  print('---');

  // 5. Default values - Untuk optional (positional atau named)
  pesanOrder('Kopi');
  pesanOrder('Teh', jumlah: 3, catatan: 'Kurang manis');
  print('---');

  // 6. Arrow Syntax (Expression body) - Fungsi satu ekspresi, tanpa block {}
  // return implisit.
  int hasilTambah = tambah(10, 20);
  int hasilKali = kali(4, 5);
  bool genap = isGenap(8);
  print('tambah(10,20)=$hasilTambah, kali(4,5)=$hasilKali, isGenap(8)=$genap');
  print('---');

  // 7. Return value - Fungsi mengembalikan nilai
  double luas = hitungLuasLingkaran(7);
  print('Luas lingkaran r=7: $luas');
}

void sapa() {
  print('Halo!');
}

void cetakPenjumlahan(int a, int b) {
  print('$a + $b = ${a + b}');
}

void cetakInfo(String nama, int usia) {
  print('Nama: $nama, Usia: $usia');
}

void cetakBiodata({required String nama, required int usia, String? kota}) {
  // required = wajib diisi. kota optional (boleh null).
  print('Biodata: $nama, $usia tahun, dari ${kota ?? 'tidak disebutkan'}');
}

void greet(String nama, [String? salam]) {
  // [salam] optional positional. Bisa null.
  print('${salam ?? 'Halo'}, $nama!');
}

void hitungLuas(int panjang, int lebar, {String satuan = 'cm²'}) {
  int luas = panjang * lebar;
  print('Luas: $luas $satuan');
}

void pesanOrder(String item, {int jumlah = 1, String? catatan}) {
  print('Pesan: $jumlah x $item${catatan != null ? ' ($catatan)' : ''}');
}

// Arrow syntax: => expr (return implisit)
int tambah(int a, int b) => a + b;
int kali(int a, int b) => a * b;
bool isGenap(int n) => n % 2 == 0;

double hitungLuasLingkaran(double r) {
  const pi = 3.14159265359;
  return pi * r * r;
}
