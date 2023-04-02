void main() {
  List<int> numbers = [1, 2, 3, 4, 5];
  int min = numbers.reduce((a, b) => a < b ? a : b);
  int max = numbers.reduce((a, b) => a > b ? a : b);
  print('Minimum value: $min');
  print("Maximum value: $max");
}
