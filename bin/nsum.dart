void main(List<String> arguments) {
  final target = 28;
  final choices = [3, 4, 5, 6, 7, 8, 11, 14].ascending;
  final tolerance = 0;

  final results = <String>{};

  void visit([List<int> curr = const []]) {
    final sum = curr.sum;
    for (final choice in choices) {
      final nextSum = sum + choice;

      if (nextSum.withinToleranceOf(tolerance, target)) {
        final result = [...curr, choice].ascending;
        results.add('${result.sum}: ${result.join(',')}');
      }

      if (nextSum < target) {
        visit([...curr, choice]);
      }
    }
  }

  final stopwatch = Stopwatch()..start();
  visit();
  stopwatch.stop();

  results.forEach(print);

  print(
    'Found ${results.length} results '
    'in ${stopwatch.elapsedMicroseconds / 1000}ms',
  );
}

extension ComparableList<T extends Comparable> on List<T> {
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
