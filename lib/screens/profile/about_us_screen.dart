import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://katarasa.id/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://katarasa.id/#/about'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              return Stack(
                fit: StackFit.expand,
                children: [
                  _bodyContent(),
                  Positioned(
                    height: 24.0,
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: connected
                        ? const SizedBox()
                        : Container(
                            color: const Color(0xFFEE4400),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Periksa Kembali Jaringan Anda",
                                      style: WHITE_TEXT_STYLE.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              );
            },
            child: _bodyContent()));
  }

  Widget _bodyContent() {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (await _controller.canGoBack()) {
            _controller.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
