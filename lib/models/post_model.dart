class PostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.postImage,
    required this.text,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    text=json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
      'text': text,
    };
  }
}
