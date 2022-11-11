
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:queue/controllers/user.controller.dart';
import 'package:queue/models/user.model.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  String verificationID = '';
  var phone = "".obs;
  var loading = false.obs;
  var auth = FirebaseAuth.instance;

  verifyPhone (String phoneNumber) async {
    loading.value = true;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 30),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar(
          'verification failed',
          e.message!,
          snackPosition: SnackPosition.TOP
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        phone.value = phoneNumber;
        Get.toNamed('/otp');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationID = verificationId;
      },
    );
    loading.value = false;
  }

  verifyOtp(String otp) async {
    var credential = await auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationID, 
        smsCode: otp
      )
    );

    if(credential.user != null){

      /// use [credential.user!.uid] as user token
      await GetStorage().write('token', credential.user!.uid.toString());

      /// create a new users if not exist
      UserModel user = UserModel(
        id: credential.user!.uid,
        phone: phone.value
      );
      if (await Get.find<UserController>().createNewUser(user)) {
        Get.find<UserController>().user = user;
        Get.offAllNamed('/home');
      }
    }else{
      Get.snackbar(
        'Session expired',
        'The SMS code has expired. Please re-send the verification code to try again',
        snackPosition: SnackPosition.TOP
      );
    }
  } 
}