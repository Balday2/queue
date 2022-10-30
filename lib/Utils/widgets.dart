import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_scanner/Utils/assets.dart';
import 'package:mc_scanner/Utils/colors.dart';
import 'package:mc_scanner/Utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:mc_scanner/Utils/helpers.dart';
import 'package:mc_scanner/controller/scan.controller.dart';
import 'package:velocity_x/velocity_x.dart';


class MyWidgets {

  // colors


  // iconbutton
  IconButton iconBtn(icon, click){
    return IconButton(
      icon:icon,
      onPressed: click,
    );
  }



  

  Widget loadAgain(Function link, {String? desc}){
    return Center(
      child:Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin:const EdgeInsets.all(100.0),
            padding:const EdgeInsets.symmetric(vertical: 0.0),
            child: Lottie.asset(AppAsset.cross, repeat: false),
          ),
          Positioned(
            bottom:40,
            child:Text(desc ?? MyCst.ErrorConnexion).text.gray300.xl.make(),
          ),

          Positioned(
            bottom:0,
            child: InkWell(
              onTap: (){link();},
              child:Center(child: const Text("Réessayez").text.xl.bold.blue600.make(),)
            )
          ),
        ],
      )
    );
  }




  Future<void> showLoading(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  elevation: 0.0,
                  key: key,
                  backgroundColor: const Color.fromRGBO(38, 38, 38, 0.7),
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 3.5, 
                            valueColor: AlwaysStoppedAnimation<Color>(Vx.white)
                          ),
                        ),
                        10.heightBox,
                        const Text("chargement...").text.xl.white.make()
                      ],
                    )
                  ]
              )
          );
        }
      );
  }

  // Future<void> toast(context, msg, {bgColor:Vx.black, txtColor:Vx.white}){
  //   VxToast.show(
  //     context,
  //     msg: msg,
  //     bgColor: bgColor,
  //     textColor: txtColor,
  //     showTime: 5000
  //   );
  // }


  Widget richText({t1,t2}){
    return RichText(
      text: TextSpan(
        text: '$t1',
        style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15.0, color: Vx.black),
        children:[
          TextSpan(
            text: '$t2',
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0, color: Vx.black)
          ),
        ],
      ),
    );
  }

  TextStyle textStyle({color =Colors.black,size =15.0,fw =FontWeight.bold,double? space}){
    return TextStyle(
          color: color,
          fontWeight: fw,
          fontSize: size,
          letterSpacing: space,
          // fontFamily: 'Nunito'
        );
  }



Widget inputUi({ctrl, label, fillColor =Colors.black12,
  Function? onChange,height =40.0,mxl =1, fsHeight =0.0,String? initValue, type = TextInputType.text}){
    return   TextFormField(
      controller: ctrl,
      keyboardType: type,
      initialValue: initValue,
      maxLines: mxl,
      style: TextStyle(
        height: fsHeight, 
      ),
      decoration: InputDecoration(
        hintText:label,
        hintStyle: const TextStyle(
          fontSize: 12.0
        ),
        filled: true, 
        fillColor:fillColor, 
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:Colors.black)
        ),
      ),
      onChanged: (value){onChange!(value);},
    ).box.height(height).make();
}



  Widget outlineUI(child,{
    bg =Colors.white24, radius =20.0, outlineColor =Colors.transparent,
    width =1.5, ht =20.0, vt =5.0,longBtn
    }){
    return Container(
      width: longBtn,
      decoration: BoxDecoration(
        color:bg,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border:Border.all(color:outlineColor, width:width)
      ),
      padding:EdgeInsets.symmetric(horizontal: ht, vertical: vt),
      child:child
    );
  }


  Widget row(child1, child2,
  {space =2.0,cross =CrossAxisAlignment.start, main = MainAxisAlignment.start})
  {
    return Row(
      crossAxisAlignment:cross,
      mainAxisAlignment: main,
      children: [
        child1,
        SizedBox(width: space),
        child2
      ],
    );
  }


  Widget col(child1, child2,
  {space =0.0,cross =CrossAxisAlignment.start, main = MainAxisAlignment.start})
  {
    return Column(
      crossAxisAlignment:cross,
      mainAxisAlignment: main,
      children: [
        child1,
        SizedBox(height: space),
        child2,
      ],
    );
  }




