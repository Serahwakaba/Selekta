
class EventsModel {
  final int eventId;
  final int artistId;
  final String title;
  final String? description;
  final String imageUrl;
  final String venue;
  final int songRate;
  final String eventTime;
  final String createdAt;
  final String updatedAt;

  EventsModel({
    required this.eventId,
    required this.artistId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.venue,
    required this.songRate,
    required this.eventTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      eventId: json['event_id'] ?? 0,
      artistId: json['artist_id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      venue: json['venue'] ?? '',
      songRate: json['song_rate'] ?? 0,
      eventTime: json['event_time'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}



