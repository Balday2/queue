import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:queue/controllers/auth.controller.dart';
import 'package:queue/controllers/config.controller.dart';
import 'package:queue/controllers/map.controller.dart';
import 'package:queue/controllers/user.controller.dart';
import 'package:queue/views/auth/otp.view.dart';
import 'package:queue/views/auth/phone_number.view.dart';
import 'package:queue/views/home/home.view.dart';
import 'package:queue/widgets/welcome.dart';
import 'app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'test_channel',
      channelName: 'Test Notification',
      channelDescription: 'Notficiations for basic testing',
    )
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'Nunito-ExtraBold'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name:"/",
          page: () =>  const WelcomeWidget()
        ),
        GetPage(
          name: "/phone",
          page: () =>  const PhoneNumberView(),
          binding: BindingsBuilder(() {
            Get.lazyPut<AuthController>(() => AuthController());
          })
        ),
        GetPage(
          name: "/otp",
          page: () =>  const OtpView(),
          binding: BindingsBuilder(() {
            Get.lazyPut<AuthController>(() => AuthController());
            Get.put(UserController(), permanent: true);
          })
        ),
        GetPage(
          name: "/home",
          page: () =>  HomeView(),
          binding: BindingsBuilder(() {
            Get.lazyPut<MapController>(() => MapController());
            Get.lazyPut<ConfigController>(() => ConfigController());
          })
        ),
      ]
    );
  }
}
