import 'dart:io';

void main() {
  num num1, num2, sum = 0;

  print('Enter num1:');
  num1 = num.parse(stdin.readLineSync()!);

  print('Enter num2:');
  num2 = num.parse(stdin.readLineSync()!);

  for (num i = num1 + 1; i < num2 - 1; i++) {
    if (i % 2 == 1) {
      sum = sum + i;
    }
  }

  print("sum: $sum");
}
