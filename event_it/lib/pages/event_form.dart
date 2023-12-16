import 'package:event_it/utils/app_theme.dart';
import 'package:event_it/utils/loading_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class EventForm extends StatefulWidget {
  const EventForm({super.key});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  bool _isLoading = false;
  late InAppWebViewController webView;
  String url="https://docs.google.com/forms/d/e/1FAIpQLSfl2bDOH5QiknVMMMrK3nI5NA8HddPUecPJmnfHC3L-d_mbxA/viewform?usp=sf_link";
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  double _progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: AppTheme.whiteColor),
          backgroundColor: AppTheme.backgroundColor,
          title: Text(
            "E-vent it!",
            style: LoadingTheme.appText(
                size: 22, weight: FontWeight.w500, color: AppTheme.whiteColor),
          ),
        ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(url)),
            onWebViewCreated: (InAppWebViewController controller){
              webView = controller;
            },
            onProgressChanged: (InAppWebViewController controller , int progress){
              setState(() {
                _progress = progress/100;
              });
            },
          ),
          _progress<1?const Center(
                child: CircularProgressIndicator(color: AppTheme.blueColor),
              ): SizedBox(),
        ],
      ),
    );
  }
}