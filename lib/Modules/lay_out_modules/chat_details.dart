import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/create_user.dart';
import 'package:untitled1/models/messege_model.dart';
import 'package:untitled1/shared/component/Widget.dart';
import 'package:untitled1/shared/network/local/bloc/social%20states.dart';
import 'package:untitled1/shared/network/local/bloc/social_cubit.dart';
class ChatDetails extends StatelessWidget {

     UserModel? userChatModel;

   ChatDetails({this.userChatModel});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
     listener: (context,state){
       if (state is SendMessgesSucces)
         SocialCubit.get(context).textController.text='';
     },
     builder: (context,state){

       return Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.white,
           elevation: 0.0,
           leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,) ,onPressed: (){
             Navigator.pop(context);
           }),
           title:Row(
             children: [
               CircleAvatar(
                 backgroundImage: NetworkImage('${userChatModel!.profile}'),
               ),
               SizedBox(width: 15,),
               Text('${userChatModel!.name}',style: TextStyle(color: Colors.black,fontSize: 18))
             ],
           ),
         ),
         body:Padding(
           padding: const EdgeInsets.all(10),
           child: Column(
             children: [
              Builder(
                builder: (BuildContext context){
                  SocialCubit.get(context).getMesseges(recieverId: userChatModel!.Uid!);
                 return ConditionalBuilder(
                    condition: SocialCubit.get(context).Messeges.length >0,
                    builder: (context)=> Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index){
                            var messges=SocialCubit.get(context).Messeges[index];
                            if(SocialCubit.get(context).model!.Uid != messges.senderId) {
                              return buildMessges(
                                  messges);
                            } else{
                              return buildMyMessges(messges);
                            }
                          },
                          separatorBuilder:(context,index)=> SizedBox(height: 10,),
                          itemCount: SocialCubit.get(context).Messeges.length),
                    ),
                    fallback: (context)=>Text('no cmments'));},

              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                   padding: const EdgeInsets.all(15),
                   child: Container(
                     height: 50,
                     child: TextFormField(

                      keyboardType:TextInputType.text ,
                       controller: SocialCubit.get(context).textController ,
                       decoration: InputDecoration(
                           suffixIcon: Container(
                             clipBehavior: Clip.antiAlias,
                             decoration: BoxDecoration(
                                 color: Colors.blueGrey,
                                 borderRadius: BorderRadiusDirectional
                                     .only(topEnd: Radius.circular(15),bottomEnd: Radius.circular(15))
                             ),
                             height: 50,
                             width: 45,

                             child: Center(
                               child: IconButton(
                                 icon: Icon(Icons.send,color: Colors.white)
                                 ,onPressed: (){

                                 SocialCubit.get(context).sendMessege(
                                     recieverId:userChatModel!.Uid!
                                     ,date:DateTime.now().toLocal().toString()
                                     ,text: SocialCubit.get(context).textController.text );

                               },),
                             ),
                           ),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(15)
                           )

                       ),
                     ),
                   ),
                 ),
              ),

             ],
           ),
         )
       );
     },
      );}


  Widget buildMyMessges(MessegeModel model)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            borderRadius: BorderRadiusDirectional.only(
                topEnd:Radius.circular(30) ,
                topStart: Radius.circular(30),
                bottomStart: Radius.circular(30)
            )
        ),
        child: Text('${model.text}'),
      ),
    ),
  );
  Widget buildMessges(MessegeModel model)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            borderRadius: BorderRadiusDirectional.only(
                topEnd:Radius.circular(30) ,
                topStart: Radius.circular(30),
                bottomStart: Radius.circular(30)
            )
        ),
        child: Text('${model.text}'),
      ),
    ),
  );

}
