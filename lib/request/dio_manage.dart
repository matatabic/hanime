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
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 1), // wait 2 sec before second retry
      ],
    ));

    try {
      //404
      return await dio.get(htmlUrl);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      // if (e.response != null) {
      //   print(e.response.data)
      //   print(e.response.headers)
      //   print(e.response.requestOptions)
      // } else {
      //   // Something happened in setting up or sending the request that triggered an Error
      //   print(e.requestOptions)
      //   print(e.message)
      // }
      print("eeeeeeeeeeeeeeee");
      print(e);
      return null;
    }

    /// Sending a failing request for 3 times with 1s, then 2s, then 3s interval
  }
}
