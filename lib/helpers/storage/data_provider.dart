import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'filters/shows_filter.dart';

import 'cache.dart';
import 'database.dart';

import '../api/main_api.dart';

import '../../models/api/event.dart';
import '../../models/api/account.dart';
import '../../models/api/user.dart';
import '../../models/api/comment.dart';
import '../../models/api/ticket.dart';
import '../../models/api/feed_item.dart';

enum DataStatus {
  ok, notFound, unknownError, unauthorized
}

class DataResult <T> {

  DataStatus status = DataStatus.ok;
  T result;
}

class DataProvider {

  static Account currentAccount;
  static User currentUser;

  static Future init() async {
    await Database.init();

    setCurrentUser(Database.getCurrentUser());
    setCurrentAccount(Database.getCurrentAccount());
    
    Cache.eventsFilter = EventsFilter();
    Cache.ticketsFilter = EventsFilter();
    Cache.fanTickets = {};
  }

  static void flush(){
    currentUser = null;
    currentAccount = null;

    Cache.events = null;
    Cache.fanTickets = {};
    Cache.feed = null;
    Cache.following = null;

    Database.deleteCurrentUser();
    Database.deleteCurrentUser();

    MainAPI.setToken(null);
  }


  static void setCurrentUser(User user){
    if (user != null){
      currentUser = user;
      if (user.token != null){
        MainAPI.setToken(currentUser.token);
      }
    }
  }

  static void setCurrentAccount(Account account){
    if (account != null){
      currentAccount = account;
      
      MainAPI.accountId = currentAccount.id;

      Cache.following = Set();
      MainAPI.getFollowing(currentAccount.id).then(
        (res) {
          Cache.following = res.map((acc) => acc.id).toSet();
        }
      );
    }
  }

  static Future<DataResult<Account>> getCurrentAccount() async {
    var result = DataResult<Account>();

    var res = await MainAPI.getAccount(currentAccount.id);

    if (res != null) {
      setCurrentAccount(res);
      result.result = res;
    } else {
      result.status = DataStatus.notFound;
    }

    return result;
  }

  static Account getCachedCurrentAccount() {
    return currentAccount;
  }

  static EventsFilter getEventsFilter(){
    return Cache.eventsFilter;
  }

  static void setEventsFilter(EventsFilter filter){
    Cache.eventsFilter = filter;
  }

  static EventsFilter getTicketsFilter(){
    return Cache.ticketsFilter;
  }

  static void setTicketsFilter(EventsFilter filter){
    Cache.ticketsFilter = filter;
  }

  static bool isAuthorized(){
    return currentAccount != null && currentUser != null;
  }

  //AUTH

  static Future<DataResult> login(String userName, String password) async {
    var result = DataResult();

    var res = await MainAPI.authorize(userName, password);
    if (res != null){
      MainAPI.setToken(res);
     
      var user = await MainAPI.getMe();
      var account = await MainAPI.getMyAccount();

      if (user != null && account != null){
        Database.setCurrentUser(user);
        setCurrentUser(user);

        Database.setCurrentAccount(account);
        setCurrentAccount(account);
      } else {
        result.status = DataStatus.unauthorized;
      }
    } else {
      result.status = DataStatus.unauthorized;
    }

    return result;
  }

  //USERS

  static Future<DataResult<User>> createUser(User user) async {
    var result = DataResult<User>();

    var res = await MainAPI.createUser(user);
    if (res != null){
      result.result = res;

      Database.setCurrentUser(res);
      setCurrentUser(user);
    } else {
      result.status = DataStatus.unauthorized;
    }

    return result;
  }

  //ACCOUNTS

  static Set<int> getMyFollowing(){
    return Cache.following;
  }

  static Future<DataResult<Account>> getAccount(int id, {bool cached = true}) async {
    var result = DataResult<Account>();
    
    var res = await MainAPI.getAccount(id);
    if (res != null) {
      result.result = res;
    } else {
      result.status = DataStatus.notFound;
    }

    return result;
  }

  static Future<DataResult<List<Account>>> getAccounts({String text, String accountType, int limit, int offset}) async {
    var result = DataResult<List<Account>>();
    
    var res = await MainAPI.searchAccounts(text: text, accountType: accountType, limit: limit, offset: offset);
    if (res != null) {
      result.result = res;
    } else {
      result.status = DataStatus.notFound;
    }

    return result;
  }

  static Future<DataResult<Account>> createAccount(Account account) async {
    var result = DataResult<Account>();
    
    var res = await MainAPI.createAccount(account);
    if (res != null) {
      result.result = res;
      
      Database.setCurrentAccount(res);
      setCurrentAccount(res);
    } else {
      result.status = DataStatus.unknownError;
    }

    return result;
  }

