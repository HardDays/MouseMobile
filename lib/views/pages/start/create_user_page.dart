import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';  

import '../main/main_page.dart';

import '../../routes/default_page_route.dart';

import '../../dialogs/dialogs.dart';

import '../../widgets/shadow_text.dart';
import '../../widgets/main_button.dart';

import '../../../helpers/api/main_api.dart';
import '../../../helpers/storage/database.dart';

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

  User user;

  @override
  void initState() {    
    super.initState(); 

  }

  String validateEmail(String email){
    if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email) || email.length > 75){
      return 'Wrong email';
    }
  }

  String validatePasswords(String pass){
    if (pass.length < 6){
      return 'Enter more than 6 symbols';
    } else if (!RegExp(r'^[a-zA-Z0-9\._-]+$').hasMatch(pass)){
      return 'Only letters, numbers and symbols _-. allowed';
    } else if (password != passwordConfirmation){
      return 'Passwords not matched';
    }
  }

  String validateUserName(String username){
    if (username.length < 3 || username.length > 30){
      return 'Username can be from 3 to 30 symbols';
    } else if (!RegExp(r'^[a-zA-Z0-9\._]+$').hasMatch(username)){
      return 'Only letters, numbers and symbols _. allowed';
    }
  }

  String validateName(String name){
    if (name.length < 1 || name.length > 50){
      return 'Name can be from 1 to 50 symbols';
    }
  }
  //a@a.aa1
  void createUser(){
    MainAPI.createUser(User(email: email, password: password, passwordConfirmation: passwordConfirmation)).timeout(Duration(seconds: 10),
      onTimeout: (){
        Navigator.pop(context);
        Dialogs.showMessage(context, 'Server not responding', 'Please, try again later', 'Ok');
      }
    ).then(
      (res){
        if (res == null){
        } else {
          if (res.error == UserError.ok){
            setState(() {
              user = res;
            });
            createAccount();
          } else {
            Navigator.pop(context);
            Dialogs.showMessage(context, 'Cannot register', 'Email already taken', 'Ok');
          }
        }
      }
    );
  }

  void createAccount(){
    MainAPI.token = user.token;
    MainAPI.createAccount(Account(userName: userName, firstName: firstName, lastName: lastName, accountType: AccountType.fan)).timeout(Duration(seconds: 10), 
      onTimeout: (){
        Navigator.pop(context);
        Dialogs.showMessage(context, 'Server not responding', 'Please, try again later', 'Ok');
      }
    ).then(
      (res){
        Navigator.pop(context);
        if (res.error == AccountError.ok){
          Database.setCurrentUser(user);
          Database.setCurrentAccount(res);
          Navigator.pop(context);
          Navigator.pushReplacement(
            context, 
            DefaultPageRoute(builder: (context) => MainPage()),
          );
        } else {
          Dialogs.showMessage(context, 'Cannot register', 'Username already taken', 'Ok');
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
                    Container(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 140.0,
                        height: 140.0, 
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/start/mouse_pic.png')
                          )
                        ),
                      ),
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
                                    child: MainButton(Translations.continueCaps,
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
