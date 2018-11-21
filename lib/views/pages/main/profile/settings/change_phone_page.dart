import 'package:flutter/material.dart';

import '../../../../routes/default_page_route.dart';

import '../../../../widgets/main_button.dart';

import '../../../../dialogs/dialogs.dart';

import '../../../../../models/api/user.dart';

import '../../../../../helpers/storage/data_provider.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/translations.dart';

class ChangePhonePage extends StatefulWidget {

  ChangePhonePageState createState() => ChangePhonePageState();
}

class ChangePhonePageState extends State<ChangePhonePage> {

  GlobalKey<FormState> formKey;

  String phone;

  @override
  void initState(){
    super.initState();
    formKey = GlobalKey<FormState>();

  }
  void onUpdate(){
    formKey.currentState.save();
    if (formKey.currentState.validate()){
      Dialogs.showLoader(context);
      DataProvider.updateUser(User(registerPhone: phone)).then(
        (res){
          Navigator.pop(context);
          if (res.status == DataStatus.ok){
            Dialogs.showMessageDialog(context, title: Translations.success, body: Translations.phoneUpdated, ok: Translations.ok).then((res){
              Navigator.pop(context);
            });
          } else {
            Dialogs.showMessageDialog(context, title: Translations.error, body: Translations.phoneAlreadyTaken, ok: Translations.ok);
          }
        }
      );
    }
  }

  Widget buildSetting(Widget child){
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
            child: child
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
              child: Text(Translations.changePhone.toUpperCase(),
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
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
                      alignment: Alignment.topLeft,
                      child: Text('${Translations.currentPhone.toUpperCase()}:',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16.0,
                          fontFamily: 'Avenir-Medium', 
                        ),
                      ),
                    ),
                    buildSetting(
                      Text(DataProvider.currentUser.registerPhone ?? '-------',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'Avenir-Book', 
                        ),
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
                      alignment: Alignment.topLeft,
                      child: Text('${Translations.newPhone.toUpperCase()}:',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16.0,
                          fontFamily: 'Avenir-Medium', 
                        ),
                      ),
                    ),
                    buildSetting(
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'Avenir-Book', 
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: Translations.phoneNumber,       
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                            fontFamily: 'Avenir-Book', 
                          )     
                        ),
                        onSaved: (val){
                          phone = val;
                        },
                      )
                    )
                  ]
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  height: 45.0,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: MainButton(Translations.update.toUpperCase(), onTap: onUpdate),
                )
              ]
            ),
          )
        )
      )
    );
  }
}