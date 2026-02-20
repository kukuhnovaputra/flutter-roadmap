// Level 3 - Operators & Control Flow: CONTROL FLOW
// If-Else, Loop (For, While, do-while), Switch Case (Pattern Matching).
// Mengatur alur eksekusi kode berdasarkan kondisi dan pengulangan.

void main() {
  // 1. If - Else - Eksekusi berdasarkan kondisi
  // Hanya salah satu blok yang dijalankan.
  int nilai = 85;
  if (nilai >= 75) {
    print('Lulus dengan nilai $nilai');
  } else {
    print('Tidak lulus');
  }

  // If - else if - else (rantai kondisi)
  int skor = 92;
  if (skor >= 90) {
    print('Grade: A');
  } else if (skor >= 80) {
    print('Grade: B');
  } else if (skor >= 70) {
    print('Grade: C');
  } else {
    print('Grade: D');
  }

  // 2. Loop - For - Jumlah iterasi diketahui atau iterate collection
  // for (init; condition; update) { }
  print('--- For loop ---');
  for (int i = 0; i < 3; i++) {
    print('i = $i');
  }

  // for-in: iterate list/set
  var items = ['apel', 'pisang', 'jeruk'];
  for (var item in items) {
    print('Item: $item');
  }

  // 3. Loop - While - Kondisi dicek di awal
  // Jalankan selama condition true.
  print('--- While loop ---');
  int j = 0;
  while (j < 3) {
    print('j = $j');
    j++;
  }

  // 4. Loop - do-while - Kondisi dicek di akhir (minimal 1x jalan)
  print('--- do-while loop ---');
  int k = 0;
  do {
    print('k = $k');
    k++;
  } while (k < 3);

  // 5. Switch - Case - Pilih satu dari banyak cabang (nilai eksak)
  // Di Dart 3+: mendukung pattern matching (object, record, dll).
  print('--- Switch case ---');
  String hari = 'Senin';
  switch (hari) {
    case 'Senin':
      print('Awal minggu');
      break;
    case 'Jumat':
      print('Hampir akhir minggu');
      break;
    case 'Sabtu':
    case 'Minggu':
      print('Akhir minggu');
      break;
    default:
      print('Hari kerja');
  }

  // Switch expression (Dart 3+) - mengembalikan nilai
  String grade = switch (skor) {
    >= 90 => 'A',
    >= 80 => 'B',
    >= 70 => 'C',
    _ => 'D',
  };
  print('Grade (expression): $grade');

  // Pattern matching: type check
  Object obj = 42;
  switch (obj) {
    case int n:
      print('Integer: $n');
      break;
    case String s:
      print('String: $s');
      break;
    case double d:
      print('Double: $d');
      break;
    default:
      print('Lainnya');
  }

  // break dan continue
  print('--- break & continue ---');
  for (int i = 0; i < 5; i++) {
    if (i == 2) continue; // lewati 2
    if (i == 4) break;     // hentikan di 4
    print('i = $i');
  }
}
