void main(List<String> arguments) {
  final offset = 7;
  final target = 898 - offset;

  final inventory = {
    535: 1,
    329: 1,
    315: 1,
    230: 2,
    180: 1,
    158: 2,
    130: 1,
    105: 3,
  };

  final choices = inventory.keys.ascending;
  final tolerance = 10;

  final results = <String>{};

  void visit([List<int> curr = const []]) {
    final sum = curr.sum;
    for (final choice in choices) {
      final nextSum = sum + choice;

      if (nextSum.withinToleranceOf(tolerance, target)) {
        final result = [...curr, choice].ascending;
        final tmpInventory = Map<int, int>.from(inventory);
        for (final result in result) {
          tmpInventory[result] = tmpInventory[result]! - 1;
        }
        final isValid = tmpInventory.values.every((e) => !e.isNegative);
        if (isValid) {
          results.add(
              '${result.sum}(${result.sum - target}): ${result.join(',')}');
        }
      }

      if (nextSum < target) {
        visit([...curr, choice]);
      }
    }
  }

  final stopwatch = Stopwatch()..start();
  visit();
  stopwatch.stop();

  results.ascending.forEach(print);

  print(
    'Found ${results.length} results '
    'in ${stopwatch.elapsedMicroseconds / 1000}ms',
  );
}

extension ComparableIterable<T extends Comparable> on Iterable<T> {
  List<T> get ascending => List.from(descending.reversed);
  List<T> get descending => List.from(this)..sort((a, b) => b.compareTo(a));
}

extension on List<int> {
  int get sum => isEmpty ? 0 : reduce((a, b) => a + b);
}

extension on int {
  bool withinToleranceOf(int tolerance, int target) {
    final upperBound = target + tolerance;
    final lowerBound = target - tolerance;
    return upperBound >= this && this >= lowerBound;
  }
}
