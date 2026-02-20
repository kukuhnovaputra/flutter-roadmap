// Level 1 - Data Types: ASYNC TYPES
// Future dan Stream — untuk operasi asynchronous (tidak blocking).
// Flutter dan Dart dirancang "async first" untuk UI responsif dan koneksi jaringan.

void main() async {
  // 1. Future - Nilai atau error yang tersedia nanti (sekali)
  // Dipakai untuk: HTTP request, baca file, delay, database query.
  print('--- Future ---');

  // Future.delayed: simulasi operasi yang butuh waktu.
  Future.delayed(Duration(seconds: 1), () => print('Selesai setelah 1 detik!'));

  // async/await: menunggu Future tanpa block (kode lebih mudah dibaca).
  String hasil = await fetchData();
  print('Hasil fetch: $hasil');

  // .then() alternatif (tanpa async/await).
  fetchData().then((value) => print('Via then: $value'));

  // Error handling: try/catch saat await.
  try {
    String data = await fetchDataMungkinError();
    print('Data: $data');
  } catch (e) {
    print('Error: $e');
  }

  // 2. Stream - Serangkaian nilai yang datang over time (bisa banyak)
  // Dipakai untuk: event (klik), WebSocket, file line-by-line, sensor.
  print('--- Stream ---');

  // Stream.periodic: nilai berulang setiap interval (contoh sederhana).
  final stream = Stream.periodic(
    Duration(milliseconds: 500),
    (count) => count,
  ).take(5); // Ambil 5 nilai pertama saja

  await for (final value in stream) {
    print('Stream value: $value');
  }

  // .listen() cara lain mendengarkan Stream.
  final single = Stream.value(42);
  single.listen((v) => print('Single stream: $v'));
}

Future<String> fetchData() async {
  await Future.delayed(Duration(milliseconds: 100));
  return 'Data dari server';
}

Future<String> fetchDataMungkinError() async {
  await Future.delayed(Duration(milliseconds: 50));
  throw Exception('Server sibuk');
}
