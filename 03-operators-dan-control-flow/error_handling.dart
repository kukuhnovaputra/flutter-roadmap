// Level 3 - Operators & Control Flow: ERROR HANDLING (Dasar)
// try / catch / finally, throw, rethrow.
// Perkenalan di sini; konteks HTTP/API akan dibahas lagi di Level 9.
// Dokumentasi: https://dart.dev/language/error-handling

void main() {
  // 1. try - catch - Menangkap error agar program tidak crash
  // Kode yang mungkin error dibungkus try; penanganan di catch.
  print('--- try catch ---');
  try {
    int hasil = 10 ~/ 0; // Integer division by zero -> exception
    print(hasil);
  } catch (e) {
    print('Terjadi error: $e');
  }

  // 2. catch dengan stack trace - Untuk debugging
  try {
    throw FormatException('Format tidak valid');
  } catch (e, stackTrace) {
    print('Error: $e');
    print('Stack trace: $stackTrace');
  }

  // 3. on - Menangkap tipe exception tertentu
  try {
    int.parse('bukan_angka'); // FormatException
  } on FormatException {
    print('Input bukan angka yang valid');
  } on Exception catch (e) {
    print('Exception lain: $e');
  } catch (e) {
    print('Error lain: $e'); // catch-all
  }

  // 4. finally - Selalu dijalankan (dengan atau tanpa error)
  try {
    print('Coba akses...');
    int x = 1;
    print('x = $x');
  } catch (e) {
    print('Error: $e');
  } finally {
    print('Blok finally selalu dijalankan');
  }

  // 5. throw - Melempar exception
  // Gunakan saat kondisi tidak valid; pemanggil harus menangani.
  try {
    validasiUmur(-1);
  } catch (e) {
    print('Validasi gagal: $e');
  }

  try {
    validasiUmur(25);
    print('Umur valid');
  } catch (e) {
    print('Error: $e');
  }

  // 6. rethrow - Melempar ulang exception yang baru saja ditangkap
  // Berguna saat kita catch untuk log/cleanup, lalu ingin pemanggil juga menangani.
  try {
    panggilDenganRethrow();
  } catch (e) {
    print('Ditangkap di main: $e');
  }
}

void validasiUmur(int umur) {
  if (umur < 0 || umur > 150) {
    throw ArgumentError('Umur harus antara 0 dan 150, dapat: $umur');
  }
}

void panggilDenganRethrow() {
  try {
    throw Exception('Error dari dalam');
  } catch (e) {
    print('Log: menangkap $e');
    rethrow; // Lempar lagi ke pemanggil
  }
}
