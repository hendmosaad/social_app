import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Modules/login_screen.dart';
import 'package:untitled1/layouts/services_layout.dart';
import 'package:untitled1/shared/component/constatnts.dart';
import 'package:untitled1/shared/network/local/bloc/bloc_observer.dart';
import 'package:untitled1/shared/network/local/bloc/social%20states.dart';
import 'package:untitled1/shared/network/local/bloc/social_cubit.dart';
import 'package:untitled1/shared/network/local/casche_Helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.initShared();
 Uid=await CacheHelper.getData(key: 'Uid');

 print(Uid);
  Widget? startWidget;
  if (Uid ==null){
    startWidget=LoginScreen();
  }else if(Uid !=null){
    startWidget=SocialLayOut();
  }

  runApp( MyApp( statrtWidget: startWidget,));
}

class MyApp extends StatelessWidget {
  Widget? statrtWidget;
  MyApp({required this.statrtWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return BlocProvider(
     create: (contxet)=>SocialCubit()..getUserData()..getPosts()..getComments()..getAllUsres(),
     child: BlocConsumer<SocialCubit,SocialStates> (
       listener: (context,state){},
       builder: (context,state){
       return  MaterialApp(
           debugShowCheckedModeBanner: false,
           title: 'Flutter Demo',
           theme: ThemeData(
             primarySwatch: Colors.blue,
           ),
           home:statrtWidget,
         );
       },
     ),);
  }
}

