import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/shared/network/local/bloc/social%20states.dart';
import 'package:untitled1/shared/network/local/bloc/social_cubit.dart';
class Verify extends StatelessWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text('News feed',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          ),
          body: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Text('Verify your email adrress',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    Spacer(),
                    TextButton(onPressed: (){
                      SocialCubit.get(context).verification();
                    }, child: Text('send'))

                  ],
                ),
                padding: EdgeInsetsDirectional.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(.6),

                ),
              ),
              Center(
                child: TextButton(
                  onPressed: (){
                    SocialCubit.get(context).checkEmailVer();
                  },
                  child: Text('check your email'),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
