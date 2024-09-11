import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper{
 static AuthHelper helper = AuthHelper._();
  AuthHelper._();

  User? user;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> signUpEmail(String email, String password) async {
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch(e){
      return e.message ?? "Failed";
    }
  }

  Future<String> signInEmail(String email, String password) async {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch(e){
      return e.message ?? "Failed";
    }
  }

  bool checkUser(){
    user = auth.currentUser;
    return user!=null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<String> signWithGoogle() async {

    GoogleSignInAccount? signInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication authentication = await signInAccount!.authentication;
    var crd = GoogleAuthProvider.credential(accessToken: authentication.accessToken!,idToken: authentication.idToken);

    UserCredential userCrd = await auth.signInWithCredential(crd);

    user = userCrd.user;
    if(user!=null){
      return "Success";
    }else{
      return "Failed";
    }
  }
}