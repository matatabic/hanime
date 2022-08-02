import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

class DioRangeDownloadManage {
  /// 用于记录正在下载的url，避免重复下载
  static var downloadingUrls = Map<String, CancelToken>();

  /// 断点下载大文件
  static Future<void> downloadWithChunks({
    required String url,
    required String savePath,
    ProgressCallback? onReceiveProgress,
    void Function()? done,
    void Function(String uri)? failed,
  }) async {
    int downloadStart = 0;
    bool fileExists = false;
    File f = File(savePath);
    if (await f.exists()) {
      downloadStart = f.lengthSync();
      fileExists = true;
    }
    print("开始：$downloadStart");
    print("url: $url");
    if (fileExists && downloadingUrls.containsKey(url)) {
      return;
    }
    var dio = Dio();

    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: print, // specify log function (optional)
      retries: 2, // retry count (optional)
      retryDelays: const [
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 1), // wait 2 sec before second retry
      ],
    ));

    CancelToken cancelToken = CancelToken();
    downloadingUrls[url] = cancelToken;
    try {
      var response = await dio.get<ResponseBody>(
        url,
        options: Options(
          /// 以流的方式接收响应数据
          responseType: ResponseType.stream,
          followRedirects: false,
          headers: {
            /// 分段下载重点位置
            "range": "bytes=$downloadStart-",
          },
        ),
      );
      File file = File(savePath);
      RandomAccessFile raf = file.openSync(mode: FileMode.append);
      int received = downloadStart;
      int total = await _getContentLength(response);
      Stream<Uint8List> stream = response.data!.stream;
      StreamSubscription<Uint8List>? subscription;
      subscription = stream.listen(
        (data) {
          /// 写入文件必须同步
          raf.writeFromSync(data);
          received += data.length;
          onReceiveProgress?.call(received, total);
        },
        onDone: () async {
          downloadingUrls.remove(url);
          await raf.close();
          done?.call();
        },
        onError: (e) async {
          await raf.close();
          downloadingUrls.remove(url);
          print("error1111111111111111111111");
          failed?.call(e.uri.toString());
        },
        cancelOnError: true,
      );
      cancelToken.whenCancel.then((_) async {
        await subscription?.cancel();
        await raf.close();
      });
    } on DioError catch (error) {
      print("error222222222222222222222222222");

      /// 请求已发出，服务器用状态代码响应它不在200的范围内
      if (CancelToken.isCancel(error)) {
        print("下载取消");
      } else {
        print("下载取消2");
        print(error.message);
        failed?.call(error.message);
      }
      downloadingUrls.remove(url);
    }
  }

  /// 获取下载的文件大小
  static Future<int> _getContentLength(Response<ResponseBody> response) async {
    try {
      var headerContent =
          response.headers.value(HttpHeaders.contentRangeHeader);
      print("下载文件$headerContent");
      if (headerContent != null) {
        return int.parse(headerContent.split('/').last);
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  /// 取消任务
  static void cancelDownload(String url) {
    downloadingUrls[url]?.cancel();
    downloadingUrls.remove(url);
  }
}
