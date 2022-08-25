import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

class DioManage {
  static Future<Response<dynamic>?> get(htmlUrl) async {
    final dio = Dio();

    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: print, // specify log function (optional)
      retries: 2, // retry count (optional)
      retryDelays: const [
        Duration(milliseconds: 500), // wait 1 sec before first retry
        Duration(milliseconds: 500), // wait 2 sec before second retry
      ],
    ));

    try {
      //404
      return await dio.get(htmlUrl);
      // await dio.get('https://wendux.github.io/xsddddd');
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      return null;
    }
  }
}
