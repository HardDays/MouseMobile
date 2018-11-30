import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:flutter/services.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';
import '../../../../helpers/view/formatter.dart';

class PlayerPage extends StatefulWidget {

  final String url;

  PlayerPage({this.url});

  PlayerPageState createState() => PlayerPageState();
}

class PlayerPageState extends State<PlayerPage> {

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
    return WebviewScaffold(
      appBar: null,   
      url: widget.url,
    );
  }
}