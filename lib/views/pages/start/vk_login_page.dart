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

class VkLoginPage extends StatefulWidget {

  @override
  VkLoginPageState createState() => new VkLoginPageState();

}

class VkLoginPageState extends State<VkLoginPage> {

  final flutterWebviewPlugin = FlutterWebviewPlugin();

  bool loading = false;

  @override
  void initState() {
    super.initState();  

    flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (url.contains('code=')){
        setState(() {
          loading = true;                  
        });
        var token = await VkAPI.getAccessToken(url);
        if (token != null){
          //Dialogs.showLoader(context);
          DataProvider.loginVk(token).timeout(Duration(seconds: 10), 
            onTimeout: (){
              Navigator.pop(context);
              Dialogs.showMessageDialog(context, title: Translations.serverNotRepsonding, body: Translations.pleaseTryAgain, ok: Translations.ok);
            }
          ).then(
            (res) {
              //Navigator.pop(context);
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
          );
        }else{
          Navigator.pop(context);
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
      url: VkAPI.codeUrl, 
    );
  }
}
