//this file contains all the methods for authentication

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;/* this creates an instance...
  dont understand yet tho*/
  var verificationId =''.obs;

  void phoneAuthentication(String phoneNo) async{
    await _auth.verifyPhoneNumber(
        phoneNumber:phoneNo,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e){
          if(e.code == 'invalid-phone-number'){
            Get.snackbar("Error","Invalid phone number!!");
          }else{
            Get.snackbar("Error","something went wrong");
          }
        },
        codeSent: (verificationId,resendToken){
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId){
          this.verificationId.value = verificationId;
        }
    );
  }
  Future<bool> verifyOTP(String otp) async{
    var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: this.verificationId.value,
        smsCode: otp));
    return credentials.user != null? true:false;
  }
  //creating a function that takes details for signing up
  Future<void> registerWithEmailAndPassword(
      String email, String password) async{
        //after function takes details.. it creates a user
        final user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password
        );

  }

  //fuction for signing in
  Future<void> signInWithEmailAndPassword(
      String email, String password
      ) async{
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password
    );

  }
}