class AccountType {
  
  static const String fan = 'fan';
  static const String venue = 'venue';
  static const String artist = 'artist';
  
}

enum AccountError { ok, userNameTaken }

class Account {

  AccountError error = AccountError.ok;

  int id;
  int imageid;

  String userName;
  String firstName;
  String lastName;
  String displayName;

  String accountType;

  String address;
  String preferredAddress;

  List <String> genres;
  

  Account({
      this.id, this.imageid, this.error,
      this.userName, this.firstName, this.displayName, this.lastName, 
      this.address, this.preferredAddress, this.accountType,
      this.genres
    }
  );
  
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
      displayName: json['display_name'],
      address: json['address'],
      preferredAddress: json['preferred_address'],
      genres: List<String>.from(json['genres']),
      imageid: json['image_id'],
      error: AccountError.ok
    );
  }

}