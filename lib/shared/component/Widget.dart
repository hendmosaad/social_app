import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultField({required TextEditingController controller,Widget? suffixIcon
  ,Widget? preIcon,required FormFieldValidator validator,required String label})=>
    TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          prefixIcon:preIcon,
          suffixIcon: suffixIcon,
          labelText:label ,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black45
              )
          )
      ),
    );



Widget defaultButton({required Color color,required double width,required String text,required GestureTapCallback function}){
  return GestureDetector(
    onTap: function,
    child: Container(
      height: 45,
    width:width ,
    child: Center(
      child: Text('${text}',style: TextStyle(fontSize: 20,color: Colors.white),),
    ),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: color
    ),
    ),
  );
}
Widget divider()=>
    Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal:20 ),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey,
      ),
    );