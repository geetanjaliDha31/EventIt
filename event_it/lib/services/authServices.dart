import 'package:event_it/services/dbServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:event_it/helper/helperFunc.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login
  Future signinWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  //register user
  Future registerUserWithEmailAndPassword(
      String fullName, String email, String password, String phone, String dob, String gender, location) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        DatabaseServices(uid: user.uid).saveUserData(fullName, email, dob , phone, location, gender);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  //register org
  Future registerOrgWithEmailAndPassword(
      String fullName, String email, String password, String phone,  location) async {
    try {
      User org = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (org != null) {
        DatabaseServices(uid: org.uid).saveOrgData(fullName, email , phone, location);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  // signout
  Future signout() async {
    try {
      await helperFun.saveUserLoggedInStatus(false);
      await helperFun.saveUserNameSp("");
      await helperFun.saveUserEmailSp("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
