// Level 1 - Data Types: PRIMITIVE
// Tipe dasar Dart: int, double, num, String, bool.
// Tanpa memahami ini, kita tidak tahu apa yang sedang diproses oleh aplikasi.

void main() {
  // 1. int (Integer) - Bilangan bulat
  // Digunakan untuk: usia, tahun, jumlah, indeks, dll.
  int usia = 25;
  int tahunLahir = 1995;
  print('Usia saya adalah $usia tahun.');
  print('Saya lahir pada tahun $tahunLahir.');
  // Tips: Gunakan kutip tunggal untuk string sesuai konvensi Dart/Flutter.

  // 2. double - Bilangan desimal
  // Digunakan untuk: tinggi, berat, suhu, koordinat, persentase, dll.
  double tinggiBadan = 1.75;
  double suhu = 36.5;
  print('Tinggi badan saya adalah $tinggiBadan meter.');
  print('Suhu tubuh saya adalah $suhu derajat Celsius.');

  // 3. num - Tipe "fleksibel" untuk angka
  // Bisa menampung int maupun double; berguna saat nilai bisa berubah tipe.
  num beratBadan = 70.5;
  num jarak = 1500;   // saat ini int
  jarak = 1500.5;     // boleh diubah ke double
  print('Berat badan: $beratBadan kg. Jarak: $jarak meter.');

  // 4. String - Teks
  // Standar: kutip tunggal (rekomendasi Dart/Flutter).
  String nama = 'Kukuh';
  String alamat = 'Jl. Merdeka No. 123';
  print('Nama saya adalah $nama. Alamat: $alamat.');

  // Karakter khusus: escape (\') atau kutip ganda.
  String hariEscape = 'Jum\'at';
  String hariGanda = "Jum'at";
  print('Hari ini adalah $hariEscape atau $hariGanda.');

  // String interpolation: $variabel untuk variabel, ${} untuk ekspresi/method.
  String hobi = 'Membaca buku';
  print('Hobi: $hobi (panjang: ${hobi.length})');

  // Multi-line string: kutip tiga ''' atau """.
  String paragraf = '''
Dart adalah bahasa pemrograman yang dikembangkan oleh Google.
Dart digunakan untuk web, mobile, dan desktop.
  ''';
  print('Tentang Dart:\n$paragraf');

  // 5. bool (Boolean) - true atau false
  // Sering dipakai untuk kondisi, flag, hasil perbandingan.
  bool sedangAktif = true;
  bool sudahLulus = false;
  print('Sedang aktif? $sedangAktif. Sudah lulus? $sudahLulus.');

  // Boolean dari perbandingan (sangat sering di Flutter).
  int nilaiUjian = 85;
  int kkm = 75;
  bool apakahLulusUjian = nilaiUjian > kkm;
  print('Nilai $nilaiUjian, KKM $kkm. Lulus: $apakahLulusUjian');

  // Operator NOT (!) membalik nilai bool.
  bool isHungry = true;
  print('Kenyang? ${!isHungry}');

  // Tips: operasi di dalam print gunakan ${ }.
  print('Dua tahun lagi usia saya ${usia + 2} tahun.');
}
