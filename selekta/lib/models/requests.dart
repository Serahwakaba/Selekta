class Requests {
  final int id;
  final String title;
  final String artistName;
  final String albumTitle;
  final String previewUrl;
  final String ImageUrl;


  Requests({
    required this.id,
    required this.title,
    required this.artistName,
    required this.albumTitle,
    required this.previewUrl,
    required this.ImageUrl,

  });

  factory Requests.fromJson(Map<String, dynamic> json) {
    return Requests(
      id: json['id'],
      title: json['title'],
      artistName: json['artist']['name'],
      albumTitle: json['album']['title'],
      previewUrl: json['preview'],
      ImageUrl: json['album']['cover'],

    );
  }
}