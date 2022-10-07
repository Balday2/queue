
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/views/auth/otp.view.dart';
import 'package:queue/views/home/home.view.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  String verificationID = '';
  var phone = "".obs;
  var auth = FirebaseAuth.instance;

  verifyPhone (String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 30),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        phone.value = phoneNumber;
        Get.to(() => const OtpView());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationID = verificationId;
      },
    );
  }

  verifyOtp(String otp) async {
    var credential = await auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationID, 
        smsCode: otp
      )
    );

    if(credential.user != null){
      /// create a new users if not exist
        await AppConst.fireStore
          .collection('users')
          .add({
            'phone': phone.value
          });
      Get.offAll(() => const HomeView());
    }
  } 
}