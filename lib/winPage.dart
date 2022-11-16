import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_puzzel/continue.dart';
import 'package:math_puzzel/main.dart';
import 'package:velocity_x/velocity_x.dart';

class youAreWin extends StatelessWidget {
  int  curentwinLevel;
  youAreWin(this.curentwinLevel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Ink.image(height:double.infinity,width: double.infinity,image: AssetImage("myimg/background.jpg"),fit: BoxFit.fill
              ,child: Column(
          children: [
            "PUZZLE  ${curentwinLevel}  COMPLETED".text.color(Colors.indigo).size(context.screenHeight * 0.045).fontFamily("f2").make().p(context.screenHeight*0.05)
            ,Ink.image(image: AssetImage("myimg/trophy.png"),width: context.screenWidth*0.4,height: context.screenHeight*0.30),
            (context.screenHeight*0.04).heightBox,
            InkWell(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => uperpage(curentwinLevel)));
            },
            child: Container(
            width: context.screenWidth*0.4,height: context.screenHeight*0.06,
              margin: EdgeInsets.all(context.screenHeight*0.02),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(
                    0xFF838181),Color(0xFFAFABAB),Color(0xFFF6F1F1),Color(0xFF989494)]),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2,color: Colors.black)
                ),
              child: "CONTINUE".text.center.fontFamily("f2").size(context.screenHeight * 0.05).color(Colors.black).make(),
            ),),
            InkWell(
            onTap: () {
              curentwinLevel++;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homepage(),));
            },
            child: Container(
            width: context.screenWidth*0.4,height: context.screenHeight*0.06,
              margin: EdgeInsets.all(context.screenHeight*0.02),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(
                    0xFF838181),Color(0xFFAFABAB),Color(0xFFF6F1F1),Color(0xFF989494)]),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2,color: Colors.black)
                ),
              child: "MAIN MENU".text.center.fontFamily("f2").size(context.screenHeight * 0.05).color(Colors.black).make(),
            ),),
            InkWell(
            child: Container(
            width: context.screenWidth*0.4,height: context.screenHeight*0.06,
              margin: EdgeInsets.all(context.screenHeight*0.02),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF838181),Color(0xFFAFABAB),Color(0xFFF6F1F1),Color(0xFF989494)]),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2,color: Colors.black)
                ),
              child: "BUY PRO".text.center.fontFamily("f2").size(context.screenHeight * 0.05).color(Colors.black).make(),
            ),),
          ],
        ),
            ),
    );
  }
}
