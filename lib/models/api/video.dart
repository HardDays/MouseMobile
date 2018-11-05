class Video {

  int id;

  String link;
  String name;
  String albumName;

  Video({this.id, this.link, this.name, this.albumName});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      link: json['link'],
      name: json['name'],
      albumName: json['album_name']
    );
  }
}