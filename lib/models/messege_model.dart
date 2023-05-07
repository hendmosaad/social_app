import 'package:cloud_firestore/cloud_firestore.dart';

class MessegeModel{
  String? senderId;
  String? recieverId;
  String? date;
  String? text;


  MessegeModel({this.senderId,this.recieverId,this.date,this.text});
  MessegeModel.fromJson({required Map<String,dynamic>json}){
    senderId =json['senderId'];
    date=json['date'];
    recieverId=json['recieverId'];
    text =json['text'];


  }
  Map <String ,dynamic>toMap(){
    return {
      'senderId':this.senderId,
      'date':this.date,
      'recieverId':this.recieverId,
      'text':this.text
    };
  }

}