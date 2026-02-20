// Level 1 - Data Types: COLLECTIONS
// List, Set, Map, Iterable — koleksi data untuk menyimpan banyak nilai.
// Gunakan type safety (generics) agar terhindar dari bug "Type Error".

void main() {
  // 1. List - Koleksi terurut, boleh duplikat, akses by index
  // Gunakan List<T> (generics) untuk type safety. Di Flutter sering: List<Widget>.
  List<String> namaTeman = ['Andi', 'Budi', 'Citra', 'Andi'];
  print('Nama teman-teman: $namaTeman');
  print('Teman pertama: ${namaTeman[0]}'); // Index dimulai dari 0.

  // 2. Set - Koleksi unik, tidak ada duplikat, urutan tidak dijamin
  // Berguna untuk menghilangkan duplikat otomatis.
  Set<String> warnaFavorit = {'merah', 'biru', 'hijau', 'merah'};
  print('Warna favorit (unik): $warnaFavorit'); // 'merah' hanya sekali.

  // 3. Map - Pasangan key-value (seperti kamus/JSON)
  // Map<String, dynamic> sering dipakai di Flutter untuk data API/JSON.
  Map<String, dynamic> biodata = {
    'nama': 'Kukuh',
    'usia': 30,
    'isHadir': true,
    'hobi': ['membaca', 'bersepeda'],
  };
  print('Biodata: $biodata');
  print('Pekerjaan: ${biodata['pekerjaan'] ?? 'Belum bekerja'}'); // null-safe default.

  // 4. Iterable - Konsep "bisa di-iterate" (List dan Set adalah Iterable)
  // Iterable punya .map(), .where(), .toList(), .length, dll. tanpa mengubah koleksi asli.
  List<int> angka = [1, 2, 3, 4, 5];
  Iterable<int> dikaliDua = angka.map((n) => n * 2);
  print('Angka: $angka');
  print('Dikali dua (Iterable): $dikaliDua');

  Iterable<int> genap = angka.where((n) => n % 2 == 0);
  print('Yang genap: $genap');

  // Konversi Iterable ke List jika butuh list (misalnya akses indeks).
  List<int> listGenap = genap.toList();
  print('List genap: $listGenap');
}
