import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';
import '../../../../helpers/view/formatter.dart';

class TicketPage extends StatefulWidget {

  final String url;

  TicketPage({this.url});

  TicketPageState createState() => TicketPageState();
}

class TicketPageState extends State<TicketPage> {

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
      SystemUiOverlay.top
    ]);
    super.dispose();
  }

  @override 
  Widget build(BuildContext ctx) {
    return SafeArea(child: WebviewScaffold(
      appBar: PreferredSize(
        preferredSize: Size(40, 40),
        child: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
          primary: false,
          //backgroundColor: Colors.bl,
        )
      ),   
      url: widget.url,
    )
    );
  }
}