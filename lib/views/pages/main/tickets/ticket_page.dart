import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'widgets/ticket_header.dart';

import 'ticket_info_page.dart';

import '../../../widgets/main_button.dart';
import '../../../widgets/main_tagbox.dart';
import '../../../widgets/default_image.dart';

import '../../../dialogs/dialogs.dart';
import '../../../dialogs/genres_filter_dialog.dart';
import '../../../dialogs/location_filter_dialog.dart';
import '../../../dialogs/other_filter_dialog.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/ticket.dart';
import '../../../../models/api/event.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/translations.dart';

import '../../../../helpers/storage/data_provider.dart';
import '../../../../helpers/storage/filters/shows_filter.dart';

class TicketPage extends StatefulWidget {
  Event event;

  TicketPage({this.event});

  TicketPageState createState() => TicketPageState();
}

class TicketPageState extends State<TicketPage> {

  List<Ticket> tickets;

  @override
  void initState() {
    super.initState();

    if (tickets == null){
      DataProvider.getEventFanTickets(widget.event.id).then(
        (res){
          setState(() {
            tickets = res.result;                      
          });
        }
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
            Text(Translations.tickets.toUpperCase(),
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
  }

  Widget build(BuildContext context){
    if (tickets == null){
      return Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: buildAppBar(),
        body: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.mainRed)),         
        ),        
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TicketHeader(event: widget.event, showDivider: false),
                //Padding(padding: EdgeInsets.only(top: 10.0)),
                Container(
                  margin: EdgeInsets.only(left: 15.0),
                  child: Text('${tickets.length} ${Translations.tickets}:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontFamily: 'Avenir-Book'
                    ),
                  )
                ),
                Column(
                  children: List.generate(tickets.length, 
                    (ind) {
                      var ticket = tickets[ind];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            this.context,
                            DefaultPageRoute(builder: (context) => TicketInfoPage(event: widget.event, ticket: tickets[ind],)),
                          );  
                        },  
                        child: Container(
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
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      this.context,
                                      DefaultPageRoute(builder: (context) => TicketInfoPage(event: widget.event, ticket: tickets[ind],)),
                                    );  
                                  },  
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
                                                Text('${ticket.price.toStringAsFixed(2)} ${ticket.currency}',
                                                  style: TextStyle(
                                                    color: AppColors.textRed,
                                                    fontSize: 14.0,
                                                    fontFamily: 'Avenir-Black', 
                                                  ),
                                                ),
                                                Text(ticket.isPromotional ? Translations.promo.toUpperCase() : Translations.general.toUpperCase(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontFamily: 'Avenir-Book', 
                                                  ),
                                                ),
                                                Text(ticket.isPersonal ? '(Special)' : '(Regular)',
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
                                            margin: EdgeInsets.only(right: 30.0),
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage('assets/images/main/tickets/qr.png')
                                              )
                                            ),
                                          )
                                        ] 
                                      )
                                    )
                                  )
                                ),
                              )
                            ],
                          ),
                        )
                      );
                    }
                  )
                )
              ],
            ),
          ) 
        ),
      );
    }
  }
}