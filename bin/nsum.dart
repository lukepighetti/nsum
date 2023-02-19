void main(List<String> arguments) {
  final target = 28;
  // final choices = [3, 4, 5, 6, 7, 8, 11, 14]..sort();
  final choices = [3, 4]..sort();
  final maxLength = (target / choices.first).floor();

  final expandedChoices =
      List.generate(maxLength, (_) => choices).fold([], (a, b) => [...b, ...a]);
  print(expandedChoices);

  final subsets = getAllSubsets(expandedChoices);
  final matchingSubsets =
      subsets.where((e) => e.isNotEmpty && e.reduce((a, b) => a + b) == target);
  final sortedMatchingSubsets =
      matchingSubsets.map((e) => (e..sort()).toString()).toSet();

  print(sortedMatchingSubsets);
}

List<List<int>> getAllSubsets(List l) =>
    l.fold<List<List<int>>>([[]], (subLists, element) {
      return subLists
          .map((subList) => [
                subList,
                subList + [element]
              ])
          .expand((element) => element)
          .toList();
    });
