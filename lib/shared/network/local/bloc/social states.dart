abstract class SocialStates{}
class initialState extends SocialStates{}
class SocialRegisterSuccess extends SocialStates{}
class SocialRegisterError extends SocialStates{}
class SocialRegisterLoading extends SocialStates{}
class SocialLoginSuccess extends SocialStates{
  var Uid;
  SocialLoginSuccess(this.Uid);
}
class SocialLoginError extends SocialStates{}
class SocialLoginLoading extends SocialStates{}
class ChangeNavBar extends SocialStates{}
class SocialCreateUserSuccess extends SocialStates{
  var Uid;
  SocialCreateUserSuccess(this.Uid);
}
class SocialCreateUserError extends SocialStates{}
class SocialCreateUserLoading extends SocialStates{}
class SocialGetUserError extends SocialStates{}
class SocialGetUserLoading extends SocialStates{}
class SocialGetUserSuccess extends SocialStates{}
class sendVerificationSuccss extends SocialStates{}
class sendVerificationError extends SocialStates{}
class sendVerificationLoading extends SocialStates{}
class verifiedSuccess extends SocialStates{}
class verifiedError extends SocialStates{}
class pickProfileLoading extends SocialStates{}
class pickProfileSuccess extends SocialStates{}
class pickProfileeError extends SocialStates{}
class pickCoverLoading extends SocialStates{}
class pickCoverSuccess extends SocialStates{}
class pickCoverError extends SocialStates{}
class UploadProfileLoading extends SocialStates{}
class UploadProfileSuccess extends SocialStates{}
class GetDownloadProfileSuccess extends SocialStates{}
class UploadProfileError extends SocialStates{}
class UploadCoverLoading extends SocialStates{}
class UploadCoverSuccess extends SocialStates{}
class GetDownloadCoverSuccess extends SocialStates{}
class UploadCoverError extends SocialStates{}
class updateUserDataError extends SocialStates{}
class UploadPostLoading extends SocialStates{}
class UploadPostSuccess extends SocialStates{}
class UploadPostError extends SocialStates{}
class PostPickerLoading extends SocialStates{}
class PostPickerSuccess extends SocialStates{}
class PostPickerError extends SocialStates{}
class CeatePostLoading extends SocialStates{}
class CeatePostSuccess extends SocialStates{}
class CeatePostError extends SocialStates{}
class removePostSuccess extends SocialStates{}
class SocialGetPostsError extends SocialStates{}
class SocialGetPostsLoading extends SocialStates{}
class SocialGetPostsSuccess extends SocialStates{}
class SocialLikePostError extends SocialStates{}
class SocialLikePostSuccess extends SocialStates{}
class SocialCommentPostsError extends SocialStates{}
class SocialCommentPostsSuccess extends SocialStates{}
class SocialgetCommentError extends SocialStates{}
class SocialgetCommentSuccess extends SocialStates{}
class getTextCommensLoading extends SocialStates{}
class getTextCommensSuccess extends SocialStates{}
class getTextCommensError extends SocialStates{}
class getAllUseresSuccess extends SocialStates{}
class getAllUseresLoading extends SocialStates{}
class getAllUseresError extends SocialStates{}
class SendMessgesSucces extends SocialStates{}
class SendMessgesError extends SocialStates{}
class SendMessgesLoading extends SocialStates{}
class getMessgesLoading extends SocialStates{}
class getMessgesSucces extends SocialStates{}