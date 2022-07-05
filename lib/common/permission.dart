import 'package:permission_handler/permission_handler.dart';

Future<bool> checkPermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
  }
  return status.isGranted;
}
