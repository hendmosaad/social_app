import 'dart:ui';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled1/Modules/register_screen.dart';
import 'package:untitled1/layouts/services_layout.dart';
import 'package:untitled1/shared/component/constatnts.dart';
import 'package:untitled1/shared/network/local/bloc/social%20states.dart';
import 'package:untitled1/shared/network/local/bloc/social_cubit.dart';
import 'package:untitled1/shared/network/local/casche_Helper.dart';
import 'package:video_player/video_player.dart';
class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  PageController pagecontroller=PageController();
  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  var loginKey=GlobalKey<FormState>();
  var registerKey=GlobalKey<FormState>();

  @override

  @override
  Widget build(BuildContext context) {
  return BlocConsumer<SocialCubit,SocialStates>(
     listener: (context,states){
       if(states is SocialLoginSuccess){
        CacheHelper.setData(key: 'Uid', value: states.Uid)
            .then((value) {
          Uid=CacheHelper.getData(key: 'Uid');
          SocialCubit.get(context).getUserData();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SocialLayOut()));
        });
       }
     },
     builder: (context,states){
       var cubit =SocialCubit.get(context);

       return SafeArea(
         child: Scaffold(
           body:  Container(
             decoration:BoxDecoration(
                 color: Colors.grey[300]!.withOpacity(.3),

                 borderRadius: BorderRadius.circular(10)
             ) ,
             child: Padding(
               padding: const EdgeInsetsDirectional.only(top: 50,start: 20,end: 20,bottom: 30),
               child: Center(
                 child: SingleChildScrollView(
                   child: Form(
                     key: loginKey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'Login ',style: Theme.of(context).textTheme.headlineLarge,
                         ),
                         SizedBox(height: 20,),
                         Text(
                           'Login now to contatct with your friends',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey[800]),
                         ),
                         SizedBox(height: 20,),
                         TextFormField(
                           controller: emailController,
                           validator: (value){
                             if(value!.isEmpty){
                               return 'enter data';
                             }
                           },
                           decoration: InputDecoration(
                               prefixIcon:Icon( Icons.email_outlined),
                               border: OutlineInputBorder(
                                   borderSide: BorderSide(
                                       color: Colors.black45
                                   )
                               )
                           ),
                         ),
                         SizedBox(height: 20,),
                         TextFormField(
                           validator: (value){
                             if(value!.isEmpty){
                               return 'enter data';
                             }
                           },
                           controller: passwordController,
                           decoration: InputDecoration(
                               prefixIcon:Icon( Icons.password_sharp),
                               suffixIcon: Icon( Icons.remove_red_eye),
                               border: OutlineInputBorder(
                                   borderSide: BorderSide(
                                       color: Colors.black45
                                   )
                               )
                           ),
                         ),
                         SizedBox(height: 20,),
                         MaterialButton(
                           onPressed: (){
                            if(loginKey.currentState!.validate()){
                              cubit.userLogin(email: emailController.text, password: passwordController.text);
                            }
                           },child:
                         Align(
                           alignment: Alignment.bottomCenter,
                           child: Container(
                             height: 40,
                             width: 250,
                             decoration: BoxDecoration(
                                 color: Colors.amber[300],
                                 borderRadius: BorderRadius.circular(10)
                             ),
                             child: Center(child: Text('LOGIN',style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),)),
                           ),
                         ),

                         ),
                         SizedBox(height: 20,),
                         Align(
                             alignment: Alignment.bottomCenter,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text('or register now'),
                                 TextButton(onPressed: (){
                                   Navigator.push(context,MaterialPageRoute(builder: (contect)=>RegisterScreen()));
                                 }, child: Text('REGISTER',style: TextStyle(color: Colors.amber),))
                               ],
                             ))

                       ],
                     ),
                   ),
                 ),
               ),
             ),
           ),
           //FU ,


         ),
       );
     },
   );
  }



}
