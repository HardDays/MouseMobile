import 'package:flutter/material.dart';

import 'account_card.dart';

import '../../models/api/account.dart';
import '../../models/api/event.dart';

import '../../resources/app_colors.dart';
import '../../resources/translations.dart';

import '../../helpers/storage/data_provider.dart';
import '../../helpers/storage/cache.dart';

class AccountListController {
  String text;
  String accountType;

  Function() _onTextChange;

  AccountListController({this.text, this.accountType});

  void setText(String text){
    this.text = text;
    _onTextChange();
  }
}

class AccountList extends StatefulWidget {
  
  AccountListController controller;

  AccountList({this.controller});
  @override
  AccountListState  createState() =>  AccountListState();
}

class AccountListState extends State<AccountList> with AutomaticKeepAliveClientMixin {

  bool full = false;
  bool loading = false;

  int limit = 10;
  int offset = 0;

  ScrollController scrollController;

  List <Account> accounts;

  @override
  void initState() {
    super.initState();

    if (accounts == null){
      update();
    }
    
    scrollController = ScrollController();
    scrollController.addListener(onScroll);

    widget.controller?._onTextChange = updateText;
  }

  @override
  bool get wantKeepAlive => true;

  void onScroll(){
    if (!loading){
      if (scrollController.position.extentAfter < 500 && !full){
        loading = true;
        update();
      }
    }
  }

  void update() {
    DataProvider.getAccounts(
      text: widget.controller?.text, 
      accountType: widget.controller?.accountType,
      limit: limit,
      offset: offset
    ).then(
      (res){
        setState(() {
          if (accounts == null){
            accounts = [];
          }
          accounts.addAll(res.result);
          offset += limit;
          loading = false;
          full = res.result.length < limit;
        });
      }
    );
  }

  void updateText() {
    setState(() {
      accounts = null;          
      full = false;
      offset = 0;
    });
    update();
  }
  
  Widget build(BuildContext context) {
    if (accounts == null){
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.mainRed)),         
        ),        
      );
    } else if (accounts.isEmpty){
      return Container(
        color: Colors.white,
        child: Center(
          child: Text('No accounts found',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.w300
            ),
          ), 
        ),        
      );
    } else {
      return Container(
        child: ListView(
          controller: scrollController,
          children: List.generate(accounts.length, 
            (ind) {
              return AccountCard(account: accounts[ind]);
            }
          )
        )
      );
    }
  }
}