import 'dart:math';

int randomNumber(int min, int max) {
  int res = min + Random().nextInt(max - min + 1);
  return res;
}
