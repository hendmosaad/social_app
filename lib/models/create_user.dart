class UserModel{
  String? name;
  String? email;
  String? phone;
  String? Uid;
  String? bio='write your bio';
  String? profile='https://th.bing.com/th/id/R.e6318ca4519c1c5546b491070be111cc?rik=apULU7ummqgXFA&riu=http%3a%2f%2f1.bp.blogspot.com%2f-su3VzjFcX9U%2fUeNxa-NZoKI%2fAAAAAAAAA4k%2f0m7bmyI4Yro%2fs1600%2fIMG_0191.JPG&ehk=8pmt0Ud4jk%2bf0il%2fIZgnmqe5c53ugcIH4QmqyZv4ry0%3d&risl=&pid=ImgRaw&r=0';
  String? cover='https://th.bing.com/th/id/R.e6318ca4519c1c5546b491070be111cc?rik=apULU7ummqgXFA&riu=http%3a%2f%2f1.bp.blogspot.com%2f-su3VzjFcX9U%2fUeNxa-NZoKI%2fAAAAAAAAA4k%2f0m7bmyI4Yro%2fs1600%2fIMG_0191.JPG&ehk=8pmt0Ud4jk%2bf0il%2fIZgnmqe5c53ugcIH4QmqyZv4ry0%3d&risl=&pid=ImgRaw&r=0';
  bool? isEmailVerified;
  UserModel({this.name,this.email,this.phone,this.Uid,this.isEmailVerified,this.profile,this.cover,this.bio});
  UserModel.fromJson({required Map<String,dynamic>json}){
    name =json['name'];
    email =json['email'];
    phone =json['phone'];
    Uid =json['Uid'];
    bio =json['bio'];
    profile =json['profile'];
    cover =json['cover'];
    isEmailVerified =json['isEmailVerified'];
  }
  Map <String ,dynamic>toMap(){
    return {
      'name':this.name,
      'email':this.email,
      'phone':this.phone,
      'Uid':this.Uid,
      'profile':this.profile,
      'cover':this.cover,
      'bio':this.bio,
      'isEmailVerified':this.isEmailVerified

    };
  }
}