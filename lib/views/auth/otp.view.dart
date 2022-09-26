import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {

  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Center(),
          Center(
            child: VxPinView(
              obscureText: false,
              size: 60.0,
              onChanged: ((value) {
                print(value.length);
              }
            )
          )
          ),
          [
            "🎉 Welcome !".text.xl2.size(20.0).bold.white.make(),
            const Icon(Icons.arrow_forward_sharp, color: Vx.white, size: 35.0,)
          ].hStack()
            .pSymmetric(h: 30,v: 15).box.color(Colors.blueAccent.withOpacity(0.8)).withRounded(value: 50.0)
            .make().onInkTap(() async {
            
            })
        ],
      ),
    );
  }
}