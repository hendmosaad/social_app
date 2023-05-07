import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Modules/verify.dart';
import 'package:untitled1/layouts/services_layout.dart';
import 'package:untitled1/shared/network/local/bloc/social%20states.dart';
import 'package:untitled1/shared/network/local/bloc/social_cubit.dart';

import '../shared/network/local/casche_Helper.dart';
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
    var formkey =GlobalKey<FormState>();
  TextEditingController passwordControllerR=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailControllerR=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,states)async{
        if(states is SocialCreateUserSuccess){
       await   SocialCubit.get(context).getUserData();
          CacheHelper.setData(key: 'Uid', value: states.Uid).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SocialLayOut()));
        print(CacheHelper.getData(key: 'Uid'));
        });
        }
      },
      builder: (context,states){
        var cubit=SocialCubit.get(context);
        return Scaffold(
          body: Container(

            decoration:BoxDecoration(
                color: Colors.grey[300]!.withOpacity(.3),

                borderRadius: BorderRadius.circular(10)
            ) ,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(top: 50,start: 20,end: 20,bottom: 30),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register ',style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Register now to contatct with your friends',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey[800]),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty) {
                            return  'this Field mustnot be  empty';
                            };
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                              labelText:'name',
                              prefixIcon:Icon( Icons.drive_file_rename_outline),

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
                            if(value!.isEmpty) {
                              {
                                return   'this Field mustnot be  empty';
                              }
                            };
                          },
                          controller: emailControllerR,
                          decoration: InputDecoration(
                              labelText:'email',
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
                              return 'this Field mustnot be  empty''this Field mustnot be  empty';
                            };
                          },
                          controller: passwordControllerR,
                          decoration: InputDecoration(
                              labelText:'password',
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
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'this Field mustnot be  empty''this Field mustnot be  empty';
                            };
                          },
                          controller: phoneController,
                          decoration: InputDecoration(
                              labelText:'phone',
                              prefixIcon:Icon( Icons.phone),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black45
                                  )
                              )
                          ),
                        ),
                        SizedBox(height: 20,),
                        MaterialButton(onPressed: (){
                          if (formkey.currentState!.validate()) {
                            cubit.userRegister(email: emailControllerR.text,name: nameController.text,password: passwordControllerR.text,phone: phoneController.text);
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
                            child: Center(child: Text('REGISTER',style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),)),
                          ),
                        ),)

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ) ;
  }
}
