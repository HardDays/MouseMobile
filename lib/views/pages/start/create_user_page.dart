import 'dart:io';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';  
import 'package:image_picker/image_picker.dart';

import '../main/main_page.dart';

import '../../routes/default_page_route.dart';

import '../../dialogs/dialogs.dart';

import '../../widgets/shadow_text.dart';
import '../../widgets/main_button.dart';

import '../../../helpers/storage/data_provider.dart';

import '../../../models/api/user.dart';
import '../../../models/api/account.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/translations.dart';


class CreateUserPage extends StatefulWidget {

  @override
  CreateUserPageState createState() => CreateUserPageState();
}

class CreateUserPageState extends State<CreateUserPage> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode passwordConfirmNode = FocusNode();
  FocusNode userNameNode = FocusNode();

  String email;
  String password;
  String passwordConfirmation;
  String userName;
  String firstName;
  String lastName;

  File image;

  User user;

  @override
  void initState() {    
    super.initState(); 

  }

  String validateEmail(String email){
    if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email) || email.length > 75){
      return Translations.wrongEmailFormat;
    }
  }

  String validatePasswords(String pass){
    if (pass.length < 6){
      return Translations.wrongPassSize;
    } else if (!RegExp(r'^[a-zA-Z0-9\._-]+$').hasMatch(pass)){
      return Translations.wrongPassSymbols;
    } else if (password != passwordConfirmation){
      return Translations.passwordsNotMatched;
    }
  }

  String validateUserName(String username){
    if (username.length < 3 || username.length > 30){
      return Translations.wrongUsernameSize;
    } else if (!RegExp(r'^[a-zA-Z0-9\._]+$').hasMatch(username)){
      return Translations.wrongUsernameSymbols;
    }
  }

  String validateName(String name){
    if (name.length < 1 || name.length > 50){
      return Translations.wrongNameSize;
    }
  }
  //a@a.aa1
  void createUser(){
    DataProvider.createUser(User(email: email, password: password, passwordConfirmation: passwordConfirmation)).timeout(Duration(seconds: 10),
      onTimeout: (){
        Navigator.pop(context);
        Dialogs.showMessage(context, title: Translations.serverNotRepsonding, body: Translations.pleaseTryAgain, ok: Translations.ok);
      }
    ).then(
      (res){
        if (res.status == DataStatus.ok){
          setState(() {
            user = res.result;
          });
          createAccount();
        } else {
          Navigator.pop(context);
          Dialogs.showMessage(context, title: Translations.cannotRegister, body: Translations.emailAlreadyTaken, ok: Translations.ok);
        }
      }
    );
  }

  void createAccount(){
    DataProvider.createAccount(Account(userName: userName, firstName: firstName, lastName: lastName, accountType: AccountType.fan)).timeout(Duration(seconds: 10), 
      onTimeout: (){
        Navigator.pop(context);
        Dialogs.showMessage(context, title: Translations.serverNotRepsonding, body: Translations.pleaseTryAgain, ok: Translations.ok);
      }
    ).then(
      (res){
        Navigator.pop(context);
        if (res.status == DataStatus.ok){
          Navigator.pop(context);
          Navigator.pushReplacement(
            context, 
            DefaultPageRoute(builder: (context) => MainPage()),
          );
        } else {
          Dialogs.showMessage(context, 
            title: Translations.cannotRegister, 
            body: Translations.usernameAlreadyTaken, 
            ok: Translations.ok
          );
        }
      }
    );
  }

  void onContinue(){
    formKey.currentState.save();
    if (formKey.currentState.validate()){
      Dialogs.showLoader(context);
      if (user == null){
        createUser();
      }else{
        createAccount();
      }
    }
  }

  void onImageSelect() async {
    var res = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (res != null){
        image = res;                                        
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.startScreenFill,
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width, 
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.9),
                ]
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/start/signup_bg.png'),
                fit: BoxFit.cover,
              )
            ),  
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.9),
                  ]
                ),
              ),  
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
                      margin: EdgeInsets.only(top: 20.0, left: 0.0),
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
                    Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 140.0,
                            height: 140.0, 
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: image == null ? AssetImage('assets/images/start/mouse_pic.png') : FileImage(image)
                              )
                            ),
                          ),
                        ),
                        Container(
                          height: 140.0,
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(left: 100.0),
                          child: IconButton(
                            onPressed: onImageSelect,
                            icon: Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.mainRed
                              ),
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          )
                        )
                      ]
                    ),
                    Form(
                      key: formKey,
                      child: Container(
                        margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500
                                ),
                                focusedBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white, width: 1.7),   
                                ),
                                enabledBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),   
                                ),   
                                hintText: Translations.email
                              ),
                              validator: validateEmail,
                              onSaved: (email){
                                if (this.email != email){
                                  user = null;
                                }
                                this.email = email;
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
                                fontWeight: FontWeight.w500
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500
                                ),
                                focusedBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white, width: 1.7),   
                                ),
                                enabledBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),   
                                ),   
                                hintText: Translations.password
                              ),
                              validator: validatePasswords,
                              onSaved: (password){
                                this.password = password;
                              },
                              onFieldSubmitted: (val){
                                FocusScope.of(context).requestFocus(passwordConfirmNode);
                              },
                            ),
                            Padding(padding: EdgeInsets.only(top: 15.0)),
                            TextFormField(
                              focusNode: passwordConfirmNode,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500
                                ),
                                focusedBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white, width: 1.7),   
                                ),
                                enabledBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),   
                                ),   
                                hintText: Translations.confirmPassword
                              ),
                              validator: validatePasswords,
                              onSaved: (passwordConfirmation){
                                this.passwordConfirmation = passwordConfirmation;
                              },
                              onFieldSubmitted: (val){
                                FocusScope.of(context).requestFocus(userNameNode);
                              },
                            ),
                            Padding(padding: EdgeInsets.only(top: 15.0)),
                            TextFormField(
                              focusNode: userNameNode,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500
                                ),
                                focusedBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white, width: 1.7),   
                                ),
                                enabledBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),   
                                ),   
                                hintText: Translations.username,
                              ),
                              validator: validateUserName,
                              onSaved: (userName){
                                this.userName = userName;
                              },
                              onFieldSubmitted: (val){
                                FocusScope.of(context).requestFocus(firstNameNode);
                              },
                            ),
                            Padding(padding: EdgeInsets.only(top: 15.0)),
                            TextFormField(
                              focusNode: firstNameNode,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500
                                ),
                                focusedBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white, width: 1.7),   
                                ),
                                enabledBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),   
                                ),   
                                hintText: Translations.firstName
                              ),
                              onSaved: (fname){
                                this.firstName = fname;
                              },
                              validator: validateName,
                              onFieldSubmitted: (val){
                                FocusScope.of(context).requestFocus(lastNameNode);
                              },
                            ),
                            Padding(padding: EdgeInsets.only(top: 15.0)),
                            TextFormField(
                              focusNode: lastNameNode,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500
                                ),
                                focusedBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white, width: 1.7),   
                                ),
                                enabledBorder: UnderlineInputBorder(      
                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),   
                                ),   
                                hintText: Translations.lastName
                              ),
                              onSaved: (lname){
                                this.lastName = lname;
                              },
                              validator: validateName,
                            ),
                            Padding(padding: EdgeInsets.only(top: 40.0)),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: 50.0,
                                    child: MainButton(Translations.continuew.toUpperCase(),
                                      onTap: onContinue
                                    )
                                  ),
                                ]
                              )
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ]
          )
        ]
      )
      )
    );
  }
}
