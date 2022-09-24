import 'package:flutter/foundation.dart';
import 'package:hanime/entity/watch_entity.dart';

class WatchModel with ChangeNotifier, DiagnosticableTreeMixin {
  String _shareTitle = "";
  String _currentHtml = "";
  bool _isFlicker = false;

  String get shareTitle => _shareTitle;
  String get currentHtml => _currentHtml;
  bool get isFlicker => _isFlicker;

  setWatchInfo(WatchInfo watchInfo) {
    _shareTitle = watchInfo.shareTitle;
    _currentHtml = watchInfo.htmlUrl;
    _isFlicker = false;
    notifyListeners();
  }

  setIsFlicker(bool data) {
    _isFlicker = data;
    notifyListeners();
  }

  clear() {
    _shareTitle = "";
    _currentHtml = "";
    _isFlicker = false;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('shareTitle', shareTitle));
    properties.add(StringProperty('currentAnimeId', currentHtml));
    properties
        .add(FlagProperty('isFlicker', value: isFlicker, ifTrue: 'isFlicker'));
  }
}
