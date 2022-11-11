import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue/controllers/config.controller.dart';
import 'package:queue/views/history.view.dart';
import 'package:queue/views/home/widgets/custom.map.dart';
import 'package:queue/views/search.view.dart';
import 'package:queue/views/user.view.dart';
import 'package:queue/widgets/widgets.dart';

class HomeView extends StatelessWidget {
   HomeView({ Key? key }) : super(key: key);
  final configCtrl = Get.find<ConfigController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
          return Stack(
            children: [
              if(configCtrl.bottomBarIndex.value == 0)
                const CustomMap(),
              if(configCtrl.bottomBarIndex.value == 1)
                const SearchView(),
              if(configCtrl.bottomBarIndex.value == 2)
                const HistoryView(),
              if(configCtrl.bottomBarIndex.value == 3)
                UserView(),
              WidgetUi().bottomBar()
            ],
          );
        }
      )
      
    );
  }
}