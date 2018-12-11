import 'dart:async';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import 'payment_page.dart';

import '../profile/account_page.dart';

import '../../../dialogs/dialogs.dart';

import '../../../widgets/main_button.dart';
import '../../../widgets/follow_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/account_image.dart';
import '../../../widgets/default_image.dart';
import '../../../widgets/youtube_image.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/account.dart';
import '../../../../models/api/event.dart';
import '../../../../models/api/ticket.dart';
import '../../../../models/api/comment.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';
import '../../../../helpers/view/formatter.dart';

class ShowPage extends StatefulWidget {

  int id;

  ShowPage(this.id);

  ShowPageState createState() => ShowPageState();
}

class ShowPageState extends State<ShowPage> with SingleTickerProviderStateMixin {

  bool artistsLoaded = false;
  bool commentsLoaded = false;

  int artistIndex = 0;
  String comment;

  Event event;
  
  TextEditingController commentController;
  TabController tabController;

  Map <Ticket, int> tickets;

  @override
  void initState(){
    super.initState();

    tabController = TabController(length: 3, vsync: this);
    commentController = TextEditingController();

    tabController.addListener(
      () {
        setState(() {
                  
        });
      }
    );

    if (event == null){
      DataProvider.getEvent(widget.id).then(
        (res) {
          setState(() {
            this.event = res.result;             
          });

          List <Account> artists = [];

          for (var art in event.artists) {
            DataProvider.getAccount(art.id).then(
              (account) {
                if (account.status == DataStatus.ok) {
                  artists.add(account.result);
                }
              }
            );
          }   
          setState(() {
            this.event.artists = artists;            
            artistsLoaded = true;          
          });

          setState(() {      
            tickets = {};    
            for (var ticket in event.tickets){
              tickets[ticket] = 0;
            }            
          });

          DataProvider.getEventComments(widget.id).then(
            (res){
              setState(() {
                this.event.comments = res.result;
                commentsLoaded = true;              
              });
            }
          );
        }
      );
    }
  }

  void onAddComment(){
    if (comment != null && comment.isNotEmpty){
      var comm = Comment(text: comment, account: DataProvider.currentAccount, eventId: event.id);
      setState(() {
        event.comments.insert(0, comm); 
        comment = null;     
        commentController.clear();
        FocusScope.of(context).requestFocus(FocusNode());
        DataProvider.createEventComment(comm);
      });
    }
  }

  void onTicketMinus(Ticket ticket){
    if (tickets[ticket] > 0){
      setState(() {
        tickets[ticket]--;                                                
      });
    }
  }

  void onTicketAdd(Ticket ticket){
    if (tickets[ticket] < ticket.ticketsLeft ?? 100){
      setState(() {
        tickets[ticket]++;                                                
      });
    } else {
      Dialogs.showMessageDialog(context, 
        title: Translations.noTicketsLeft, 
        body: Translations.pleaseSelectTickets, 
        ok: Translations.ok
      );
    }
  }

  void onBuy(){
    Map <Ticket, int> filtered = {};
    for (var ticket in tickets.keys){
      if (tickets[ticket] > 0){
        filtered[ticket] = tickets[ticket];
      }
    } 
    if (filtered.isEmpty){
      Dialogs.showMessageDialog(context, 
      title: Translations.emptyCart, 
      body: Translations.pleaseSelectTickets, 
      ok: Translations.ok
    );
    } else {
      double price = 0.0;

      for (var ticket in tickets.keys){
        price += ticket.price * tickets[ticket];
      }
      
      if (price == 0){
        Dialogs.showLoader(context);
        DataProvider.createTickets(tickets).then(
          (res) async {
            Navigator.pop(context);
            if (res.status == DataStatus.ok){
              await Dialogs.showMessageDialog(context, title: Translations.success, body: Translations.ticketsWereAdded, ok: Translations.ok).then((res){});
            } else {
              Dialogs.showMessageDialog(context, title: Translations.error, body: Translations.unknownError, ok: Translations.ok);
            }
          }
        );
      } else {
        if (DataProvider.isAuthorized()){
          Navigator.push(
            this.context,
            DefaultPageRoute(builder: (context) => PaymentPage(event: event, tickets: filtered)),
          );   
        } else {
          Dialogs.showMessageDialog(context, title: Translations.unauthorized, body: Translations.pleaseLogin, ok: Translations.ok);
        }
      }
    }
  }

