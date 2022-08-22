import 'dart:collection';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hanime/providers/download_model.dart';
import 'package:hanime/providers/favourite_model.dart';
import 'package:hanime/providers/home_model.dart';
import 'package:hanime/providers/search_model.dart';
import 'package:hanime/providers/watch_model.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_bar.dart';

// void main() => runApp(new MyApp());
void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeModel()),
          ChangeNotifierProvider(create: (_) => WatchModel()),
          ChangeNotifierProvider(create: (_) => SearchModel()),
          ChangeNotifierProvider(create: (_) => FavouriteModel()),
          ChangeNotifierProvider(create: (_) => DownloadModel()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        showPerformanceOverlay: false,
        locale: const Locale('en'),
        builder: BotToastInit(), //1.调用BotToastInit
        navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
        theme: new ThemeData(
          platform: TargetPlatform.iOS,
          brightness: Brightness.dark,
          dialogBackgroundColor: Colors.black,
          primaryColor: Colors.orange[800],
          accentColor: Colors.orange[300],
          scaffoldBackgroundColor: Colors.black26,
        ),
        home: BottomNavBar());
  }
}

class InAppWebViewExampleScreen extends StatefulWidget {
  @override
  _InAppWebViewExampleScreenState createState() =>
      new _InAppWebViewExampleScreenState();
}

class _InAppWebViewExampleScreenState extends State<InAppWebViewExampleScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                print("Menu item Special clicked!");
                print(await webViewController?.getSelectedText());
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          print("onCreateContextMenu");
          print(hitTestResult.extra);
          print(await webViewController?.getSelectedText());
        },
        onHideContextMenu: () {
          print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;
          print("onContextMenuActionItemClicked: " +
              id.toString() +
              " " +
              contextMenuItemClicked.title);
        });

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text("InAppWebView")),
        body: SafeArea(
            child: Column(children: <Widget>[
      // TextField(
      //   decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
      //   controller: urlController,
      //   keyboardType: TextInputType.url,
      //   onSubmitted: (value) {
      //     var url = Uri.parse(value);
      //     if (url.scheme.isEmpty) {
      //       url = Uri.parse("https://www.google.com/search?q=" + value);
      //     }
      //     webViewController?.loadUrl(urlRequest: URLRequest(url: url));
      //   },
      // ),
      Expanded(
        child: Stack(
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: InAppWebView(
                key: webViewKey,
                // contextMenu: contextMenu,
                initialUrlRequest:
                    URLRequest(url: Uri.parse("https://hanime1.me/")),
                // initialFile: "assets/index.html",
                initialUserScripts: UnmodifiableListView<UserScript>([]),
                initialOptions: options,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {
                  print("141241412412421");
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var uri = navigationAction.request.url!;

                  if (![
                    "http",
                    "https",
                    "file",
                    "chrome",
                    "data",
                    "javascript",
                    "about"
                  ].contains(uri.scheme)) {
                    // if (await canLaunch(url)) {
                    //   // Launch the App
                    //   await launch(
                    //     url,
                    //   );
                    //   // and cancel the request
                    //   return NavigationActionPolicy.CANCEL;
                    // }
                  }

                  return NavigationActionPolicy.ALLOW;
                },
                onLoadStop: (controller, url) async {
                  pullToRefreshController.endRefreshing();
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                  print("qfqwfqwfqwfwfwfqfwqfqwfw");
                },
                onLoadError: (controller, url, code, message) {
                  pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  // if (progress == 100) {
                  //   pullToRefreshController.endRefreshing();
                  // }
                  // setState(() {
                  //   this.progress = progress / 100;
                  //   urlController.text = this.url;
                  // });
                  // print("21412412412412");
                  // print(urlController);
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
              ),
            ),
            // progress < 1.0
            //     ? LinearProgressIndicator(value: progress)
            //     : Container(),
          ],
        ),
      ),
      ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: Icon(Icons.arrow_back),
            onPressed: () async {
              // webViewController?.goBack();
              // ;
              String? ss = await webViewController?.getHtml();
              print(ss);
              // print(webViewController
              //     ?.webStorage.localStorage.webStorageType);
            },
          ),
          ElevatedButton(
            child: Icon(Icons.arrow_forward),
            onPressed: () {
              webViewController?.goForward();
            },
          ),
          ElevatedButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              webViewController?.reload();
            },
          ),
        ],
      ),
    ])));
  }
}
