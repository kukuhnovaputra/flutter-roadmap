// Level 12 - Testing: Logic counter untuk unit test.
// Fungsi dan class murni tanpa dependency Flutter.

/// Mengembalikan value + 1. Dipakai untuk demonstrasi unit test.
int increment(int value) => value + 1;

/// Class counter dengan method increment (logic murni).
class Counter {
  int value;

  Counter([this.value = 0]);

  void increment() {
    value++;
  }

  void decrement() {
    value--;
  }
}
