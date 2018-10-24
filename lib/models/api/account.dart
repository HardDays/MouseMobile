class AccountType{
  static const String fan = 'fan';
}

enum AccountError { ok, userNameTaken }

class Account {

  AccountError error = AccountError.ok;

  int id;

  String userName;
  String firstName;
  String lastName;
  String accountType;

  Account({this.id, this.error, this.userName, this.firstName, this.lastName, this.accountType});
  
   Map <String, dynamic> toJson(){
    return {
      'id': id,
      'user_name': userName,
      'first_name': firstName,
      'last_name': lastName,
      'account_type': accountType
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      userName: json['user_name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      accountType: json['account_type'],
      error: AccountError.ok
    );
  }

}