// Level 1 - Data Types: SPECIAL
// Tipe khusus: dynamic, void, Never, Object.
// Penting untuk memahami batasan dan risiko (terutama dynamic) agar terhindar dari runtime error.

void main() {
  // 1. dynamic - Bisa menampung tipe apa saja, tidak dicek saat compile
  // Berguna untuk interop atau data yang benar-benar tidak pasti; risiko error di runtime.
  dynamic data = 42;
  print('data adalah: $data (${data.runtimeType})');
  data = 'halo'; // Boleh ganti ke String
  print('data sekarang: $data (${data.runtimeType})');
  // data = 42; data.toUpperCase(); // Runtime error: int tidak punya toUpperCase!

  // 2. void - Tidak mengembalikan nilai (untuk fungsi/procedure)
  // Fungsi void hanya dipanggil untuk efek samping (print, ubah state), bukan untuk nilainya.
  cetakPesan('Belajar Dart itu seru!');

  // 3. Never - Menandakan "tidak pernah selesai normal" (selalu throw/exit)
  // Digunakan untuk fungsi yang selalu melempar error atau infinite loop. Jarang dipakai langsung.
  // Contoh: fungsi yang selalu throw (uncomment untuk coba):
  // neverReturns();

  // 4. Object - Supertype semua tipe (kecuali null di null safety)
  // Bisa menampung nilai tipe apa pun, tapi akses method/property terbatas sampai di-cast.
  Object obj = 10;
  print('Object berisi: $obj');
  obj = 'teks';
  print('Object sekarang: $obj');
  // obj.length; // Error: type Object tidak punya getter length. Perlu cast: (obj as String).length
}

void cetakPesan(String s) {
  print('Pesan: $s');
  // Tidak ada return; tipe kembaliannya void.
}

// Never digunakan untuk fungsi yang tidak pernah return (selalu throw).
Never neverReturns() {
  throw Exception('Fungsi ini tidak pernah selesai normal.');
}
