// Level 2 - Variables & Scope: SCOPE
// Global, Local, dan Block Scope.
// Scope menentukan di mana variabel bisa diakses dan berapa lama hidupnya di memori.

// --- GLOBAL SCOPE ---
// Variabel di level paling atas file, di luar fungsi/class.
// Bisa diakses di mana saja dalam file yang sama.
// Hidup selama program berjalan.
String levelUser = 'Premium';
int jumlahPengguna = 100;

void main() {
  // --- LOCAL SCOPE ---
  // Variabel di dalam fungsi, hanya hidup di dalam kurung kurawal fungsi tersebut.
  // Tidak bisa diakses dari fungsi lain atau di luar fungsi.
  // Hidup dari saat fungsi dipanggil sampai fungsi selesai.
  String namaLokal = 'Alice';
  int usia = 25;

  print('Status User: $levelUser'); // Bisa akses Global
  print('Nama: $namaLokal');        // Akses Local
  print('Usia: $usia');

  // --- BLOCK SCOPE ---
  // Variabel di dalam blok (if, for, while, atau blok mandiri {}).
  // Hanya hidup di dalam kurung kurawal blok tersebut.
  // Hidup dari saat blok dieksekusi sampai blok selesai.
  if (true) {
    String kodeRahasia = 'XYZ123';
    int counter = 0;

    // Shadowing: variabel dengan nama sama di scope lebih dalam menutupi variabel di scope luar.
    // namaLokal di dalam blok ini berbeda dengan namaLokal di scope main.
    String namaLokal = 'Bob'; // Menutupi namaLokal di scope main

    print('Di dalam blok if:');
    print('  Nama lokal (shadowing): $namaLokal'); // Mencetak 'Bob', bukan 'Alice'
    print('  Kode: $kodeRahasia');
    print('  Counter: $counter');
  }

  // print(kodeRahasia); // ERROR! kodeRahasia sudah "mati" di luar blok if.
  // print(counter);     // ERROR! counter juga tidak bisa diakses di sini.

  print('Di luar blok if:');
  print('  Nama lokal kembali ke: $namaLokal'); // Kembali ke 'Alice'

  // Contoh block scope di loop.
  for (int i = 0; i < 3; i++) {
    String item = 'Item $i';
    print('  $item');
  }
  // print(item); // ERROR! item hanya hidup di dalam loop.
  // print(i);    // ERROR! i juga hanya hidup di dalam loop.

  // Contoh block scope mandiri (blok tanpa if/for).
  {
    String variabelBlok = 'Hanya di blok ini';
    print('Variabel blok: $variabelBlok');
  }
  // print(variabelBlok); // ERROR! Tidak bisa diakses di luar blok.
}

void fungsiLain() {
  // Bisa akses variabel Global.
  print('Level user dari fungsi lain: $levelUser');
  print('Jumlah pengguna: $jumlahPengguna');

  // Tidak bisa akses variabel Local dari fungsi main.
  // print(namaLokal); // ERROR! namaLokal adalah milik fungsi main.

  // Variabel Local milik fungsi ini sendiri.
  String pesan = 'Halo dari fungsi lain';
  print(pesan);
}
