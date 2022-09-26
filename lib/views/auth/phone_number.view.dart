import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queue/views/auth/otp.view.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class PhoneNumberView extends StatefulWidget {
  const PhoneNumberView({super.key});

  @override
  State<PhoneNumberView> createState() => _PhoneNumberViewState();
}

class _PhoneNumberViewState extends State<PhoneNumberView> {

  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Center(),
          Center(
            child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: "+224".text.base.bold.gray600.make()
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                          onChanged: (value){
                            setState(() {
                              phoneNumber = value;
                            });
                            print(value);
                          },
                    ))
                  ],
                ),
          ),
          [
            "🎉 Welcome !".text.xl2.size(20.0).bold.white.make(),
            const Icon(Icons.arrow_forward_sharp, color: Vx.white, size: 35.0,)
          ].hStack()
            .pSymmetric(h: 30,v: 15).box.color(Colors.blueAccent.withOpacity(0.8)).withRounded(value: 50.0)
            .make().onInkTap(() async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: phoneNumber,
                verificationCompleted: (PhoneAuthCredential credential) {
                  
                },
                verificationFailed: (FirebaseAuthException e) {},
                codeSent: (String verificationId, int? resendToken) {
                  Get.to(() => const OtpView());
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );
            })
        ],
      ),
    );
  }
}