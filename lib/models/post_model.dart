class PostModel {
  late String name;
  late String uid;
  late String profile;
  late String dateTime;
  late String text ;
  late String postImage ;

  PostModel({
    required this.name,
    required this.uid,
    required this.profile,
    required this.dateTime,
    required this.text,
    required this.postImage,

  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    profile = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];



  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'image': profile,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,


    };
  }
}
