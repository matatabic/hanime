import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

class DioManage {
  static Future<Response<dynamic>> get(htmlUrl) async {
    final dio = Dio();

    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: print, // specify log function (optional)
      retries: 2, // retry count (optional)
      retryDelays: const [
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 2), // wait 2 sec before second retry
      ],
    ));

    /// Sending a failing request for 3 times with 1s, then 2s, then 3s interval
    return await dio.get(htmlUrl);
  }
}
