void main() {
  int radius = 5;
  print('Area of circle: ${getArea(radius)}');
  print('Perimeter of circle: ${getPerimeter(radius)}');
}

double getArea(int radius) {
  return 3.14 * radius * radius;
}

double getPerimeter(int radius) {
  return 2 * 3.14 * radius;
}
