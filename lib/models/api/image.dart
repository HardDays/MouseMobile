class Image {

  int id;

  Image({this.id});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
    );
  }

}