# Level 7: State Management (Flutter)

**State** adalah data yang bisa berubah dan memengaruhi tampilan UI. Saat state berubah, bagian UI yang bergantung padanya harus di-update (rebuild). **State management** adalah cara mengatur di mana state disimpan dan bagaimana perubahan state didistribusikan ke widget.

Contoh sederhana: counter. Nilai angka (state) berubah saat tombol diklik; teks di layar harus menampilkan nilai terbaru. Untuk aplikasi kecil, `setState` cukup. Untuk aplikasi besar dengan banyak layar dan logic kompleks, dipakai library seperti Provider, Riverpod, atau Bloc/Cubit.

**Tujuan Level 7:** Memahami pilihan state management dari yang paling dasar sampai yang scalable, dan kapan memakai masing-masing.

**Cara menjalankan:** `cd 07-state-management && flutter pub get && flutter run`

**Panduan ini (README) tampil otomatis di GitHub saat folder ini dibuka.**

---

## 1. setState (state lokal)

State disimpan di dalam `State<T>` dari sebuah `StatefulWidget`. Perubahan lewat `setState(() { ... })` memicu rebuild widget tersebut.

| Kelebihan | Kekurangan |
|-----------|------------|
| Tidak perlu package | State tidak bisa dibagi ke widget lain dengan mudah |
| Sederhana, cocok pemula | Logic dan UI tercampur di satu tempat |
| Cukup untuk satu layar | Sulit di-maintain jika state besar |

**Contoh singkat:**

```dart
class CounterScreen extends StatefulWidget {
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$_counter'),
        ElevatedButton(
          onPressed: () => setState(() => _counter++),
          child: const Text('+1'),
        ),
      ],
    );
  }
}
```

---

## 2. Provider

State disimpan di objek yang extends `ChangeNotifier`. `notifyListeners()` memberitahu widget yang "listen" untuk rebuild. Widget mengakses state lewat `Provider`/`Consumer` atau `context.watch`/`context.read`.

| Konsep | Deskripsi |
|--------|-----------|
| **ChangeNotifier** | Class yang bisa memberitahu listener saat data berubah |
| **ChangeNotifierProvider** | Menyediakan instance notifier ke widget tree |
| **Consumer** | Widget yang rebuild saat notifier berubah |
| **context.watch** | Mendengarkan perubahan (rebuild saat berubah) |
| **context.read** | Akses notifier tanpa listen (untuk aksi sekali) |

**Contoh singkat:**

```dart
class CounterNotifier extends ChangeNotifier {
  int _value = 0;
  int get value => _value;
  void increment() {
    _value++;
    notifyListeners();
  }
}

// Di widget:
ChangeNotifierProvider(create: (_) => CounterNotifier(), child: ...)
Consumer<CounterNotifier>(builder: (context, counter, _) => Text('${counter.value}'))
```

Cocok untuk aplikasi kecil–menengah; populer dan dokumentasi banyak.

---

## 3. Riverpod

Provider yang tidak bergantung pada `BuildContext`; state dan dependensi didefinisikan sebagai variabel global (provider). Testing dan override dependensi lebih mudah.

| Konsep | Deskripsi |
|--------|-----------|
| **Provider** | Definisi state (StateProvider, StateNotifierProvider, dll.) |
| **ref.watch** | Mendengarkan provider, rebuild saat berubah |
| **ref.read** | Membaca/memodifikasi tanpa listen |
| **ConsumerWidget** | Widget yang menerima WidgetRef untuk akses provider |

**Contoh singkat:**

```dart
final counterProvider = StateProvider<int>((ref) => 0);

class CounterScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text('$count');
    // ref.read(counterProvider.notifier).state++;
  }
}
```

Pastikan app dibungkus `ProviderScope` (di `main.dart`).

---

## 4. Bloc/Cubit

State dikelola oleh **Cubit** (atau Bloc untuk event-based). State bersifat immutable; setiap perubahan menghasilkan state baru lewat `emit(stateBaru)`. Widget rebuild lewat `BlocProvider` + `BlocBuilder`.

| Konsep | Deskripsi |
|--------|-----------|
| **Cubit** | Mengelola state; method memanggil `emit(state)` |
| **BlocProvider** | Menyediakan Cubit/Bloc ke widget tree |
| **BlocBuilder** | Rebuild saat state Cubit/Bloc berubah |
| **context.read<Cubit>()** | Memanggil method Cubit (tidak trigger rebuild) |

**Contoh singkat:**

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void increment() => emit(state + 1);
}

BlocProvider(create: (_) => CounterCubit(), child: ...)
BlocBuilder<CounterCubit, int>(builder: (context, count) => Text('$count'))
```

Cocok untuk aplikasi besar; alur event → state jelas dan mudah di-test.

---

## Perbandingan singkat

| Pendekatan | Kapan dipakai | Kompleksitas |
|------------|----------------|---------------|
| **setState** | Satu layar, state sederhana | Rendah |
| **Provider** | Beberapa layar, state global sederhana–menengah | Sedang |
| **Riverpod** | Sama seperti Provider, plus butuh testability & dependency injection | Sedang–tinggi |
| **Bloc/Cubit** | Aplikasi besar, alur bisnis kompleks, tim besar | Tinggi |

---

## File di folder ini (urutan belajar)

| File | Materi |
|------|--------|
| `lib/main.dart` | Menu utama, navigasi ke semua demo, ProviderScope untuk Riverpod |
| `lib/common/models.dart` | Model Todo (dipakai ulang di setState, Provider, Riverpod, Bloc) |
| `lib/setstate/counter_setstate.dart` | Counter dengan setState (state lokal) |
| `lib/setstate/todo_setstate.dart` | Todo list dengan setState |
| `lib/provider/counter_provider.dart` | Counter dengan ChangeNotifier + Provider |
| `lib/provider/todo_provider.dart` | Todo list dengan Provider |
| `lib/riverpod/counter_riverpod.dart` | Counter dengan StateProvider (Riverpod) |
| `lib/riverpod/todo_riverpod.dart` | Todo list dengan StateNotifierProvider |
| `lib/bloc/counter_bloc.dart` | Counter dengan Cubit |
| `lib/bloc/todo_bloc.dart` | Todo list dengan TodoCubit |
| `README.md` | Dokumen ini (panduan level) |

Jalankan: `cd 07-state-management && flutter pub get && flutter run`.
