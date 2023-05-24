int calculateSum({required List<int> n}) {
  int sum = 0;
  n.forEach((e) {
    sum += e;
  });
  return sum;
}

void main() {
  List<int> myNumbers = [1, 2, 3, 4, 5];
  int result = calculateSum(n: myNumbers);
  print('Sum: $result');
}
