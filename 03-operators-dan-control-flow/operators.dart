// Level 3 - Operators & Control Flow: OPERATORS
// Aritmatika, Perbandingan, Logika, dan Null-aware (??, ?.).
// Memberi "otak" pada aplikasi untuk berhitung dan mengambil keputusan.

void main() {
  // 1. Operator Aritmatika - Untuk perhitungan angka
  // +, -, *, /, ~/, % (modulo), -expr (negasi), ++ (increment), -- (decrement)
  int a = 10;
  int b = 3;
  print('a = $a, b = $b');
  print('a + b = ${a + b}');  // 13
  print('a - b = ${a - b}');  // 7
  print('a * b = ${a * b}');  // 30
  print('a / b = ${a / b}');  // 3.333... (hasil double)
  print('a ~/ b = ${a ~/ b}'); // 3 (pembagian bulat, hasil int)
  print('a % b = ${a % b}');  // 1 (sisa bagi)

  int counter = 5;
  counter++; // 6 (post-increment)
  print('counter++ = $counter');
  ++counter; // 7 (pre-increment)
  print('++counter = $counter');
  counter--; // 6
  print('counter-- = $counter');

  // 2. Operator Perbandingan - Hasilnya bool (true/false)
  // ==, !=, >, <, >=, <=
  int x = 10;
  int y = 20;
  print('x == y: ${x == y}');  // false
  print('x != y: ${x != y}');  // true
  print('x > y: ${x > y}');    // false
  print('x < y: ${x < y}');    // true
  print('x >= 10: ${x >= 10}'); // true
  print('y <= 20: ${y <= 20}'); // true

  // Untuk String: perbandingan isi (bukan referensi)
  print("'halo' == 'halo': ${'halo' == 'halo'}"); // true

  // 3. Operator Logika - Menggabungkan kondisi boolean
  // ! (NOT), && (AND), || (OR)
  bool isLogin = true;
  bool isAdmin = false;
  print('!isAdmin: ${!isAdmin}');           // true (membalik)
  print('isLogin && isAdmin: ${isLogin && isAdmin}'); // false (keduanya harus true)
  print('isLogin || isAdmin: ${isLogin || isAdmin}'); // true (salah satu true)

  // Contoh praktis: validasi
  int nilai = 85;
  int kkm = 75;
  bool lulus = nilai >= kkm && nilai <= 100;
  print('Nilai $nilai, KKM $kkm. Lulus: $lulus');

  // 4. Null-aware Operators - Aman dengan nilai null
  // ?? (default jika null), ?. (safe call), ??= (assign jika null)
  String? nama;
  print('Nama: ${nama ?? "Anonim"}'); // Anonim (karena nama null)

  String? teks;
  print('Panjang: ${teks?.length}'); // null (safe call, tidak crash)
  teks = 'Dart';
  print('Panjang: ${teks?.length}'); // 4

  String? status;
  status ??= 'pending'; // Hanya assign jika status masih null
  print('Status: $status'); // pending
  status ??= 'aktif';   // Tidak berubah karena status sudah ada isi
  print('Status: $status'); // tetap pending

  // Cascade (..) - Memanggil beberapa method pada objek yang sama (bonus)
  var buffer = StringBuffer();
  buffer
    ..write('Halo ')
    ..write('Dart ')
    ..write('!');
  print('Buffer: $buffer');
}
