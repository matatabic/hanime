import 'dart:math';

int randomNumber(int min, int max) {
  int res = min + Random().nextInt(max - min + 1);
  return res;
}

String getVideoId(String htmlUrl) {
  String url = htmlUrl.substring("https://hanime1.me/watch?v=".length);
  return url;
}
