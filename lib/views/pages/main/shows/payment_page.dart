import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../../../dialogs/dialogs.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/account_image.dart';
import '../../../widgets/default_image.dart';
import '../../../widgets/youtube_image.dart';

import '../../../../models/api/account.dart';
import '../../../../models/api/event.dart';
import '../../../../models/api/ticket.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';
import '../../../../helpers/view/formatter.dart';

class PaymentPage extends StatefulWidget {

  Event event;

  Map<Ticket, int> tickets;

  PaymentPage({this.event, this.tickets});

  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {

  int payemntMethod = 0;

  @override
  void initState() { 
    super.initState();
  }

  double totalPrice() {
    double res = 0.0;

    for (var ticket in widget.tickets.keys){
      res += ticket.price * widget.tickets[ticket];
    }
    return res;
  }

  void onBuy() {
    Dialogs.showLoader(context);
    DataProvider.createTickets(widget.tickets).then(
      (res) async {
        Navigator.pop(context);
        if (res.status == DataStatus.ok){
          await Dialogs.showMessageDialog(context, title: Translations.success, body: Translations.ticketsWereAdded, ok: Translations.ok).then((res){
            Navigator.pop(context);
          });
        } else {
          Dialogs.showMessageDialog(context, title: Translations.error, body: Translations.unknownError, ok: Translations.ok);
        }
      }
    );
  }

  Widget buildPaymmentMethod() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Divider(color: Colors.black.withOpacity(0.15), height: 2.0),
        ),
        GestureDetector(
          onTap: (){
            setState(() {
              payemntMethod = 1;                            
            });
          },
          child: Container(
            child: Row(
              children: <Widget>[     
                Container(
                  margin: EdgeInsets.only(left: 30.0, top: 0.0, right: 15.0),
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/images/main/shows/credit_card.png')
                    )
                  ),
                ),
                Text(Translations.creditCard,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Avenir-Book', 
                  ),
                )
              ],
            ),
          )
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Divider(color: Colors.black.withOpacity(0.15), height: 2.0),
        ),
        GestureDetector(
          onTap: (){
            setState(() {
              payemntMethod = 2;                            
            });
          },
          child: Container(
            child: Row(
              children: <Widget>[     
                Container(
                  margin: EdgeInsets.only(left: 30.0, top: 0.0, right: 15.0),
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/images/main/shows/paypal_logo.png')
                    )
                  ),
                ),
                Text(Translations.paypal,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Avenir-Book', 
                  ),
                )
              ],
            ),
          )
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Divider(color: Colors.black.withOpacity(0.15), height: 2.0),
        ),
      ],
    );
  }

  Widget buildCreditCard(){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0),
            child: TextField(
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 14.0,
                fontFamily: 'Avenir-Book', 
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.3)
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                  )
                ),
                hintText: Translations.creditCard,       
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.7),
                  fontFamily: 'Avenir-Book', 
                ),     
              ),
            )
          ),
          Padding(padding: EdgeInsets.only(top: 10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                margin: EdgeInsets.only(left: 30.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontFamily: 'Avenir-Book', 
                    fontSize: 14.0
                  ),
                  decoration: InputDecoration(
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
                    hintText: Translations.expiryDate,       
                    hintStyle: TextStyle(
                      fontFamily: 'Avenir-Book', 
                      color: Colors.grey.withOpacity(0.7)
                    ),     
                  ),
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.33,
                margin: EdgeInsets.only(right: 30.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontFamily: 'Avenir-Book', 
                    fontSize: 14.0
                  ),
                  decoration: InputDecoration(
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
                    hintText: Translations.cvv,       
                    hintStyle: TextStyle(
                      fontFamily: 'Avenir-Book', 
                      color: Colors.grey.withOpacity(0.7)
                    ),     
                  ),
                )
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 10.0)),
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0),
            child: TextField(
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontFamily: 'Avenir-Book', 
                fontSize: 14.0
              ),
              decoration: InputDecoration(
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
                hintText: Translations.cardHolder,       
                hintStyle: TextStyle(
                  fontFamily: 'Avenir-Book', 
                  color: Colors.grey.withOpacity(0.7)
                ),     
              ),
            )
          ),
          Container(
            height: 50.0,
            margin: EdgeInsets.only(top: 50.0, right: 30.0, left: 30.0, bottom: 20.0),
            child: MainButton(Translations.pay.toUpperCase(),
              onTap: onBuy,
            )
          )
        ],
      ),
    );
  }

  Widget buildPayPal(){
    return Container(
      height: 50.0,
      margin: EdgeInsets.only(top: 50.0, right: 30.0, left: 30.0, bottom: 20.0),
      child: MainButton(Translations.payWithPaypal,
        onTap: onBuy,
      )
    );
  }

  Widget buildAppBar(){
    return PreferredSize( 
      preferredSize: Size(MediaQuery.of(context).size.width, 45.0),
      child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Row(
          children:[
            Text(Translations.paymentMethod.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w700
              // fontStyle: FontStyle.italic
              ),
            )
          ]
        ),
        backgroundColor: AppColors.appBar
      )
    );
  }

  @override 
  Widget build(BuildContext ctx) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColors.mainBg,
      appBar: buildAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.fitHeight,
              image: AssetImage('assets/images/main/shows/check_form.png')
            )
          ),
          child: Container(
            padding: EdgeInsets.only(left: 0.0, top: 40.0, right: 0.0, bottom: 40.0),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                //color: Colors.green,
                child: Container(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 30.0, top: 0.0, right: 30.0),
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height * 0.33,
                        child: Column(
                          children: List.generate(widget.tickets.length, 
                            (ind) {
                              var ticket = widget.tickets.keys.toList()[ind];
                              return Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: Text(widget.event.name.toUpperCase(),
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontFamily: 'Avenir-Black', 
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text('x ${widget.tickets[ticket]}',
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontFamily: 'Avenir-Heavy', 
                                            ),
                                          ),
                                        )
                                      ]
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 5.0)),
                                    Text(Translations.translateEnum(ticket.type) + ' ${Translations.ticket.toLowerCase()}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontFamily: 'Avenir-Book', 
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 5.0)),
                                    Text(ticket.isPersonal ? '(${Translations.special})' : '(${Translations.regular})',
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontFamily: 'Avenir-Book', 
                                      ),
                                    ),     
                                    Padding(padding: EdgeInsets.only(top: 5.0)),
                                    Container(
                                      child: Text((widget.event?.venue?.displayName ?? '') + ' ' + (widget?.event?.venue?.address ?? ''), 
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontFamily: 'Avenir-Book', 
                                        ),
                                      ),
                                    ),
                                    widget.event.dateFrom != null ? 
                                    Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Text('${Formatter.longDate(widget.event.dateFrom)},',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Avenir-Medium', 
                                              fontSize: 14.0
                                            )
                                          ),
                                          Padding(padding: EdgeInsets.only(left: 2.0)),
                                          Text('${Formatter.time(widget.event.dateFrom)}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Avenir-Medium', 
                                              fontSize: 14.0
                                            )
                                          ),
                                        ],
                                      ),
                                    ) : 
                                    Container(),   
                                    ind < widget.tickets.length - 1 ? Container(
                                      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: Divider(color: Colors.black.withOpacity(0.3), height: 2.0),
                                    ) : Container(),         
                                  ],
                                ),
                              );
                            }
                          )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
                        child: Divider(color: Colors.black.withOpacity(0.3), height: 2.0),
                      ),  
                      Container(
                        margin: EdgeInsets.only(left: 30.0, right: 30.0),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('${Translations.total}: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Avenir-Book', 
                                fontSize: 16.0
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 5.0)),
                            Text('${totalPrice().toStringAsFixed(2)} ${widget.tickets.keys.toList()[0].currency}',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Avenir-Heavy', 
                                fontSize: 16.0
                              ),
                            ),
                          ]
                        )
                      ),
                      Padding(padding: EdgeInsets.only(top: 25.0)), 
                      payemntMethod == 0 ?
                       buildPaymmentMethod() : 
                       (payemntMethod == 1 ? buildCreditCard() : buildPayPal()),
                      //Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                    ],
                  )
                )
              ),
            ),
          ),
        )
      )
    );
  }
}