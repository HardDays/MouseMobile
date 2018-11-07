import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';  

import 'forgot_password_page.dart';

import 'widgets/bottom_login_widget.dart';

import '../main/main_page.dart';

import '../../routes/default_page_route.dart';

import '../../widgets/shadow_text.dart';
import '../../widgets/main_button.dart';

import '../../dialogs/dialogs.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/translations.dart';

import '../../../helpers/api/main_api.dart';
import '../../../helpers/storage/database.dart';

import '../../../models/api/user.dart';
import '../../../models/api/account.dart';

class LoginPage extends StatefulWidget {

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode passwordNode = FocusNode();

  String userName;
  String password;

  @override
  void initState() {    
    super.initState(); 
  }


  String validateUserName(String userName){
    if (userName.isEmpty){
      return Translations.emptyUsername;
    }
  }

  String validatePassword(String pass){
    if (pass.isEmpty){
      return Translations.emptyPassword;
    }
  } 

  void onLogin(){
    formKey.currentState.save();
    if (formKey.currentState.validate()){
      Dialogs.showLoader(context);
      MainAPI.authorize(userName, password).timeout(Duration(seconds: 10), 
        onTimeout: (){
          Navigator.pop(context);
          Dialogs.showMessage(context, title: Translations.serverNotRepsonding, body: Translations.pleaseTryAgain, ok: Translations.ok);
        }
      ).then(
        (token){
          Navigator.pop(context);
          if (token != null){
            MainAPI.updateToken(token);
            MainAPI.getMe().then(
              (user){
                user.token = token;
                Database.setCurrentUser(user);
              }
            );
            MainAPI.getMyAccount().then(
              (account){
                Database.setCurrentAccount(account);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context, 
                  DefaultPageRoute(builder: (context) => MainPage()),
                );
              }
            );
          } else {
            Dialogs.showMessage(context, title: Translations.unauthorized, body: Translations.wrongUsernameOrPass, ok: Translations.ok);
          }
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width, 
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/start/login_bg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(AppColors.startScreenFill, BlendMode.difference)
              )
            ),  
          ),
          Container(
            width: MediaQuery.of(context).size.width, 
            height: MediaQuery.of(context).size.height,
            color: AppColors.startScreenFill,
          ),
          Stack(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 20.0, left: 5.0, bottom: 0.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        iconSize: 28.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      alignment: Alignment.center,
                      child: Container(
                        width: 120.0,
                        height: 100.0, 
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/start/mouse_logo.png')
                          )
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      padding: EdgeInsets.only(left: 4.0, right: 4.0),
                      color: Colors.black,
                      child: Text(Translations.mouse.toUpperCase(),
                        style: TextStyle(
                          fontSize: 38.0,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w900,
                          color: AppColors.secondRed,                         
                        ),
                      )
                    ),
                    Form(
                      key: formKey,
                      child: Container(
                        margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'Avenir-Heavy',
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18.0,
                                  fontFamily: 'Avenir-Heavy',
                                ),
                                focusedBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white, width: 1.7),   
                                ),
                                enabledBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),   
                                ),   
                                hintText: Translations.username
                              ),
                              validator: validateUserName,
                              onSaved: (userName){
                                this.userName = userName;
                              },
                              onFieldSubmitted: (val){
                                FocusScope.of(context).requestFocus(passwordNode);
                              },
                            ),
                            Padding(padding: EdgeInsets.only(top: 15.0)),
                            TextFormField(
                              focusNode: passwordNode,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'Avenir-Heavy',
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18.0,
                                  fontFamily: 'Avenir-Heavy',
                                ),
                                focusedBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white, width: 1.7),   
                                ),
                                enabledBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),   
                                ),   
                                hintText: Translations.password
                              ),
                              validator: validatePassword,
                              onSaved: (password){
                                this.password = password;
                              },
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: FlatButton(
                                onPressed: (){
                                  Navigator.push(
                                    this.context,
                                    DefaultPageRoute(builder: (context) => ForgotPasswordPage()),
                                  );
                                },
                                child: Text(Translations.forgotYourPassword.toUpperCase(),
                                  style: TextStyle(
                                    color: AppColors.orangeText,
                                    fontSize: 12.0,
                                    fontFamily: 'AvenirNext-Medium',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.64),
                height: MediaQuery.of(context).size.height * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 30.0, right: 30.0),
                      height: 50.0,
                      child: MainButton(Translations.login.toUpperCase(),
                        onTap: onLogin,
                      )
                    ),
                    BottomLoginWidget()
                  ]
                )
              )
            ]
          )
        ]
      )
    );
  }
}
