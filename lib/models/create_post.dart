class CreatePost{
  String? name;
  String? uid;
  String? dateTime;
  String? image;
  String? postImage;
  String? text;

  CreatePost({this.name,this.uid,this.dateTime,this.postImage,this.image,this.text});
  CreatePost.fromJson({required Map<String,dynamic>json}){
    name =json['name'];
    dateTime=json['dateTime'];
    image=json['image'];
    postImage=json['postImage'];
    uid =json['uid'];
    text =json['text'];


  }
  Map <String ,dynamic>toMap(){
    return {
      'name':this.name,
      'uid':this.uid,
      'image':this.image,
      'postImage':this.postImage,
      'dateTime':this.dateTime,
      'text':this.text
       };
  }
}