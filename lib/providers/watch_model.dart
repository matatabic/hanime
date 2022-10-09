import 'package:flutter/foundation.dart';
import 'package:hanime/entity/watch_entity.dart';

class WatchModel with ChangeNotifier, DiagnosticableTreeMixin {
  String _currentShareTitle = "";
  String _currentHtml = "";
  String _currentCover = "";
  String _currentVideoUrl = "";
  bool _isFlicker = false;

  String get currentShareTitle => _currentShareTitle;
  String get currentHtml => _currentHtml;
  bool get isFlicker => _isFlicker;
  String get currentCover => _currentCover;
  String get currentVideoUrl => _currentVideoUrl;

  setWatchInfo(WatchEntity watchEntity) {
    _currentShareTitle = watchEntity.info.shareTitle;
    _currentHtml = watchEntity.info.htmlUrl;
    _currentCover = watchEntity.info.cover;
    _currentVideoUrl = watchEntity.videoData.video[0].list[0].url;
    _isFlicker = false;
    notifyListeners();
  }

  setIsFlicker(bool data) {
    _isFlicker = data;
    notifyListeners();
  }

  clear() {
    _currentShareTitle = "";
    _currentHtml = "";
    _currentCover = "";
    _currentVideoUrl = "";
    _isFlicker = false;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('currentShareTitle', currentShareTitle));
    properties.add(StringProperty('currentHtml', currentHtml));
    properties.add(StringProperty('currentCover', _currentCover));
    properties.add(StringProperty('currentVideoUrl', _currentVideoUrl));
    properties
        .add(FlagProperty('isFlicker', value: isFlicker, ifTrue: 'isFlicker'));
  }
}
