import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

class DioManage {
  static Future<Response<dynamic>?> get(htmlUrl) async {
    final dio = Dio();

    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: print, // specify log function (optional)
      retries: 1, // retry count (optional)
      retryDelays: const [
        Duration(milliseconds: 500), // wait 1 sec before first retry
        // Duration(milliseconds: 500), // wait 2 sec before second retry
      ],
    ));

    return await dio.get(htmlUrl);
  }
}
