import 'dart:math';

class ListUtils {
  static List shuffle(List items) {
    final random = Random();

    for (var i = items.length - 1; i > 0; i--) {
      final n = random.nextInt(i + 1);

      final temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }
}
