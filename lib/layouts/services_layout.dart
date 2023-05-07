import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/shared/network/local/bloc/social%20states.dart';
import 'package:untitled1/shared/network/local/bloc/social_cubit.dart';
class SocialLayOut extends StatelessWidget {
  const SocialLayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context ,state){},
      builder: (context ,state){
        return Scaffold(
          body: SocialCubit.get(context).screens[ SocialCubit.get(context).currentIndex!],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat),label: 'chats'),
              BottomNavigationBarItem(icon: Icon(Icons.upload),label: 'post'),
              BottomNavigationBarItem(icon: Icon(Icons.people),label: 'useres'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'settings'),
            ],
            selectedItemColor: Colors.grey,
            unselectedItemColor: Colors.black45,
            currentIndex:SocialCubit.get(context).currentIndex! ,
            onTap: (int index){
              SocialCubit.get(context).changenavBar(index);
            },
          ),

        );
      },
    );
  }
}
