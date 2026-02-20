// Level 12 - Testing: Unit test.
// test(), expect(), group() untuk menguji logic murni di counter.dart.

import 'package:flutter_test/flutter_test.dart';
import 'package:testing/counter.dart';

void main() {
  group('increment', () {
    test('returns value + 1', () {
      expect(increment(0), 1);
      expect(increment(5), 6);
      expect(increment(-1), 0);
    });
  });

  group('Counter', () {
    test('starts at 0 by default', () {
      final c = Counter();
      expect(c.value, 0);
    });

    test('starts at given value', () {
      final c = Counter(10);
      expect(c.value, 10);
    });

    test('increment increases value by 1', () {
      final c = Counter(0);
      c.increment();
      expect(c.value, 1);
      c.increment();
      expect(c.value, 2);
    });

    test('decrement decreases value by 1', () {
      final c = Counter(5);
      c.decrement();
      expect(c.value, 4);
      c.decrement();
      expect(c.value, 3);
    });
  });
}
