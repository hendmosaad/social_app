import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Modules/lay_out_modules/chat_details.dart';
import 'package:untitled1/models/create_user.dart';
import 'package:untitled1/shared/component/Widget.dart';
import 'package:untitled1/shared/network/local/bloc/social%20states.dart';
import 'package:untitled1/shared/network/local/bloc/social_cubit.dart';
class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                titleSpacing: 40,
                backgroundColor: Colors.white,
                title:Text( 'chats',style: TextStyle(color: Colors.black),),
              ),
              body: ConditionalBuilder(
                builder: (context)=>ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>buildChatItem(model: SocialCubit.get(context).useres[index],context: context),
                    separatorBuilder: (context,index)=>divider(),
                    itemCount:SocialCubit.get(context).useres.length),
                condition: SocialCubit.get(context).useres.length>0,
                fallback:  (context)=>CircularProgressIndicator(),
              ),
            ),
          );
        }
    );
  }
  Widget buildChatItem({required UserModel model,context})=>
      Padding(
        padding: const EdgeInsets.all(15),
        child: InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=> ChatDetails(userChatModel: model,)));
          },
          child: Row(
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundImage:
                  NetworkImage('${model.profile}')),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text('${model.name}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),),
                      SizedBox(width: 5,),
                      CircleAvatar(
                        radius:7,
                        backgroundColor: Colors.blue,
                        child: Center(child: Icon(Icons.done,size: 7,)),
                      )
                    ],
                  ),

                ],
              ),

            ],
          ),
        ),
      );
}
