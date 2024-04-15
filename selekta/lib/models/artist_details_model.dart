
import 'dart:ffi';

class ArtistDetailsModel {

  final int artistID;
  final int profileID;
  final String stageName;
  final String description;
  final String imageURL;
  final String  socials;
  final int  status;
  final String  createdAt;
  final String  updatedAt;


  ArtistDetailsModel({
    required this.artistID,
    required this.profileID,
    required this.stageName,
    required this.description,
    required this.imageURL,
    required this.socials,
    required this.status,
    required this.createdAt,
    required this.updatedAt
  });


  factory ArtistDetailsModel.fromJson(Map<String, dynamic> json) {
    return ArtistDetailsModel(

      artistID: json['ArtistID'] ?? 0,
      profileID: json['ProfileID'] ?? 0,
      stageName: json['StageName'] ?? '',
      description: json['Description'] ?? '',
      imageURL: json['ImageUrl'] ?? '',
      socials: json['Socials'] ?? '',
      status: json['Status'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['UpdatedAt'] ?? '',
    );
  }
}



