import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GitHubSignInPage extends StatefulWidget {
  final String url;
  final String redirectUrl;
  final bool clearCache;
  final String title;
  final bool? centerTitle;
  final String? userAgent;

  const GitHubSignInPage(
      {Key? key,
      required this.url,
      required this.redirectUrl,
      this.userAgent,
      this.clearCache = true,
      this.title = "",
      this.centerTitle})
      : super(key: key);

  @override
  State createState() => _GitHubSignInPageState();
}

class _GitHubSignInPageState extends State<GitHubSignInPage> {
  static const String _userAgentMacOSX =
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: widget.centerTitle,
        ),
        body: WebView(
          initialUrl: widget.url,
          userAgent: widget.userAgent ?? _userAgentMacOSX,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            if (widget.clearCache) {
              controller.clearCache();
              CookieManager manager = CookieManager();
              manager.clearCookies();
            }
          },
          onPageFinished: (url) {
            if (url.contains("error=")) {
              Navigator.of(context).pop(
                Exception(Uri.parse(url).queryParameters["error"]),
              );
            } else if (url.startsWith(widget.redirectUrl)) {
              Navigator.of(context).pop(
                  url.replaceFirst("${widget.redirectUrl}?code=", "").trim());
            }
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
    // _wv.dispose();
    // _wv.close();
  }
}
