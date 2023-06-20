import 'dart:io';

class UserModel{
  String? uid;
  String? docId;
  String? name;
  String? discription;
  String? avatarUrl;
  String? backgroundUrl;
  File? avatarFile;
  File? backgroundFile;
  DateTime? lastLoginTime;
  DateTime? createdTime;

  UserModel({
    this.uid, // 파이어베이스 고객 key
    this.docId, // 클라우드 파이어스토어 doc id
    this.name, // 이름
    this.discription, // 부설명
    this.avatarUrl, // 프로필 사진
    this.backgroundUrl, // 배경화면 사진
    this.lastLoginTime,
    this.createdTime,
});
  
  UserModel.clone(UserModel user)
      : this(
          uid: user.uid,
          docId: user.docId,
          name: user.name,
          discription: user.discription,
          avatarUrl: user.avatarUrl,
          backgroundUrl: user.backgroundUrl,
          lastLoginTime: user.lastLoginTime,
          createdTime: user.createdTime,
      );

  void initImageFile(){
    avatarFile = null;
    backgroundFile = null;
  }
}