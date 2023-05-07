import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/create_post.dart';
import 'package:untitled1/models/create_user.dart';
import 'package:untitled1/shared/network/local/bloc/social%20states.dart';
import 'package:untitled1/shared/network/local/bloc/social_cubit.dart';
class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){

          List <TextEditingController> controllers=
          List.generate(SocialCubit.get(context).postItem.length, (index) => TextEditingController());
          return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text('Home',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.notifications_active_outlined,color: Colors.black,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline_outlined,color: Colors.black,)),
            ],
          ),
              body: ConditionalBuilder(
                fallback: (context)=>Center(child: CircularProgressIndicator()) ,
                 condition: SocialCubit.get(context).model !=null  ,
                builder: (context)=>ListView.separated(
                    itemBuilder: (context,index)=>postItem(
                      SocialCubit.get(context).postItem[index],
                      context,
                      SocialCubit.get(context).postId[index],

                        SocialCubit.get(context).likes[index],
                      controllers[index],
                        SocialCubit.get(context).model!

                    )
                    ,
                    separatorBuilder: (context,index)=>Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[200],
                    ),

                    itemCount: SocialCubit.get(context).postItem.length),
              )


              
            ,
          );
        }
    );
  }
  Widget postItem(CreatePost postModel ,context,String postId,int likes,TextEditingController commentController,UserModel userModel)=>
      Padding(
          padding: const EdgeInsets.all(10),
          child: Container(

            child:
            Column(children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 20,
                      backgroundImage:
                      NetworkImage('${userModel.profile}')),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${postModel.name}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(width: 5,),
                          CircleAvatar(
                            radius:7,
                            backgroundColor: Colors.blue,
                            child: Center(child: Icon(Icons.done,size: 7,)),
                          )
                        ],
                      ),
                      Text('${postModel.dateTime}',style: TextStyle(color: Colors.grey,fontSize: 16),),
                    ],
                  ),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.settings_input_component_outlined,size: 18,)),
                  SizedBox(width: 15),

                ],
              ),
              SizedBox(height: 20,),
              Text('${postModel.text}',
                maxLines: 4,
                overflow:TextOverflow.ellipsis ,
              ),
              SizedBox(height: 10,),
              if(postModel.postImage != null)
                Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Image(
                  fit: BoxFit.cover,
                  image:NetworkImage('${postModel.postImage}'),
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    IconButton(icon:Icon(Icons.favorite_border_outlined)
                      ,color: Colors.red,onPressed: (){
                      SocialCubit.get(context).postLikes(postId);
                      },),

                    Text('${likes}'),
                    Spacer(),
                    IconButton(
                      icon:Icon(Icons.insert_comment_rounded,color: Colors.grey,)
                      ,onPressed: (){
                       print( SocialCubit.get(context).commentsNumber['${postId}']);
                    },),

                     Text('${SocialCubit.get(context).commentsNumber['${postId}'] != null ? SocialCubit.get(context).commentsNumber['${postId}'] : 0 }'),


                  ],
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),

                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[200],
                ),
              ),
              Row(
                children: [
                     CircleAvatar(
                      radius: 20,
                      backgroundImage:
                      NetworkImage('${postModel.image}')),
                    SizedBox(width: 20,),
                    Expanded(
                    child: TextFormField(
                      controller: commentController,
                      decoration: InputDecoration(
                          hintText:'write comment....',
                          border: InputBorder.none

                      ),
                    ),
                  ),
                    IconButton(onPressed: (){
                      SocialCubit.get(context).postComments(postId: postId, text: commentController.text);
                    }, icon: Icon(Icons.send,color: Colors.blueGrey,))
                    // ListView.separated(
                    //   itemBuilder:(context,index)=>Expanded(
                    //     child: TextFormField(
                    //       decoration: InputDecoration(
                    //
                    //           labelText:'write comment....',
                    //           border: InputBorder.none
                    //
                    //       ),
                    //     ),
                    //   ),
                    //     separatorBuilder: (context,index)=>Padding(
                    //       padding: EdgeInsetsDirectional.only(start: 20,end: 20),
                    //       child: Container(height: 1,width: double.infinity,color:Colors.grey,), ),
                    //   itemCount:10),
                  // Row(
                  //   children: [
                  //     Icon(Icons.favorite_border_outlined,color: Colors.red,size: 15,),
                  //     SizedBox(
                  //       width:5,
                  //     ),
                  //     Text('Likes'),
                  //     SizedBox(
                  //       width:15,
                  //     ),
                  //     Icon(Icons.share,color: Colors.red,size: 15,),
                  //     SizedBox(
                  //       width:5,
                  //     ),
                  //     Text('share'),
                  //   ],
                  // )
                ],
              )
            ],),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 10,
                      blurRadius:100
                  )
                ]
            ),
          ));
}
