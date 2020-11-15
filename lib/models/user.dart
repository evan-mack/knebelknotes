class CustomUser {
  final String uid;
  final String email;
  CustomUser({this.uid, this.email});
}

class UserData {
   String uid;
   bool isAdmin = null;
   bool isStudent = null;
   DateTime accessExpires = null;

  UserData({this.uid, this.isAdmin, this.isStudent, this.accessExpires});
}