BoxDecoration sheetcorner({Color color =Colors.white}){
  return BoxDecoration(
      color:color,
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10))
    );
}


  Future bottomSheet(BuildContext context,{ @required Widget? child,
    bcolor =Vx.white,barColor =Vx.gray500, dismiss =true, radius =10.0}) async{
    return Get.bottomSheet(
      Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.only(bottom: 20), 
          decoration: sheetcorner(color:bcolor),
          child: child
        )
      ),
      isScrollControlled: true,
      isDismissible: dismiss,
    );
  }


  Widget divider({color =Colors.black26, thick =0.5}){
    return Divider(
      color: color,
      thickness: thick,
    );
  }




  Future<void> modal(BuildContext context,child, {bcolor =Vx.white}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,

      builder: (BuildContext context){
        return SimpleDialog(
          backgroundColor: bcolor,
          children: <Widget>[
            Container(
              padding:const EdgeInsets.all(10),
              child:child
            )
          ]
        );
      }, 

    );
  }






  /// button ui design
  Widget button(
      {required Widget child,
      double elevation = 0.0,
      outlineColor = Colors.transparent,
      isLoading = false,
      onPressed,
      shape = 0.0,
      Color shadow = Colors.transparent,
      Color color = Colors.black,
      Color overColor = Colors.black,
      double width = 200.0,
      double height = 60.0}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 200),
          enableFeedback: true,
          backgroundColor: MaterialStateProperty.all(color),
          elevation: MaterialStateProperty.all(elevation),
          minimumSize: MaterialStateProperty.all(Size(width, height)),
          overlayColor: MaterialStateProperty.all(overColor.withOpacity(0.3)),
          shadowColor: MaterialStateProperty.all(shadow),
          visualDensity: VisualDensity.comfortable,
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(shape),
            side: BorderSide(width: 1.0, color: outlineColor),
          )),
        ),
        child: isLoading
          ? const CircularProgressIndicator(
              strokeWidth: 3.0, 
              valueColor: AlwaysStoppedAnimation<Color>(Vx.white)
            )
          : child,
      );
  }


      // button ui design
  Widget buttonUI({required Widget child, double elevation =0.0, bool isLoading = false, outlineColor = Colors.transparent, onPressed,shape = 0.0, Color shadow = Colors.transparent, Color color = Colors.black,Color overColor = Colors.black, double width =200.0, double height = 60.0}){
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        animationDuration: 200.milliseconds,
        enableFeedback: true,
        backgroundColor: MaterialStateProperty.all(color),
        elevation: MaterialStateProperty.all(elevation),
        minimumSize: MaterialStateProperty.all(Size(width,height)),
        overlayColor: MaterialStateProperty.all(overColor.withOpacity(0.3)),
        shadowColor: MaterialStateProperty.all(shadow),
        visualDensity: VisualDensity.comfortable,
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(shape), 
          side: BorderSide(width: 1.0, color: outlineColor),
        )),
      ),
      child: isLoading
        ? const SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
              strokeWidth: 3.0, 
              valueColor: AlwaysStoppedAnimation<Color>(Vx.white)
            ),
        )
        : child,
    );
  }


    /// input custom [labelText] [helperText] & [underline]
  Widget inputForm2(BuildContext context,
      {required String labelText,
      TextEditingController? controller,
      required Function(String? v) validate,
      required Function(String? v) onChanged,
      Function()? onTap,
      Widget? rightIcon,
      color = Vx.gray600,
      nextInput = TextInputAction.done,
      kbType = TextInputType.text,
      showText = false,
      readOnly = false,
      maxLines = 1}) {
    return TextFormField(
      cursorColor: Theme.of(context).backgroundColor,
      keyboardType: kbType,
      obscureText: showText,
      maxLines: maxLines,
      textInputAction: nextInput,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: color),
        helperStyle: TextStyle(color: color),
        suffixIcon: rightIcon,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color, width: 0.3),
        ),
      ),
      controller: controller,
      validator: (value) => validate(value),
      onChanged: (value) => onChanged(value),
      onTap: () => onTap != null ? onTap() : null,
      readOnly: readOnly,
    );
  }



  
  Widget inputForm(String label,{
    Function(String v)? valide ,Function(String save)? save, change(var v)?,
    type = TextInputType.text, iconL, iconR, showPwd =false, controller, initVal, 
    TextInputAction nextInput = TextInputAction.done,
  }) {
    return Theme(
      data: ThemeData(
        primaryColor: MyColors.primaryColor,
        primaryColorDark: Colors.red,
      ),
      child: TextFormField(
            initialValue: initVal,
            keyboardType: type,
            obscureText: showPwd,
            textInputAction: nextInput,
            style: const TextStyle(height: 0.0),
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                 borderSide: BorderSide(color:Vx.indigo700,width: 0.5),
                 borderRadius: BorderRadius.all(Radius.circular(10.0)),

              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                 borderSide: BorderSide(color:Vx.indigo700,width: 0.5),
                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            
              labelText: label, prefixIcon: iconL, suffixIcon: iconR,
              labelStyle: const TextStyle(color:MyColors.primaryColor),
              filled: true,
            ),
            validator: (value) => valide!(value!),
            onSaved:   (value) => save!(value!),
            onChanged: (value) => change!(value),
            controller: controller,

          )
    );
  }




   Future<void> dialog(BuildContext context, Widget child) async {
        return showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return WillPopScope(
                  onWillPop: () async => false,
                  child: SimpleDialog(
                      contentPadding: EdgeInsets.zero,
                      elevation: 10.0,
                      backgroundColor: MyColors.flou1,
                      children: <Widget>[
                        VxBox(
                          child: child
                        ).width(Get.width/2).make().pSymmetric(v:20)
                      ], 
                  )
              );
            }
        );
      }

    Future<void> scanResult(context,int code, Function click) async {
      dialog(
        context,
        [
          Text(
            code == 200 
            ? "Carnet Invalide"
            : "Carnet Valide",
          ).text.size(22.0).black.make(),
          Lottie.asset(
            code == 200 
            ? "assets/cross2.json"
            : "assets/check.json",
            fit: BoxFit.contain,width: Get.width/2, repeat: false), 
          10.heightBox, 
          buttonUI(
            child: "Ok".tr.text.white.xl2.make(), 
            width: Get.width, 
            color:  code == 200 ? MyColors.kRed : Colors.black,
            overColor: Vx.white, 
            shape: 5.0, 
            onPressed: (){
              click();
            }
          )
        ].vStack()
      );
}

  Future dialogUi({Widget? child}) {
    return Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: child,
        ),
      )
    );
  }




  Widget scaningUi(BuildContext context, bool twoGetback){
    final scanCtrl = Get.find<ScanController>();
    final _formKey = GlobalKey<FormState>();
    final quantity = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [


          Obx((){
            if(scanCtrl.step.value == 1){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "".text.base.make(),
                      const Icon(Icons.clear, color: Vx.black, size: 18.0).onInkTap(() => Get.back())
                    ],
                  ),
                  5.heightBox,
                  "Mahmud Balde".text.gray600.lg.bold.make(),
                  5.heightBox,
                  "Tel: 621078833".text.gray600.lg.make(),
                  3.heightBox,
                  "Quantité: 2300L".text.gray600.lg.make(),
                  const Divider(color: Vx.black).pSymmetric(v: 5),
                  20.heightBox,
                  "Quantité de litre".text.gray600.base.make(),
                  5.heightBox,
                  Center(
                    child: Form(
                      key: _formKey,
                      child: MyWidgets().inputForm(
                        "Quantite", 
                        valide: (value){
                          if(value.isEmpty) return "\u26A0 Le champ est obligatoire.";
                          return null;
                        },
                        save:(value) {},
                        type: TextInputType.number,
                        change: (value){},
                        controller: quantity
                      )
                    )
                  ).pSymmetric(v:5), 
                  20.heightBox,
                  buttonUI(
                    child: "Valider".tr.text.white.xl2.make(), 
                    width: Get.width, 
                    height: Get.width/8, 
                    overColor: Vx.white, 
                    isLoading: scanCtrl.isLoading.value,
                    shape: 5.0, 
                    onPressed: () async {
                      Helpers.checkConnection(context, 
                        () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          final carnetCtrl = Get.find<ScanController>();
                          if (!_formKey.currentState!.validate()) return;
                          _formKey.currentState!.save();
                          await carnetCtrl.quantity(context, quantity.text);
                        }
                      );
                    }
                  ).pSymmetric(v: 5)
                ],
              );
            }
            else if(scanCtrl.error.value != '' && scanCtrl.status.value == 200){
              return Column(
                children: [
                  "Verification".text.black.size(20.0).bold.make(),
                  "Carte scannée avec succès".text.xl.bold.green500.make(),
                  Lottie.asset(AppAsset.success, fit: BoxFit.contain, width: Get.width/2.5, animate: true, repeat: false),
                  buttonUI(
                    child: "Fermer".tr.text.white.xl2.make(), 
                    width: Get.width, 
                    height: Get.width/8, 
                    overColor: Vx.white, 
                    shape: 5.0, 
                    onPressed: (){
                      Get.back();
                    }
                  ).pSymmetric(v: 5)
                ],
              );
            } else if(scanCtrl.error.value != '' && scanCtrl.status.value != 200){
              return Column(
                children: [
                  "Verification".text.black.size(20.0).bold.make(),
                  scanCtrl.error.value.text.red600.xl.bold.center.make(),
                  Lottie.asset(AppAsset.cross, fit: BoxFit.contain, width: Get.width/2.5, animate: true, repeat: false),
                  buttonUI(
                    child: "Fermer".tr.text.white.xl2.make(), 
                    width: Get.width, 
                    height: Get.width/8, 
                    overColor: Vx.white, 
                    shape: 5.0, 
                    onPressed: (){
                      Get.back();
                    }
                  ).pSymmetric(v: 5)
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Verification".text.black.size(20.0).bold.make(),
                MyCst.scanMessage.text.black.size(10).center.make(),
                Lottie.asset(AppAsset.scanning, fit: BoxFit.contain, animate: true),
                buttonUI(
                    child: "Fermer".tr.text.white.xl2.make(), 
                    width: Get.width, 
                    height: Get.width/8, 
                    overColor: Vx.white, 
                    shape: 5.0, 
                    onPressed: (){
                      Get.back();
                    }
                  ).pSymmetric(v: 5)
              ],
            );
          })
        ],
      ).pSymmetric(v: 10, h: 10).scrollVertical(),
    );
  }
}