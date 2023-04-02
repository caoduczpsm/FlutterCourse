import 'dart:io';

void main() {
  int n;

  print('Nhập n:');
  n = int.parse(stdin.readLineSync()!);

  for (int i = 1; i <= 10; i++) {
    print('$n x $i = ${n * i}');
  }
}
