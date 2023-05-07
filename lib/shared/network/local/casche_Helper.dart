import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper{
 static SharedPreferences? shardPrefrences;
 static initShared()async{
    shardPrefrences=await SharedPreferences.getInstance();
  }
 static Future<bool> setData({
   required String key,
   required dynamic value,
 })async{
   if(value is String ) {
     return await shardPrefrences!.setString(key, value);
   }else if(value is bool ) {
     return await shardPrefrences!.setBool(key, value);
   }else if(value is int ) {
     return await shardPrefrences!.setInt(key, value);
   }
   else{
     return await shardPrefrences!.setDouble(key, value);
   }
 }

 static  getData({
   required String key,
 }){
   return  shardPrefrences?.get(key);
 }
 static  deleteData({
   required String key,
 }){
   return  shardPrefrences?.remove(key);
 }

}