  static Future<DataResult<Account>> updateAccount(Account account) async {
    var result = DataResult<Account>();
    
    var res = await MainAPI.updateAccount(account);
    if (res != null) {
      result.result = res;
      
      Database.setCurrentAccount(res);
      setCurrentAccount(res);
    } else {
      result.status = DataStatus.unknownError;
    }

    return result;
  }

  static Future<DataResult<List<Account>>> getFollowing(int id) async {
    var result = DataResult<List<Account>>();
    
    var res = await MainAPI.getFollowing(id);
    if (res != null) {
      result.result = res;
    } else {
      result.status = DataStatus.notFound;
    }

    return result;
  }

   static Future<DataResult<List<Account>>> getFollowers(int id) async {
    var result = DataResult<List<Account>>();
    
    var res = await MainAPI.getFollowers(id);
    if (res != null) {
      result.result = res;
    } else {
      result.status = DataStatus.notFound;
    }

    return result;
  }


  static Future<DataResult> follow(int id) async {
    var result = DataResult<DataResult>();
    
    var res = await MainAPI.follow(id);
    if (res) {
      Cache.following.add(id);
    } else {
      result.status = DataStatus.notFound;
    }
    currentAccount.followingCount = Cache.following.length;

    return result;
  }

  static Future<DataResult> unfollow(int id) async {
    var result = DataResult<DataResult>();
    
    var res = await MainAPI.unfollow(id);
    if (res) {
      Cache.following.remove(id);
    } else {
      result.status = DataStatus.notFound;
    }
    currentAccount.followingCount = Cache.following.length;

    return result;
  }

  //EVENTS

  static Future<DataResult<Event>> getEvent(int id) async {
    var result = DataResult<Event>();
    
    var res = await MainAPI.getEvent(id);
    if (res != null) {
      result.result = res;
    } else {
      result.status = DataStatus.notFound;
    }

    return result;
  }

  static Future<DataResult<List<Event>>> getEvents({String text, EventsFilter filter, bool cached = true}) async {
    var result = DataResult<List<Event>>();
    
    if (cached && Cache.events != null){
      result.result = Cache.events;
    } else {
      var res = await MainAPI.searchEvents(text: text, filter: filter);
      result.result = res;
    }
    return result;
  }

  static Future<DataResult<List<Event>>> getUpcomingEvents(int id, {int limit, int offset}) async {
    var result = DataResult<List<Event>>();
    
    var res = await MainAPI.getUpcomingShows(id, limit: limit, offset: offset);
    result.result = res;

    return result;
  }

  // COMMENTS

  static Future<DataResult<List<Comment>>> getEventComments(int id) async {
    var result = DataResult<List<Comment>>();
    
    var res = await MainAPI.getEventComments(id);
    result.result = res;

    return result;
  }

  // TICKETS

  static Future<DataResult> createTickets(Map<Ticket, int> tickets) async {
    var result = DataResult();
    
    var res = await MainAPI.buyTickets(tickets);
    if (!res){
      result.status = DataStatus.unknownError;
    } 
    
    return result;
  }

  static Future<DataResult<List<Ticket>>> getEventFanTickets(int id) async {
    var result = DataResult<List<Ticket>>();
    
    var res = await MainAPI.getEventFanTickets(id);
    result.result = res;
    
    return result;
  }

   static Future<DataResult<List<Event>>> getFanTickets({String time = TicketTime.current, EventsFilter filter}) async {
    var result = DataResult<List<Event>>();
    if (Cache.fanTickets[time] != null) { 
      result.result = Cache.fanTickets[time];
    } else {
      result.result = await MainAPI.searchFanTickets(time: time, filter: filter);
      Cache.fanTickets[time] = result.result;
    }
    return result;
  }

  static List<Event> getCachedFanTickets({String time = TicketTime.current}) {
    return Cache.fanTickets[time];
  }

  static void flushFanTickets({String time = TicketTime.current}){
    Cache.fanTickets[time] = null;
  }

  // FEED

   static Future<DataResult<List<FeedItem>>> getFeed() async {
    var result = DataResult<List<FeedItem>>();
    if (Cache.feed != null) { 
      result.result = Cache.feed;
    } else {
      result.result = await MainAPI.getFeed();
      Cache.feed = result.result.where((item) => !item.isDeleted).toList();
    }
    return result;
  }

  static List<FeedItem> getCachedFeed() {
    return Cache.feed;
  }

}