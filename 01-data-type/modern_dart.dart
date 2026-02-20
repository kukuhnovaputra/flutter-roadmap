// Level 1 - Data Types: MODERN DART
// Nullable (?), Record Type, Enum, Typedef, Generics.
// Fitur modern Dart untuk type safety dan kode yang lebih ekspresif.

void main() {
  // 1. Nullable (?) - Variabel boleh berisi null
  // Tanpa ?, variabel tidak boleh null (null safety). Dengan ?, kita izinkan null.
  String? nama; // default null
  print('Nama: $nama');
  nama = 'Kukuh';
  print('Nama: $nama');

  // Null-aware: ?? (default jika null), ?. (safe call), ! (assert non-null, hati-hati!).
  String? status;
  String tampil = status ?? 'Belum ada status';
  print('Status: $tampil');

  String? teks;
  print('Panjang: ${teks?.length}'); // null jika teks null; tidak crash.
  // teks!.length; // Hanya jika kita YAKIN teks tidak null; kalau null = runtime error.

  // 2. Record Type - Mengelompokkan beberapa nilai (Dart 3+)
  // Bisa positional atau named. Berguna untuk return banyak nilai tanpa class.
  (int, String) positional = (1, 'satu');
  print('Record positional: $positional');
  print('Elemen pertama: ${positional.$1}, kedua: ${positional.$2}');

  ({String nama, int usia}) named = (nama: 'Budi', usia: 20);
  print('Record named: ${named.nama}, ${named.usia}');

  // 3. Enum - Himpunan nilai tetap (konstanta bernama)
  // Memudahkan validasi dan switch; di Flutter sering untuk status, theme, dll.
  StatusOrder order = StatusOrder.dikirim;
  print('Status order: $order');

  switch (order) {
    case StatusOrder.pending:
      print('Menunggu');
      break;
    case StatusOrder.dikirim:
      print('Sudah dikirim');
      break;
    case StatusOrder.selesai:
      print('Selesai');
      break;
  }

  // 4. Typedef - Alias untuk tipe (terutama fungsi)
  // Membuat signature fungsi lebih terbaca dan reusable.
  Predicate isPositif = (int n) => n > 0;
  print('5 positif? ${isPositif(5)}');
  print('-3 positif? ${isPositif(-3)}');

  // 5. Generics - Tipe parametrik: List<T>, Future<T>, dll.
  // Di Flutter sangat sering: List<Widget>, Future<User>, Map<String, dynamic>.
  List<int> bilangan = [1, 2, 3];
  List<String> labels = ['a', 'b', 'c'];
  print('List<int>: $bilangan');
  print('List<String>: $labels');

  // Fungsi generic contoh.
  print('Pertama dari bilangan: ${first(bilangan)}');
  print('Pertama dari labels: ${first(labels)}');
}

enum StatusOrder { pending, dikirim, selesai }

typedef Predicate = bool Function(int);

T? first<T>(List<T> list) => list.isEmpty ? null : list.first;
