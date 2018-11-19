import 'package:flutter/material.dart';

import '../../../../routes/default_page_route.dart';

import '../../../../dialogs/dialogs.dart';

import '../../../../widgets/main_checkbox.dart';
import '../../../../widgets/main_button.dart';

import '../../../../../helpers/storage/data_provider.dart';
import '../../../../../helpers/view/formatter.dart';

import '../../../../../models/api/question.dart';

import '../../../../../resources/app_colors.dart';
import '../../../../../resources/translations.dart';


class CustomerSupportPage extends StatefulWidget {

  CustomerSupportPageState createState() => CustomerSupportPageState();
}

class CustomerSupportPageState extends State<CustomerSupportPage> with SingleTickerProviderStateMixin {

  bool showSend;

  Question question;
  
  List<Question> questions;

  TabController tabController;

  @override
  void initState(){
    super.initState();

    showSend = false;
    question = Question();

    questions = [];

    DataProvider.getQuestions().then((res){
      setState(() {
        questions = res.result;        
      });
    });

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener((){
      setState(() {       
      });
    });
  }

  void onSend(){
    Dialogs.showLoader(context);
    DataProvider.creatQuestion(question).then(
      (res){
        Navigator.pop(context);
        if (res.status == DataStatus.ok){
          Dialogs.showMessageDialog(context, title: Translations.success, body: Translations.thankForQuestion, ok: Translations.ok).then((res){
            Navigator.pop(context);
          });
        } else {
          Dialogs.showMessageDialog(context, title: Translations.error, body: Translations.pleaseTryAgain, ok: Translations.ok);
        }
      }
    );
  }

  Widget buildQuestion(String title, String text){
    return Container(
      color: AppColors.dialogBg,
      child: Column(
        children:[
          Divider(
            color: Colors.grey.withOpacity(0.15),
            height: 1.0,
          ),
          Theme(
            data: Theme.of(context).copyWith(
              primaryColor: Colors.white
            ),
            child: ExpansionTile(
              title: Text(title,
                style: TextStyle(
                  fontFamily: 'Avenir-Book',
                  fontSize: 16.0,
                  color: Colors.white
                ),
              ),  
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 15.0),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  alignment: Alignment.topLeft,
                  child: Text(text,
                    style: TextStyle(
                      fontFamily: 'Avenir-Book',
                      fontSize: 16.0,
                      color: Colors.white.withOpacity(0.7)
                    ),
                  ),
                )
              ],
            ),
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
              child: Text(Translations.customerSupport.toUpperCase(),
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
      backgroundColor: AppColors.mainBg,
      resizeToAvoidBottomPadding: false,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TabBar(
                indicatorColor: Colors.white,
                controller: tabController,
                tabs: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(Translations.top5Questions.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white, 
                        fontFamily: tabController.index == 0 ? 'Avenir-Black' : 'Avenir-Medium',
                        fontSize: 15.0 
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(Translations.sendAQuestion.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: tabController.index == 1 ? 'Avenir-Black' : 'Avenir-Medium',
                        fontSize: 15.0 
                      ),
                    ),
                  ) ,
                ],
              ),
              tabController.index == 0 ?
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    buildQuestion(Translations.howToCreateEvent, Translations.createEventAnswer),
                    buildQuestion(Translations.howToCreateCrowdfunding, Translations.createCrowdfundingAnswer),
                    buildQuestion(Translations.howToSearch, Translations.searchAnswer),
                    buildQuestion(Translations.howToUploadVideo, Translations.uploadVideoAnswer),
                    buildQuestion(Translations.howToFindArtist, Translations.findArtistAnswer),
                  ],
                ),
              ):
              showSend ?
              Container(
                margin: EdgeInsets.only(left: 13.0, right: 13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 25.0)),
                    Text(Translations.subject,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8), 
                        fontFamily: 'Avenir-Book',
                        fontSize: 16.0 
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 3.0)),
                    Container(
                      child: TextField(
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontFamily: 'Avenir-Book', 
                          fontSize: 16.0
                        ),
                        decoration: InputDecoration(
                          helperStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontFamily: 'Avenir-Book', 
                          ),
                          contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3)
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3)
                            )
                          ),    
                        ),
                        onChanged: (val){
                          setState(() {
                            question.subject = val;             
                          });
                        },
                      )
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Text(Translations.message,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8), 
                        fontFamily: 'Avenir-Book',
                        fontSize: 16.0 
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 3.0)),
                    Container(
                      child: TextField(
                        maxLines: 5,
                        maxLength: 1000,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontFamily: 'Avenir-Book', 
                          fontSize: 16.0
                        ),
                        decoration: InputDecoration(
                          helperStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontFamily: 'Avenir-Book', 
                          ),
                          contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3)
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3)
                            )
                          ),
                        ),
                        onChanged: (val){
                          setState(() {
                            question.message = val;
                          });
                        },
                      )
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 25.0, bottom: 15.0),
                        height: 45.0,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: MainButton(Translations.send.toUpperCase(),
                          onTap: onSend,
                        )
                      )
                    )
                  ],
                ),
              ) : 
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 130.0,
                      child: ListView(
                        children: List.generate(questions.length, 
                          (ind) {
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
                                    padding: EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.65,
                                          child: Text(questions[ind].subject == null || questions[ind].subject.isEmpty ? Translations.noSubject.toUpperCase() :  questions[ind].subject.toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: 'Avenir-Medium',
                                              fontSize: 16.0,
                                              color: Colors.white
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(Formatter.shortDate(questions[ind].createdAt),
                                            style: TextStyle(
                                              fontFamily: 'Avenir-Book',
                                              fontSize: 14.0,
                                              color: Colors.white.withOpacity(0.5)
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                                    child: Text(questions[ind].message ?? Translations.noMessage,
                                      style: TextStyle(
                                        fontFamily: 'Avenir-Book',
                                        fontSize: 16.0,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey.withOpacity(0.15),
                                    height: 1.0,
                                  ),
                                ]
                              )
                            );
                          }
                        )
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 110.0,
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 65.0,
                        height: 65.0,
                        margin: EdgeInsets.only(bottom: 15.0, right: 15.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.redRightGradButton,
                              AppColors.redLeftGradButton
                            ]
                          )
                        ),
                        child: IconButton(
                          onPressed: (){
                            setState(() {
                              showSend = true;                              
                            });
                          },
                          iconSize: 35.0,
                          icon: Icon(Icons.create,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              )
            ]
          ),
        )
      )
    );
  }
}