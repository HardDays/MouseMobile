import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';  

import '../../routes/default_page_route.dart';
import '../../widgets/main_button.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/translations.dart';

class CheckEmailPage extends StatefulWidget {

  @override
  CheckEmailPageState createState() => CheckEmailPageState();
}

class CheckEmailPageState extends State<CheckEmailPage> {

  @override
  void initState() {    
    super.initState(); 
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
                image: AssetImage('assets/images/start/forgot_bg.png'),
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
                      child: Container(
                        margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 55.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Text(Translations.checkEmail,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: 'Avenir-Medium',
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 55.0)),
                            Container(
                              margin: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Text(Translations.weSentInstruction,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'Avenir-Medium',
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 60.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: 50.0,
                                    child: MainButton(Translations.continuew.toUpperCase(),
                                      onTap: (){
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                    )
                                  ),
                                ]
                              )
                            )
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              )
            ]
          )
        ]
      )
    );
  }
}
