class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String uid;
  late String profile;
  late String bio;

  late String cover;

  late bool isEmailVerified;


  SocialUserModel(
      {required this.name,
     required  this.email,
      required this.phone,
      required this.bio,
       required this.uid ,
      required this.profile ,
     required  this.cover ,
        required this.isEmailVerified,
      });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    isEmailVerified = json['isEmailVerified'];
    profile = json['image'];
    bio = json['bio'];
    cover = json['cover'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'isEmailVerified': isEmailVerified,
      'image': profile,
      'bio': bio,
      'cover': cover,
    };
  }
}
