import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/shared/network/local/bloc/social%20states.dart';
import 'package:untitled1/shared/network/local/bloc/social_cubit.dart';
class Tring extends StatelessWidget {
  const Tring({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<SocialCubit,SocialStates>(
     listener: (context,state){},
     builder: (context,state){
       return Scaffold(
         body: Center(
           child: IconButton(onPressed: (){
              SocialCubit.get(context).userRegister(email: 'hend1@gmail.com', password: 'password', phone:' 014725836,', name: 'hend mosaad');
           }, icon: Icon(Icons.add)),
         ),
       );
     },
   );
  }
}
