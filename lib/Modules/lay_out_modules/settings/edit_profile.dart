import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/shared/component/Widget.dart';
import 'package:untitled1/shared/component/constatnts.dart';
import 'package:untitled1/shared/network/local/bloc/social%20states.dart';
import 'package:untitled1/shared/network/local/bloc/social_cubit.dart';
class EditProfile extends StatelessWidget {
   EditProfile({Key? key}) : super(key: key);
 TextEditingController nameContrller=TextEditingController();
 TextEditingController bioController=TextEditingController();
 TextEditingController phoneController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          var model =SocialCubit.get(context).model;
          var cubit =SocialCubit.get(context);
          nameContrller.text=model!.name!;
          phoneController.text=model!.phone!;
          bioController.text=model!.bio!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
              ),
              title: Text('Edit your profile',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              actions: [
                TextButton(onPressed: (){
                  if(formKey.currentState!.validate()){
                    cubit.updateProfile(bio: bioController.text,phone: phoneController.text,name: nameContrller.text );
                  }

                }, child: Text('Update',style: TextStyle(color: Colors.blue,fontSize: 19,fontWeight: FontWeight.bold),))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: 230,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 170,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Image(
                              image: cubit.cover == null ?  NetworkImage('${model!.cover}') :FileImage(cubit.cover!)as ImageProvider,
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
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                        radius: 60,
                                        backgroundImage:cubit.profile == null ?  NetworkImage('${model!.profile}') :FileImage(cubit.profile!)as ImageProvider
                                        ),
                                    IconButton(onPressed: (){
                                      cubit.profilePicker(phone: phoneController.text,bio: bioController.text,name:nameContrller.text);
                                    }, icon: Icon(Icons.camera_alt_outlined))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(onPressed: (){
                            cubit.coverPicker();
                          }, icon: Icon(Icons.camera_alt_outlined))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                   if(cubit.profile != null || cubit.cover !=null)
                     Row(
                       children: [
                         if(cubit.profile != null)
                           Expanded(
                             child: Column(
                             children: [
                               defaultButton(color: Colors.blueGrey[700]!,width: double.infinity,text: 'upload profile',
                                   function: (){
                                   cubit.  uploadProfile(name: nameContrller.text,bio: bioController.text,phone: phoneController.text);
                                   }),
                               SizedBox(height: 15,),
                               if (state is UploadProfileLoading)
                                 LinearProgressIndicator(),
                               SizedBox(height: 15,),

                             ],
                         ),
                           ),

                           SizedBox(width: 15,),


                          if(cubit.cover != null)
                           Expanded(
                             child: Column(
                               children: [
                                 defaultButton(color: Colors.blueGrey[700]!,width: double.infinity,text: 'upload cover',function:(){
                                 cubit.uploadCover(name: nameContrller.text,bio: bioController.text,phone: phoneController.text,);
                                     }),
                                 SizedBox(height: 15,),
                                 if (state is UploadCoverLoading)
                                  LinearProgressIndicator(),
                                 SizedBox(height: 15,),
                               ],
                             ),
                           ),

                       ],
                     ),

                   defaultField(
                     preIcon: Icon(Icons.email_outlined),
                       controller: nameContrller, validator: (value){
                       if(value.toString().isEmpty)
                       return 'this field mustn\'t be empty';}
                       , label: 'name'),
                    SizedBox(
                      height: 20,
                    ),
                    defaultField(
                      preIcon: Icon(Icons.data_usage_rounded),
                        controller: bioController, validator: (value){
                      if(value.toString().isEmpty)
                      return 'this field mustn\'t be empty';}
                        , label: 'bio'),
                    SizedBox(
                      height: 20,
                    ),
                    defaultField(
                        preIcon: Icon(Icons.phone),
                        controller: phoneController,
                        validator: (value){
                      if(value.toString().isEmpty)
                      return 'this field mustn\'t be empty';},
                        label: 'phone')
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