  Widget buildAccount(Account account, double size){
    return Row(
      children: <Widget>[
        AccountImage(account: account, size: size),
        Container(
          width: MediaQuery.of(context).size.width * 0.37,
          height: 60.0,
          margin: EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(account.displayName ?? Translations.unnamed,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Avenir-Heavy', 
                  fontSize: 16.0
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
                      fontSize: 13.0
                    ),
                  ),
                  Text(account.userName ?? '',
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Avenir-Book', 
                      fontSize: 13.0
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]
    );
  }

  Widget buildTickets(){
    if (event.tickets.isEmpty){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Center(
          child: Text(Translations.noTickets,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
              fontFamily: 'Avenir-Book', 
            ),
          )
        ),
      );
    } else {
      return Container(
        child: Column(
          children: [
            Column(
              children: List.generate(event.tickets.length, 
                (ind){
                  var ticket = event.tickets[ind];
                  return Container(
                    margin: EdgeInsets.only(left: 15.0, right: 0.0, top: 15.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 100.0,
                                height: 95.0,
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  color: ticket.type == TicketType.vr ? AppColors.vrTicket : (ticket.isPromotional ? AppColors.promoTicket : AppColors.inPersonTicket),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                                ),
                              ),
                              Container(
                                width: 100.0,
                                height: 95.0,
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  color: ticket.type == TicketType.vr ? AppColors.vrTicket : (ticket.isPromotional ? AppColors.promoTicket : AppColors.inPersonTicket),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                          height: 115.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage('assets/images/main/shows/ticket_form.png')
                            )
                          ),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 5.0, top: 12.0, bottom: 12.0, right: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(Translations.translateEnum(ticket.type).toUpperCase() + ' ${Translations.ticket.toUpperCase()}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontFamily: 'Avenir-Heavy', 
                                          ),
                                        ),
                                        Text('${Translations.translateEnum(ticket.currency)}${ticket.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: AppColors.textRed,
                                            fontSize: 14.0,
                                            fontFamily: 'Avenir-Black', 
                                          ),
                                        ),
                                        Text(ticket.isPromotional ? Translations.promo.toUpperCase() : '${Translations.general.toUpperCase()}',
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontFamily: 'Avenir-Book', 
                                          ),
                                        ),
                                        Text(ticket.isPersonal ? '(${Translations.special})' : '(${Translations.regular})',
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontFamily: 'Avenir-Book', 
                                          ),
                                        ),                                         
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.32,
                                    alignment: Alignment.center,
                                    child: ticket.ticketsLeft > 0 ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: (){
                                            onTicketMinus(ticket);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.zero,
                                            alignment: Alignment.centerLeft,
                                            width: 24.0,
                                            height: 24.0,
                                            child: Icon(Icons.arrow_back_ios,
                                              size: 24.0,
                                              color: Colors.black.withOpacity(0.7),
                                            ),
                                          )
                                        ),
                                        Text('${tickets[ticket]}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 50.0,
                                            fontFamily: 'Avenir-Book', 
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            onTicketAdd(ticket);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.zero,
                                            alignment: Alignment.centerLeft,
                                            width: 24.0,
                                            height: 24.0,
                                            child: Icon(Icons.arrow_forward_ios,
                                              size: 24.0,
                                              color: Colors.black.withOpacity(0.7),
                                            ),
                                          )
                                        )
                                      ],
                                    ) : 
                                    Container(
                                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                                      alignment: Alignment.center,
                                      child: Text(Translations.soldOut.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25.0,
                                          fontFamily: 'Avenir-Book', 
                                        ),
                                      )
                                    )
                                  ),
                                ] 
                              )
                            )  
                          ),
                        ),
                      ],
                    ),
                  );
                }
              )
            ),
            Container(
              height: 45.0,
              margin: EdgeInsets.only(top: 30.0, bottom: 20.0, left: 15.0, right: 15.0),
              child: MainButton(Translations.buyTicket.toUpperCase(),
                onTap: () {
                  onBuy();
                }
              ),
            )
          ]
        )
      );
    }
  }

  Widget buildArtists(){
    if (!artistsLoaded || event.artists.isEmpty){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Center(
          child: Text(Translations.noArtists,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
              fontFamily: 'Avenir-Book', 
            ),
          )
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(15.0), 
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(event.artists.length, 
                  (ind) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          artistIndex = ind;                            
                        });
                      },
                      child: Container(
                        //width: MediaQuery.of(context).size.width * 0.4,
                        margin: EdgeInsets.only(right: 20.0, top: 5.0, bottom: 15.0),
                        child: Text(event.artists[ind].displayName.toUpperCase() ?? Translations.unnamed.toUpperCase(),
                          maxLines: 1,
                          style: TextStyle(
                            color: ind == artistIndex ? AppColors.textRed : Colors.white,
                            fontSize: 14.0,
                            fontFamily: 'Avenir-Heavy', 
                          ),
                        )
                      )
                    );
                  }
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildAccount(event.artists[artistIndex], 60.0),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  height: 30.0,
                  child: FollowButton(account: event.artists[artistIndex])
                )
              ],
            ),
            event.artists[artistIndex].about != null ? Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 15.0),
              child: Text(event.artists[artistIndex].about ?? '',
                maxLines: 7,
                style: TextStyle(
                  height: 18.0 / 14.0,
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: 'Avenir-Book', 
                ),
              ),
            ) :
            Container(),

            event.artists[artistIndex].videos.isNotEmpty ? 
            Container(
              margin: EdgeInsets.only(top: 20.0),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(Translations.video.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Avenir-Black', 
                      fontSize: 14.0
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  YoutubeImage(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    link: event.artists[artistIndex].videos[0].link
                  ),
                ],
              ),
            ) : 
            Container(),

            event.artists[artistIndex].images.isNotEmpty ? 
            Container(
              margin: EdgeInsets.only(top: 20.0),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(Translations.photos.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Avenir-Black', 
                      fontSize: 14.0
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    width:  MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(event.artists[artistIndex].images.length, 
                        (ind) {
                          return Container(
                            margin: EdgeInsets.only(right: 5.0),
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.width * 0.45, 
                            child: DefaultImage(id: event.artists[artistIndex].images[ind].id)
                          );
                        }
                      ),
                    ),
                  )
                ],
              ),
            ) : 
            Container()
          ]
        )
      );
    }
  }

  Widget buildComments() {
    if (!artistsLoaded){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Center(
          child: Text('${Translations.loading}...',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
              fontFamily: 'Avenir-Book', 
            ),
          )
        ),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[ 
            DataProvider.isAuthorized() ? Container(
              margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 10.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AccountImage(account: DataProvider.currentAccount, size: 50.0),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      controller: commentController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: 'Avenir-Book', 
                      ),
                      decoration: InputDecoration.collapsed(
                        hintText: Translations.addComment,       
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.5),
                          fontFamily: 'Avenir-Book', 
                        )     
                      ),
                      onChanged: (val){
                        setState(() {
                          comment = val;                          
                        });
                      },
                    )
                  ),
                  Container(
                    child: IconButton(
                      onPressed: onAddComment,
                      iconSize: 25.0,
                      icon: Icon(Icons.send, color: Colors.white),
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ) : Container(),
            Container(
              child: Divider(color: Colors.white.withOpacity(0.15), height: 2.0),
            ),

            event.comments.isEmpty ? 
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Text(Translations.noComments,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                    fontFamily: 'Avenir-Book', 
                  ),
                )
              ),
            ) :
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  Column(
                    children: List.generate(event.comments.length, 
                      (ind){
                        return Container(
                          margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                          child: Column(
                            children: <Widget>[
                              buildAccount(event.comments[ind].account, 50.0),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 68.0, top: 5.0, bottom: 20.0),
                                child: Text(event.comments[ind].text,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Avenir-Book', 
                                  ),
                                ),
                              ),
                              Container(
                                child: Divider(color: Colors.white.withOpacity(0.15), height: 2.0),
                              )
                            ],
                          ),
                        );
                      }
                    )
                  )
                ]
              )
            )
          ],
        ),
      );
    }
  }

  Widget buildAppBar(){
    return PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Row(
          children:[
            Text(Translations.showPreview.toUpperCase(),
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
          IconButton(
            icon: Icon(Icons.star_border, color: Colors.white),
            onPressed: () {    
                          
            }
          ),
        ]
      )
    );
  }

  @override 
  Widget build(BuildContext ctx) {
    
    if (event == null) {
      return Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: buildAppBar(),
        body: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.mainRed)),         
        ),        
      );
    } else {
      bool isPromo = false;
      for (var tk in event.tickets){
        if (tk.isPromotional){
          isPromo = true;
        }
      }
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: AppColors.mainBg,
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: DefaultImage(id: event.imageId)
                ),
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 1.0,
                      child: Text(event.name.toUpperCase(),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: 'Avenir-Black', 
                          color: Colors.white
                        ),
                      ),
                    ),
                    isPromo ? 
                    Container(
                      margin: EdgeInsets.only(top: 0.0),
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      color: AppColors.promoBg,
                      child: Text(Translations.promo.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Montserrat-SemiBold', 
                          color: Colors.black,
                          fontSize: 13.0
                        ),
                      ),
                    ) : 
                    Container(),
                  
                    event.dateFrom != null ? 
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: <Widget>[
                          Text('${Translations.translateEnum(DateFormat.EEEE().format(event.dateFrom)).toUpperCase()},',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir-Black',
                              fontSize: 15.0
                            )
                          ),
                          Padding(padding: EdgeInsets.only(left: 2.0)),
                          Text(Formatter.long3Date(event.dateFrom),
                            style: TextStyle(
                              color: AppColors.textRed,
                              fontFamily: 'Avenir-Black',
                              fontSize: 15.0
                            )
                          ),
                          Padding(padding: EdgeInsets.only(left: 2.0)),
                          Text('- ${Formatter.time(event.dateFrom)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir-Black', 
                              fontSize: 15.0
                            )
                          ),
                        ],
                      ),
                    ) : 
                    Container(),
                    
                    event.venue != null ? 
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          this.context,
                          DefaultPageRoute(builder: (context) => AccountPage(id: event.venue.id)),
                        );  
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[ 
                          Container(
                            margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Divider(
                              color: Colors.grey.withOpacity(0.3), 
                              height: 2.0
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 20.0, 
                                height: 20.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/common/pin.png')
                                  )
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(event?.venue?.displayName?.toUpperCase() ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Avenir-Black', 
                                    fontSize: 16.0
                                  )
                                )
                              ),                
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: EdgeInsets.only(left: 35.0, top: 5.0),
                            child: Text(event.venue.address ?? '',
                              style: TextStyle(
                                height: 16.0 / 14.0,
                                fontSize: 14.0,
                                color: Colors.white,
                                fontFamily: 'Avenir-Book', 
                              )
                            )
                          ),
                        ]
                      )
                    ) : 
                    Container(),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 0.0),
                      child: Divider(
                        color: Colors.grey.withOpacity(0.3), 
                        height: 2.0
                      ),
                    ),
                    Text(event.description ?? '', 
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 18.0 / 14.0,
                        color: Colors.white,
                        fontFamily: 'Avenir-Book', 
                      )
                    ),
                    event.hashtag != null ? 
                    Container(
                      margin: EdgeInsets.only(top: 0.0),
                      child: Row(
                        children: <Widget>[
                          Text('#',
                            style: TextStyle(
                              fontSize: 14.0, 
                              color: AppColors.textRed,
                              fontFamily: 'Avenir-Heavy', 
                            )
                          ),
                          Text(event.hashtag,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontFamily: 'Avenir-Heavy', 
                            )
                          ),                       
                        ]
                      )
                    ) : 
                    Container(),
                    event.genres.isNotEmpty ? Container(
                      margin: EdgeInsets.only(top: 15.0),
                      height: 25.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(event.genres.length, 
                          (ind) {
                            return Container(
                              margin: EdgeInsets.only(right: 7.0),
                              child: MainTagbox(Translations.translateEnum(event.genres[ind]).toUpperCase(),
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Avenir-Book', 
                                  fontSize: 12.0
                                ),
                                uncheckedGradient: LinearGradient(
                                  colors: [
                                    Colors.grey.withOpacity(0.2),
                                    Colors.grey.withOpacity(0.2),
                                  ]
                                ),
                              )
                            );
                          }
                        )
                      )
                    ) :
                    Container(),
                    
                    event.isCrowdfunding ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20.0, bottom: 25.0),
                            child: Divider(
                              color: Colors.grey.withOpacity(0.3), 
                              height: 2.0
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Text('${Translations.funded}:',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontFamily: 'Avenir-Book', 
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 5.0)),
                                    Container(
                                      child: Text('${(100 * min(event.founded / max(1.0, event.fundingGoal), 1.0)).floor()}%',
                                        style: TextStyle(
                                          color: AppColors.promoBg,
                                          fontSize: 14.0,
                                          fontFamily: 'Avenir-Black', 
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 5.0)),   
                                    Container(
                                      child: Text('(${Translations.translateEnum(event.currency)}${NumberFormat('###,000').format(event.founded.toInt())})',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontFamily: 'Avenir-Book', 
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: (MediaQuery.of(context).size.width - 30) * min(event.founded / max(1.0, event.fundingGoal), 1.0),
                                        height: 5.0,
                                        color: AppColors.promoBg,
                                      ),
                                      Container(
                                        width: (MediaQuery.of(context).size.width - 30) * (1.0 - min(event.founded / max(1.0, event.fundingGoal), 1.0)),
                                        height: 5.0,
                                        color: AppColors.promoBg.withOpacity(0.15),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('${Translations.goal}: ${Translations.translateEnum(event.currency)}${NumberFormat('###,000').format(event.fundingGoal.toInt())}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontFamily: 'Avenir-Book', 
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text('${event.backers}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              fontFamily: 'Avenir-Black', 
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.only(left: 5.0)),
                                          Text(Translations.backers,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              fontFamily: 'Avenir-Book', 
                                            ),
                                          )
                                        ],
                                      ),

                                      event.fundingTo != null && event.fundingTo.difference(DateTime.now()).inDays > 0 ? 
                                      Row(
                                        children: <Widget>[
                                          Text('${event.fundingTo.difference(DateTime.now()).inDays}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              fontFamily: 'Avenir-Heavy', 
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.only(left: 5.0)),
                                          Text(Translations.daysToGo,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              fontFamily: 'Avenir-Black', 
                                            ),
                                          )
                                        ],
                                      ) : 
                                      Container(
                                        child: Text(Translations.finished,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontFamily: 'Avenir-Book', 
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ) : 
                    Container()
                  ]
                )
              ),  
              Container(
                margin: EdgeInsets.only(top: 10.0),
                color: AppColors.appBar,
                child: TabBar(
                  indicatorColor: Colors.white,
                  controller: tabController,
                  tabs: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Text(Translations.tickets.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white, 
                          fontFamily: 'Avenir-Heavy',
                          fontSize: 13.0 
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Text(Translations.info.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Avenir-Heavy',
                          fontSize: 13.0 
                        ),
                      ),
                    ) ,
                    Container(  
                      margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Text('${Translations.comments.toUpperCase()} (${event.comments.length})',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Avenir-Heavy',
                          fontSize: 13.0 
                        ),
                      ),
                    ) 
                  ],
                )
              ),
              tabController.index == 0 ? buildTickets() : (
                tabController.index == 1 ? buildArtists() : 
                buildComments()
              )
            ],
          ),
        ),
      );
    }
  }
}