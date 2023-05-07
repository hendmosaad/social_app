import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Modules/lay_out_modules/Post.dart';
import 'package:untitled1/Modules/lay_out_modules/home.dart';
import 'package:untitled1/Modules/lay_out_modules/settings/settings.dart';
import 'package:untitled1/Modules/lay_out_modules/users.dart';
import 'package:untitled1/models/create_post.dart';
import 'package:untitled1/models/create_user.dart';
import 'package:untitled1/models/messege_model.dart';
import 'package:untitled1/shared/component/constatnts.dart';
import 'package:untitled1/shared/network/local/bloc/social%20states.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Modules/lay_out_modules/chats.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(initialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  VideoPlayerController? controller;
  List<Widget> screens = [Home(), Chats(), Post(), Useres(), settings()];

  int currentIndex = 0;

  changenavBar(int x) {
    currentIndex = x;
    emit(ChangeNavBar());
    if (x==1)
      getAllUsres();
    if (x==0)
      getPosts();
  }

  initializeVideo() {
    controller = VideoPlayerController.network(
        "https://vod-progressive.akamaized.net/exp=1681279122~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F2148%2F8%2F210743996%2F722741558.mp4~hmac=1c60192e881ae5795efc28bc8844d8154b837e6d59a2ab360ab4a1bce56a0111/vimeo-prod-skyfire-std-us/01/2148/8/210743996/722741558.mp4")
      ..initialize().then((_) {
        controller!.play();
        controller!.setLooping(true);
      }).catchError((onError) {
        print(onError);
      });
  }

  userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
    String? profile = 'https://th.bing.com/th/id/R.e6318ca4519c1c5546b491070be111cc?rik=apULU7ummqgXFA&riu=http%3a%2f%2f1.bp.blogspot.com%2f-su3VzjFcX9U%2fUeNxa-NZoKI%2fAAAAAAAAA4k%2f0m7bmyI4Yro%2fs1600%2fIMG_0191.JPG&ehk=8pmt0Ud4jk%2bf0il%2fIZgnmqe5c53ugcIH4QmqyZv4ry0%3d&risl=&pid=ImgRaw&r=0',
    String? cover = 'https://th.bing.com/th/id/R.e6318ca4519c1c5546b491070be111cc?rik=apULU7ummqgXFA&riu=http%3a%2f%2f1.bp.blogspot.com%2f-su3VzjFcX9U%2fUeNxa-NZoKI%2fAAAAAAAAA4k%2f0m7bmyI4Yro%2fs1600%2fIMG_0191.JPG&ehk=8pmt0Ud4jk%2bf0il%2fIZgnmqe5c53ugcIH4QmqyZv4ry0%3d&risl=&pid=ImgRaw&r=0',
    String? bio = 'write your bio',
  }) {
    emit(SocialRegisterLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid);
      Uid = value.user!.uid;
      userCreate(
          email: email,
          name: name,
          phone: phone,
          uid: value.user!.uid,
          profile: profile,
          cover: cover,
          bio: bio);
      emit(SocialRegisterSuccess());
    }).catchError((onError) {
      print(onError);
      emit(SocialRegisterError());
    });
  }

  userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialRegisterLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SocialLoginSuccess(value.user!.uid));
    }).catchError((onError) {
      print(onError);
      emit(SocialLoginError());
    });
  }

  userCreate({
      required String email,
      required String name,
      required String phone,
      required String uid,
      String? profile = 'https://th.bing.com/th/id/R.e6318ca4519c1c5546b491070be111cc?rik=apULU7ummqgXFA&riu=http%3a%2f%2f1.bp.blogspot.com%2f-su3VzjFcX9U%2fUeNxa-NZoKI%2fAAAAAAAAA4k%2f0m7bmyI4Yro%2fs1600%2fIMG_0191.JPG&ehk=8pmt0Ud4jk%2bf0il%2fIZgnmqe5c53ugcIH4QmqyZv4ry0%3d&risl=&pid=ImgRaw&r=0',
      String? cover = 'https://th.bing.com/th/id/R.e6318ca4519c1c5546b491070be111cc?rik=apULU7ummqgXFA&riu=http%3a%2f%2f1.bp.blogspot.com%2f-su3VzjFcX9U%2fUeNxa-NZoKI%2fAAAAAAAAA4k%2f0m7bmyI4Yro%2fs1600%2fIMG_0191.JPG&ehk=8pmt0Ud4jk%2bf0il%2fIZgnmqe5c53ugcIH4QmqyZv4ry0%3d&risl=&pid=ImgRaw&r=0',
      String? bio = 'write your bio',
      bool isEmailVerified = false}) {
    UserModel model = UserModel(
        phone: phone,
        Uid: uid,
        name: name,
        email: email,
        isEmailVerified: isEmailVerified,
        profile: profile,
        cover: cover,
        bio: bio);
    emit(SocialCreateUserLoading());
    FirebaseFirestore.instance
        .collection('useres')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccess(Uid));
    }).catchError((onError) {
      print(onError);
      emit(SocialCreateUserError());
    });
  }

  UserModel? model;

  Future <void>? getUserData() {
    emit(SocialGetUserLoading());
    FirebaseFirestore.instance
        .collection('useres')
        .doc(Uid)
        .get()
        .then((value) {
      print(value.data());
      model = UserModel.fromJson(json: value.data()!);
      print(model!.profile);
      emit(SocialGetUserSuccess());
    }).catchError((onError) {
      print(onError);
      emit(SocialGetUserError());
    });
  }

  verification() {
    emit(sendVerificationLoading());
    FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
      emit(sendVerificationSuccss());
    }).catchError((onError) {
      print(onError);
      emit(sendVerificationError());
    });
  }

  checkEmailVer() {
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      emit(verifiedSuccess());
    } else {
      emit(verifiedError());
    }
  }

  File? profile;
  File? cover;
  var ProfilePicker = ImagePicker();
  var CoverPicker = ImagePicker();

  Future<void> profilePicker({
    required String bio,
    required String  phone,
    required String name,
}) async {
    emit(pickProfileLoading());
    var pickedImage = await ProfilePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profile = File(pickedImage!.path);
      emit(pickProfileSuccess());

    } else {
      emit(pickProfileeError());
      print('no image selected');
    }
  }
  Future<void> coverPicker() async {
    emit(pickCoverLoading());
    var pickedCover = await CoverPicker.pickImage(source: ImageSource.gallery);
    if (pickedCover != null) {
      cover = File(pickedCover!.path);
      emit(pickCoverSuccess());

    } else {
      emit(pickCoverError());
      print('no image selected');
    }
  }
  String? profileUrl;
  void uploadProfile({
    required String bio,
    required String  phone,
    required String name,}){
    emit(UploadProfileLoading());
    firebase_storage.FirebaseStorage.instance.ref().child('useres/${Uri.file(profile!.path).pathSegments.last}')
        .putFile(profile!)
        .then((p0) {
          p0.ref.getDownloadURL()
            .then((value) {
              profileUrl=value;
              updateProfile(name: name,phone: phone,bio: bio,profile: value);
        });
    })
        .catchError((onError){
          print(onError);
    });
  }

  String? coverUrl;
  void uploadCover({
    required String bio,
    required String  phone,
    required String name,}){
    emit(UploadCoverLoading());
    firebase_storage.FirebaseStorage.instance.ref().child('useres/covers/${Uri.file(cover!.path).pathSegments.last}')
        .putFile(cover!)
        .then((p0) {

      p0.ref.getDownloadURL()
          .then((value) {
        coverUrl=value;
        updateProfile(name: name,phone: phone,bio: bio,cover: value);

      });
    })
        .catchError((onError){
      print(onError);
    });
  }


  void updateProfile({

   required String  phone,
   required String name,
    String ? email,
    String ? profile,
    String ? cover,
   required String bio,
  }){
    UserModel userModel = UserModel(
          phone: phone,
          Uid: Uid,
          name: name,
          email: model!.email,
          isEmailVerified: false,
          profile:profile?? model!.profile ,
          cover: cover??model!.cover,
          bio: bio);
      FirebaseFirestore.instance.collection('useres')
          .doc(Uid).update(userModel!.toMap())
          .then((value) {
            getUserData();

      })
          .catchError((onError){
            emit(updateUserDataError());
            print(onError);
                         });

   }
  void createPost({
    required String text,
    required String dateTime,
     String? postImage
   })
  {
    emit(CeatePostLoading());
    CreatePost postmodel=CreatePost(
        name:model!.name ,uid:model!.Uid ,image:model!.profile ,dateTime:dateTime ,text:text,postImage: postImage);
    FirebaseFirestore.instance.collection('posts')
        .add(postmodel.toMap()).
        then((value) {
      getPosts();
          emit(CeatePostSuccess());
    }).
        catchError((onError){
          print(onError);
          emit(CeatePostError());
           });
    }
  void uploadPostImage({
    required String text,
    required String dateTime,

    }){
    emit(UploadPostLoading());
    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(post!.path).pathSegments.last}')
        .putFile(post!)
        .then((p0) {

      p0.ref.getDownloadURL()
          .then((value) {
       emit(UploadPostSuccess());
         createPost(text: text, dateTime: dateTime,postImage: value);

      }).catchError((onError){
        print(onError);
        emit(UploadPostError());
      });
    })
        .catchError((onError){

      print(onError);
      emit(UploadPostError());
    });
  }
  File? post;
  var PostPicker = ImagePicker();
  Future<void> postImagePick() async {
    emit(PostPickerLoading());
    var pickedCover = await PostPicker.pickImage(source: ImageSource.gallery);
    if (pickedCover != null) {
      post = File(pickedCover!.path);
      emit(PostPickerSuccess());

    } else {
      emit(PostPickerError());
      print('no image selected');
    }
  }
  void removePostImage(){
    post = null;
    emit(removePostSuccess());
  }
  List <CreatePost> postItem=[];
  List <String> postId=[];
  List <int> likes=[];
  List <String> comments=[];
  List <UserModel> useres=[];
  Map<String ,int> commentsNumber={};

  void getPosts(){
    postItem=[];
    emit(SocialGetPostsLoading());
    FirebaseFirestore.instance.collection('posts').get()
        .then((value)
              {
                value.docs.forEach((element) {
                  element.reference.collection('likes')
                      .get().
                  then((value) {
                    likes.add(value.docs.length);
                    postId.add(element.id);
                    postItem.add(CreatePost.fromJson(json: element.data()));
                    emit(SocialGetPostsSuccess());
                  });
                    });
                        emit(SocialGetPostsSuccess());
                     }).catchError(
                         (onError){
                           emit(SocialGetPostsError());
                         });}
  void getComments(){
    FirebaseFirestore.instance
        .collection('posts')
        .get()
       .then((value) {
        value.docs.forEach((element) {
        element.reference
            .collection('comments')
            .get()
            .then((value) {
              commentsNumber.addAll({element.id:value.docs.length});
              emit(SocialgetCommentSuccess());
                 });});
            // value.reference
         //     .collection('comments')
         //     .get()
         //     .then((value) {
         //       value.docs.forEach((element) {
         //         comments.add(element['comment']);
         //         emit(SocialgetCommentSuccess());
         //       });
         // });
        print(commentsNumber);
        emit(SocialgetCommentSuccess());
             })
        .catchError((onError){
          emit(SocialgetCommentError());
           print(onError);
    });
  }
  void getTextComments(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            comments.add(element['comment']);
            emit(getTextCommensSuccess());
          });
         print(comments);
          emit(getTextCommensSuccess());
              })
        .catchError((onError){
                print(onError);
                emit(getTextCommensError());
                 });}
  void postLikes(String postId){
    FirebaseFirestore.instance.collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.Uid)
        .set({'like':true})
        .then((value) {
            getPosts();
          emit(SocialLikePostSuccess());
    })
        .catchError((onError){
          emit(SocialLikePostError());
    });
  }
  void postComments({required String postId, String? text}){
   if (text !=null) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .add({'comment':text})
          .then((value) {

        emit(SocialCommentPostsSuccess());
        getComments();
      }).catchError((onError) {
        emit(SocialCommentPostsError());
      });
    }
   else{

   }
  }
  void getAllUsres(){
    useres=[];
    emit(getAllUseresLoading());
    FirebaseFirestore.instance.collection('useres').get()
        .then((value){
          value.docs.forEach((element) {
            if (element.data()['Uid'] != model!.Uid)
              useres.add(UserModel.fromJson(json: element.data()));
          });
          emit(getAllUseresSuccess());
    } )
        .catchError((onError){
          emit(getAllUseresError());
    });

  }
  void sendMessege({required String recieverId,required String text,required String date}){
    emit(SendMessgesLoading());
    MessegeModel messegeModel=MessegeModel(text: text,senderId: model!.Uid,date: date,recieverId: recieverId);
    FirebaseFirestore.instance.collection('useres')
        .doc(model!.Uid)
        .collection('chats')
        .doc(recieverId)
        .collection('messeges')

        .add(messegeModel.toMap())
        .then((value) {
          emit(SendMessgesSucces());
    })
        .catchError(
            (onError){
              print(onError);
              emit(SendMessgesError());
            });

  FirebaseFirestore.instance.collection('useres')
      .doc(recieverId)
      .collection('chats')
      .doc(model!.Uid)
      .collection('messeges')
      .add(messegeModel.toMap())
      .then((value) {
  emit(SendMessgesSucces());
  })
      .catchError(
  (onError){
  print(onError);
  emit(SendMessgesError());
  });
}
  List <MessegeModel> Messeges=[];
  TextEditingController textController=TextEditingController();
  void getMesseges({required String recieverId})
    {
      FirebaseFirestore.instance.collection('useres')
          .doc(model!.Uid)
          .collection('chats')
          .doc(recieverId)
           .collection('messeges')
          .orderBy('date')
          .snapshots()
          .listen((event) {
          Messeges=[];
            event.docs.forEach((element) {

              Messeges.add(MessegeModel.fromJson(json: element.data()));
            });

           emit(getMessgesSucces());
      });


    }

}

