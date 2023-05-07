
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Modules/lay_out_modules/settings/edit_profile.dart';
import 'package:untitled1/shared/network/local/bloc/social%20states.dart';
import 'package:untitled1/shared/network/local/bloc/social_cubit.dart';
class settings extends StatelessWidget {
  const settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<SocialCubit,SocialStates>(
       listener: (context,state){},
       builder: (context,state){
         SocialCubit cubit =SocialCubit.get(context);
         var model =cubit.model;
     return Scaffold(
       appBar: AppBar(
           backgroundColor: Colors.white,
           elevation: 0.0,
           title: Text('settings',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),),
       body: Padding(
         padding: EdgeInsetsDirectional.all(8.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           mainAxisSize: MainAxisSize.min,
           children: [
             Container(
               height: 230,
               child: Stack(
                 children: [
                   Container(
                     clipBehavior: Clip.antiAlias,
                     height: 170,
                     width: double.infinity,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10)
                     ),
                     child: Image(
                       image:
                       cubit.cover == null ?  NetworkImage('${model!.cover}') :FileImage(cubit.cover!)as ImageProvider
                               ,
                       fit: BoxFit.cover,
                     ),
                   ),
                   Align(
                     alignment: Alignment.bottomCenter,
                     child: Stack(
                       alignment: Alignment.center,
                       children: [
                         CircleAvatar(
                           radius: 62,
                           backgroundColor: Colors.blue,
                         ),
                         CircleAvatar(
                             radius: 60,
                             backgroundImage: cubit.profile == null ?  NetworkImage('${model!.profile}') : FileImage(cubit.profile!)as ImageProvider ),
                       ],
                     ),
                   )
                 ],
               ),
             ),
             SizedBox(
               height: 20,
             ),
             Text(
               '${model!.name}',
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 22,
                 fontWeight: FontWeight.bold
               ),
             ),
             SizedBox(
               height:10,
             ),
             Text(
               '${model.bio}',
               style:Theme.of(context).textTheme.caption,
             ),
             Container(
               height: 90,
               child: Padding(
                 padding: EdgeInsets.symmetric(vertical: 15),
                 child: InkWell(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Expanded(
                         child: GestureDetector(
                           child: Column(
                             children: [
                               Text(
                                 '1000',
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontSize: 16,

                                 ),
                               ),
                               SizedBox(
                                 height:10,
                               ),
                               Text(
                                 'posts',
                                 style:Theme.of(context).textTheme.bodySmall,
                               ),
                             ],
                           ),
                         ),
                       ),
                       Expanded(
                         child: GestureDetector(
                           child: Column(
                             children: [
                               Text(
                                 '1000',
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontSize: 16,

                                 ),
                               ),
                               SizedBox(
                                 height:10,
                               ),
                               Text(
                                 'posts',
                                 style:Theme.of(context).textTheme.bodySmall,
                               ),
                             ],
                           ),
                         ),
                       ),
                       Expanded(
                         child: GestureDetector(
                           child: Column(
                             children: [
                               Text(
                                 '1000',
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontSize: 16,

                                 ),
                               ),
                               SizedBox(
                                 height:10,
                               ),
                               Text(
                                 'friends',
                                 style:Theme.of(context).textTheme.bodySmall,
                               ),
                             ],
                           ),
                         ),
                       ),
                       Expanded(
                         child: GestureDetector(
                           child: Column(
                             children: [
                               Text(
                                 '503',
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontSize: 16,

                                 ),
                               ),
                               SizedBox(
                                 height:10,
                               ),
                               Text(
                                 'following',
                                 style:Theme.of(context).textTheme.bodySmall,
                               ),
                             ],
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
             ),
             SizedBox(height: 5,),
             Row(
               children: [
                 Expanded(
                   flex: 4,
                   child: Padding(
                     padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                     child: OutlinedButton(onPressed: (){},
                       child: Container(

                         child: Center(
                           child: Text('Edit your Profile',style: TextStyle(color: Colors.blue,fontSize: 18),),
                         ),
                         height: 50,
                          decoration: BoxDecoration(

                             borderRadius: BorderRadius.circular(10)
                         ),
                       ),),
                   ),
                 ),
                 Expanded(
                   flex: 1,
                   child: Padding(
                     padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                     child: OutlinedButton(onPressed: (){},
                       child: Container(

                         child: Center(
                           child:IconButton(onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
                           },icon: Icon(Icons.edit,size: 15,),),
                         ),
                         height: 50,
                         decoration: BoxDecoration(

                             borderRadius: BorderRadius.circular(10)
                         ),
                       ),),
                   ),
                 ),
               ],
             )
           ],
         ),
       ),
     );
   }
   );
  }
}
