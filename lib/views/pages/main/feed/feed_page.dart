import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../shows/show_page.dart';

import '../../start/start_page.dart';

import '../../../widgets/main_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/account_image.dart';
import '../../../widgets/default_image.dart';
import '../../../widgets/youtube_image.dart';

import '../../../dialogs/dialogs.dart';
import '../../../dialogs/genres_filter_dialog.dart';
import '../../../dialogs/location_filter_dialog.dart';
import '../../../dialogs/other_filter_dialog.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/event.dart';
import '../../../../models/api/feed_item.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';
import '../../../../helpers/storage/filters/shows_filter.dart';

class FeedPage extends StatefulWidget  {

  final String title = 'FEED';
  final String icon = 'assets/images/main/feed_tab_icon.svg';

  TabController bottomController;

  Widget appBar;
  Function(Widget) onLoad;

  FeedPage({this.bottomController});

  @override
  FeedPageState createState() => FeedPageState();
}

class FeedPageState extends State<FeedPage>  {

  @override
  void initState() {
    super.initState();
  
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (context != null){
          if (DataProvider.isAuthorized()){
            DataProvider.getFeed().then(
              (res){
                if (mounted){
                  setState(() {});
                }
              }
            );
            buildAppBar(context);
          } else {
            if (widget.bottomController.index == 1) {
              if (!widget.bottomController.indexIsChanging) {
                Dialogs.showYesNo(context, 
                  title: 'Unauthorized', 
                  body: 'Please, login for this action', 
                  yes: 'Yes', 
                  no: 'No', 
                  onYes: (){
                    Navigator.pushReplacement(
                      this.context,
                      DefaultPageRoute(builder: (context) => StartPage()),
                    );
                  }, 
                  onNo: (){
                    widget.bottomController.index = 2;
                  }
                );
              }
            }
          }
        }
      }
    );
  }

  void onLike(FeedItem item){
    setState(() {
      item.isLiked = !item.isLiked;
      if (item.isLiked){
        item.likesCount++;
      } else {
        item.likesCount--;
      }      
    });
  }

  Widget buildItem(Widget text, Widget item){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[ 
        Container(
          margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
          child: text
        ),
        item,
      ]
    );
  }

  Widget buildDefaultText(String text, String midText, FeedItem item){
    return  Row(
      children: [
        Text(text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontFamily: 'Avenir-Book'
          ),
        ),
        item.event != null ?
        Container(
          margin: EdgeInsets.only(left: 3.0),
          child: Text(midText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: 'Avenir-Book'
            ),
          )
        ) : 
        Container( 
          child: Text(':',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: 'Avenir-Book'
            ),
          )),
        item.event != null ?
        Flexible(
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                this.context,
                DefaultPageRoute(builder: (context) => ShowPage(item.event.id)),
              );  
            },
            child: Container(
              margin: EdgeInsets.only(left: 3.0),
              child: Text(item.event.name ?? 'Unnamed',
                maxLines: 1,
                style: TextStyle(
                  color: AppColors.textRed,
                  fontSize: 14.0,
                  fontFamily: 'Avenir-Book'
                ),          
              )
            )
          )
        ) : 
        Container()
      ]
    );
  }

  Widget buildUpdate(FeedItem item) {
    if (item.action == FeedAction.update) {
      if (item.field == FeedField.image) {
        return buildItem(buildDefaultText('Added image', 'to', item),  
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.6,
            child: DefaultImage(id: int.parse(item.value)),
          )
        );
      } else if (item.field == FeedField.video) {
        return buildItem(buildDefaultText('Added video', 'to', item), 
          YoutubeImage(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.6,
            link: item.video?.link ?? '',
          )
        );
      } else {
        return buildItem(buildDefaultText('Changed ${Translations.translateEnum(item.field).toLowerCase()}', 'of', item), 
          Container(
            child: Text('${item.value}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontFamily: 'Avenir-Book'
              ),
            ),
            margin: EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0, bottom: 10.0)
          )
        );
      }
    } else if (item.action == FeedAction.addGenre) {
      return buildItem(buildDefaultText('Added genre "${item.value}"', 'to', item), 
        Container(
          margin: EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0, bottom: 10.0)
        )
      );
    } else if (item.action == FeedAction.addTicket){
      return buildItem(buildDefaultText('Added new ticket', 'to', item), 
        Container(
          margin: EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0, bottom: 10.0)
        )
      );
    } else if (item.action == FeedAction.launchEvent){
      return buildItem(buildDefaultText('Launched event', '', item), 
        Container(
          margin: EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0, bottom: 10.0)
        )
      );
    }
    return Container(
        
    );
  }

  Widget  buildCard(FeedItem item){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 7.0, bottom: 7.0),
      child: Column(
        children: <Widget>[ 
          Container(
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0, right: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                 Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AccountImage(account: item.account, size: 40.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.37,
                      height: 40.0,
                      margin: EdgeInsets.only(left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(item.account.displayName ?? 'Unnamed',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Avenir-Medium', 
                              fontSize: 14.0
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 3.0)),  
                          Row(
                            children: <Widget>[
                              Text('@',
                                maxLines: 1,
                                style: TextStyle(
                                  color: AppColors.mainRed,
                                  fontFamily: 'Avenir-Book', 
                                  fontSize: 12.0
                                ),
                              ),
                              Text(item.account.userName ?? '',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Avenir-Book', 
                                  fontSize: 12.0
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]
                 ),
                Container(
                  margin: EdgeInsets.only(top: 3.0),
                  child: Text('${DateFormat('dd.MM.yyyy').format(item.createdAt)}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Avenir-Book', 
                      fontSize: 10.0
                    ),
                  ),
                )
              ]
            ),
          ),
          buildUpdate(item),
          Container(
            margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 0.0),
            child: Divider(
              height: 2.0,
              color: Colors.grey.withOpacity(0.5)
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10.0)),
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 10.0)),
              InkWell(
                onTap: (){
                  onLike(item);
                },
                child: Icon(item.isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 15.0,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 0.0, left: 5.0),
                child: Text('${item.likesCount}',
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.9),
                    fontSize: 14.0,   
                    fontFamily: 'Avenir-Book'
                  ),
                )
              ),
              Padding(padding: EdgeInsets.only(left: 15.0)),
              InkWell(
                child: Icon(Icons.chat_bubble_outline,
                  size: 15.0,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 0.0, left: 5.0),
                child: Text('${item.commentsCount}',
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.9),
                    fontSize: 14.0,   
                    fontFamily: 'Avenir-Book'
                  ),
                )
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 10.0))
        ]
      )
    );
  }

  void buildAppBar(BuildContext context){
    widget.appBar = PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Row(
          children:[
            Container(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              width: 25.0,
              height: 20.0,
              child: DecoratedBox(
                decoration: BoxDecoration(                               
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/start/mouse_logo.png'),
                  ),
                ),
              )
            ),
            Padding(padding: EdgeInsets.only(left: 10.0)),
            Text(widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'Avenir-Black', 
               // fontStyle: FontStyle.italic
              ),
            )
          ]
        ),
        backgroundColor: AppColors.appBar,
        actions: [
        ]
      )
    );
    widget.onLoad(widget.appBar);
  } 

  @override 
  Widget build(BuildContext ctx) {
    if (DataProvider.getCachedFeed() == null) {
      return Container(
        color: AppColors.feedBg,
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.mainRed)),         
        ),        
      );
    } else if (DataProvider.getCachedFeed().isEmpty) {
      return Container(
        color: AppColors.feedBg,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text('No feed updates',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300
                ),
              ),
            )
          ],        
        ),        
      );
    } else {
      return Container(
        color: AppColors.feedBg,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100.0,
            child: ListView(
              children: List.generate(DataProvider.getCachedFeed().length, 
                (ind) {
                  return buildCard(DataProvider.getCachedFeed()[ind]);
                }
              )
            )
          ),
        ),
      );
    }
  }
}