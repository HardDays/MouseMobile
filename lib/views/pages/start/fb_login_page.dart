import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../main/main_page.dart';

import '../../routes/default_page_route.dart';
import '../../dialogs/dialogs.dart';

import '../../../helpers/api/main_api.dart';
import '../../../helpers/api/vk_api.dart';

import '../../../helpers/storage/database.dart';
import '../../../helpers/storage/cache.dart';
import '../../../helpers/storage/data_provider.dart';

import '../../../resources/translations.dart';

class FbLoginPage extends StatefulWidget {

  @override
  FbLoginPageState createState() => new FbLoginPageState();

}

class FbLoginPageState extends State<FbLoginPage> {

  final flutterWebviewPlugin = FlutterWebviewPlugin();

  bool loading = false;

  @override
  void initState() {
    super.initState();  

    flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      var tk = 'access_token=';
      if (url.contains(tk)){
        setState(() {
          loading = true;                  
        }); 
        var pos = url.indexOf(tk);
        var accessToken = url.substring(pos + tk.length);
        var endPos = accessToken.indexOf('&');
        accessToken = accessToken.substring(0, endPos);

        var res = await DataProvider.loginFb(accessToken);
        if (res.status == DataStatus.ok){
          while(Navigator.canPop(context)){
            Navigator.pop(context);
          }
          Navigator.pushReplacement(
            context, 
            DefaultPageRoute(builder: (context) => MainPage()),
          );     
        } else {
          Dialogs.showMessageDialog(context, title: Translations.unauthorized, body: Translations.wrongUsernameOrPass, ok: Translations.ok);
        }
      } 
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) { 
      return Material(
        child: Container(
          child: Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)),         
          ),    
        )    
      );
    }
    return WebviewScaffold(
      url: 'https://www.facebook.com/v3.2/dialog/oauth?client_id=368746123713908&redirect_uri=https://www.facebook.com/connect/login_success.html&state=123&response_type=token', 
    );
  }
}
