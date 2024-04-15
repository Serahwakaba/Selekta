
class EventsModel {

  final String title;
  final String? description;
  final String imageUrl;
  final String venue;
  final int songRate;
  final String  eventTime;


  EventsModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.venue,
    required this.songRate,
    required this.eventTime,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(

      title: json['Title'] ?? '',
      description: json['Description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      venue: json['venue'] ?? '',
      songRate: json['song_rate'] ?? 0,
      eventTime: json['event_time'] ?? '',
    );
  }
}



