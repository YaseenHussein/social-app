class CommentModel {
  String? comment;
  String? image;
  CommentModel({
    required this.comment,
    required this.image,
  });

  CommentModel.fromJson(Map<String, dynamic>? json) {
    comment = json!['comment'];
    image = json['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'image': image,
    };
  }
}
