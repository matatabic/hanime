import 'package:flutter/foundation.dart';

class WatchModel with ChangeNotifier, DiagnosticableTreeMixin {
  String _title = "";
  String _shareTitle = "";
  bool _liked = false;
  int _currentAnimeId = 0;

  String get title => _title;
  String get shareTitle => _shareTitle;
  bool get liked => _liked;

  set setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  set setShareTitle(String shareTitle) {
    _shareTitle = shareTitle;
    notifyListeners();
  }

  set setLiked(bool liked) {
    _liked = liked;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(StringProperty('shareTitle', shareTitle));
    properties.add(FlagProperty('liked', value: liked, ifTrue: 'liked'));
  }
}
