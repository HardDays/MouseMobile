import 'package:flutter/material.dart';

import '../../../../routes/default_page_route.dart';

import '../../../../widgets/main_button.dart';

import '../../../../dialogs/dialogs.dart';

import '../../../../../helpers/storage/data_provider.dart';

import '../../../../../models/api/user.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/translations.dart';

class ChangePasswordPage extends StatefulWidget {

  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {

  GlobalKey<FormState> formKey;

  String oldPassword;
  String newPassword;
  String passwordConfirmation;

  @override
  void initState(){
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  String validatePasswords(String pass){
    if (pass.length < 6){
      return Translations.wrongPassSize;
    } else if (!RegExp(r'^[a-zA-Z0-9\._-]+$').hasMatch(pass)){
      return Translations.wrongPassSymbols;
    } else if (newPassword != passwordConfirmation){
      return Translations.passwordsNotMatched;
    }
  }

  void onUpdate(){
    formKey.currentState.save();
    if (formKey.currentState.validate()){
      Dialogs.showLoader(context);
      DataProvider.updateUser(
        User(
          email: DataProvider.currentUser.email, 
          registerPhone: DataProvider.currentUser.registerPhone,
          password: newPassword, passwordConfirmation: 
          passwordConfirmation, 
          oldPassword: oldPassword)
        ).then(
          (res){
            Navigator.pop(context);
            if (res.status == DataStatus.ok){
              Dialogs.showMessageDialog(context, title: Translations.success, body: 'Password successfully updated', ok: Translations.ok).then((res){
                Navigator.pop(context);
              });
            } else {
              Dialogs.showMessageDialog(context, title: Translations.error, body: 'Wrong old password', ok: Translations.ok);
            }
          }
      );
    }
  }

  Widget buildSetting(String text, Function(String) onSave){
    return Container(
      color: AppColors.dialogBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Divider(
            color: Colors.grey.withOpacity(0.15),
            height: 1.0,
          ),
          Container(
            padding: EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0, bottom: 10.0),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.53,
                  child: Text(text,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16.0,
                      fontFamily: 'Avenir-Medium', 
                    ),
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'Avenir-Book', 
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: '*******',       
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.7),
                        fontFamily: 'Avenir-Book', 
                      )     
                    ),
                    validator: validatePasswords,
                    onSaved: onSave
                  )     
                )
              ] 
            )
          ),
          Divider(
            color: Colors.grey.withOpacity(0.15),
            height: 1.0,
          ),
        ]
      )
    );
  }

  Widget buildAppBar(){
    return PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 1.0,
        title: Row(
          children:[
            Container(
              child: Text('CHANGE PASSWORD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: 'Avenir-Black', 
                ),
              )
            )
          ]
        ),
        backgroundColor: AppColors.appBar,
        actions: [       
        ]
      )
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColors.mainBg,
      appBar: buildAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mainBg,
              AppColors.dialogBg
            ]
          )
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    buildSetting('CURRENT PASSWORD', 
                      (val){
                        oldPassword = val;                                                  
                      }
                    ),
                    buildSetting('NEW PASSWORD', 
                      (val){
                        newPassword = val;                                                  
                      }
                    ),
                    buildSetting('CONFIRM PASSWORD', 
                      (val){
                        passwordConfirmation = val;                                                  
                      }
                    ),
                  ]
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  height: 45.0,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: MainButton('UPDATE', onTap: onUpdate),
                )
              ]
            ),
          )
        )
      )
    );
  }
}