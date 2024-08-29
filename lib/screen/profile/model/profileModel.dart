class ProfileModel{

  String? name,mobile,email,bio,uid;

  ProfileModel({this.name,this.mobile,this.email,this.bio,this.uid});

  factory ProfileModel.mapToModel(Map m1){
    return ProfileModel(
      name: m1['name'],
      mobile: m1['mobile'],
      bio: m1['bio'],
      email: m1['email'],
      uid: m1['uid']
    );
  }
}