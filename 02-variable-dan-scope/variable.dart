// Level 2 - Variables & Scope: VARIABLES
// Keywords: var, final, const, late.
// Null Safety: nullable (?), null assertion (!), null-aware (??).
// Mengelola lifecycle variabel dan menulis kode aman dari error null.

void main() {
  // 1. var - Mutable, tipe di-infer dari nilai
  // Bisa diubah berkali-kali. Dart menebak tipe dari nilai yang diberikan.
  // Gunakan saat nilai bisa berubah atau tipe sudah jelas dari konteks.
  var skor = 10;
  skor = 20; // Boleh diubah
  print('Skor: $skor');

  // var dengan tipe eksplisit juga boleh (tapi jarang dipakai).
  var namaLengkap = 'Kukuh Nova Putra'; // Dart tahu ini String
  print('Nama: $namaLengkap');

  // 2. final - Immutable, nilai ditentukan saat runtime
  // Hanya bisa diisi sekali, tapi nilai bisa dari hasil perhitungan/runtime.
  // Gunakan saat nilai tidak akan berubah setelah diisi, tapi butuh dihitung saat program jalan.
  final String nama = 'Kukuh';
  // nama = 'Nova'; // ERROR! final tidak bisa diubah setelah diisi.

  final waktuSekarang = DateTime.now(); // Boleh, karena runtime
  print('Waktu sekarang: $waktuSekarang');

  // 3. const - Immutable, nilai harus diketahui saat compile-time
  // Harus literal atau ekspresi yang bisa dihitung saat compile.
  // Gunakan untuk konstanta yang benar-benar tetap (pi, konfigurasi, dll).
  const pi = 3.14;
  const maxRetry = 3;
  print('Pi: $pi, Max retry: $maxRetry');

  // const waktu = DateTime.now(); // ERROR! Tidak bisa dihitung saat compile.

  // 4. late - Janji akan diisi sebelum digunakan
  // Berguna untuk variabel yang tidak bisa langsung diisi tapi akan diisi nanti.
  // Dart akan error jika variabel late digunakan sebelum diisi.
  late String alamat;
  alamat = 'Jakarta'; // Harus diisi sebelum digunakan
  print('Alamat: $alamat');

  // late juga berguna untuk lazy initialization (nilai dihitung saat pertama kali dipakai).
  late final hargaTotal = hitungHarga(); // Hanya dihitung saat pertama kali dipakai
  print('Harga total: $hargaTotal');

  // 5. Non-Nullable (default di Dart) - Tidak boleh berisi null
  // Secara default, variabel di Dart tidak boleh null (null safety).
  String pesan = 'Halo';
  int jumlah = 5;
  // pesan = null; // ERROR: Tidak boleh diisi null
  // jumlah = null; // ERROR: Tidak boleh diisi null

  // 6. Nullable (?) - Boleh berisi null
  // Gunakan tanda ? setelah tipe untuk mengizinkan null.
  // Berguna saat nilai mungkin belum ada (misalnya dari API, input user).
  String? hobi; // default null
  print('Hobi: $hobi'); // Output: Hobi: null

  hobi = 'Membaca buku';
  print('Hobi sekarang: $hobi');

  hobi = null; // Boleh diisi null lagi
  print('Hobi: $hobi');

  // 7. Null Assertion (!) - Memaksa non-null (hati-hati!)
  // Digunakan saat kita YAKIN 100% variabel nullable itu ada isinya.
  // Jika ternyata null, akan terjadi runtime error!
  String? judulBuku = 'Flutter for Life';
  print('Judul: ${judulBuku!.toUpperCase()}'); // Pakai ! agar method bisa dipanggil

  // String? judulKosong;
  // print(judulKosong!.length); // Runtime error jika null!

  // 8. Null-aware Operator (??) - Default value jika null
  // Jika variabel null, gunakan nilai cadangan.
  // Sangat berguna untuk memberikan nilai default yang aman.
  String? status;
  String hasilStatus = status ?? 'Belum ada status';
  print('Status: $hasilStatus'); // Output: Belum ada status

  status = 'Aktif';
  hasilStatus = status ?? 'Belum ada status';
  print('Status: $hasilStatus'); // Output: Status: Aktif

  // Bisa juga langsung di print atau operasi lain.
  print('Status user: ${status ?? 'Tidak diketahui'}');

  // Kombinasi: null-aware call (?.) untuk aman memanggil method pada nullable.
  String? teks;
  print('Panjang teks: ${teks?.length}'); // null jika teks null, tidak crash
  print('Panjang teks (dengan default): ${teks?.length ?? 0}'); // 0 jika null

  print('--- Ringkasan Akhir ---');
  print('Skor: $skor, Nama: $nama, Pi: $pi, Alamat: $alamat');
}

int hitungHarga() {
  print('Menghitung harga...');
  return 100000;
}
