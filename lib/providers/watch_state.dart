import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class WatchState with ChangeNotifier, DiagnosticableTreeMixin {
  bool _loading = false;

  bool get loading => _loading;

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('loading', value: false));
  }
}
