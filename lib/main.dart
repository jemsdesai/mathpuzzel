import 'package:flutter/material.dart';
import 'package:math_puzzel/allLevel.dart';
import 'package:math_puzzel/continue.dart';
import 'package:math_puzzel/winPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

int clockSecond=0;
int clockMinit=0;
int clockHour=0;

void main() {
  int clockSecond=0;
  runApp(MaterialApp(
    home: homepage()
  ));
}
class homepage extends StatefulWidget {

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int mainCurentLevel=0;
  SharedPreferences ?pref;
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData()
  async{

    pref= await SharedPreferences.getInstance();
    mainCurentLevel=pref!.getInt("curentLevel")??0;
    print("home  page main Level= ${mainCurentLevel}+1");
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Ink.image(
      width: double.infinity,
      fit: BoxFit.cover,
      image: AssetImage("myimg/background.jpg"),
      child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          "Math Puzzels"
              .text
              .size(context.screenHeight * 0.05)
              .center
              .italic
              .color(Colors.indigo)
              .fontFamily("f2")
              .make(),
          (context.screenHeight * 0.11).heightBox,
          Ink.image(
            image: AssetImage("myimg/blackboard_main_menu.png"),
            alignment: Alignment.center,
             fit: BoxFit.fill,
            // padding: EdgeInsets.all(10),
            width: context.screenWidth * 0.9,
          //  height: context.screenHeight*0.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(

                    onTapUp: (details) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        print("home  page main Level= ${mainCurentLevel}+1");
                        return uperpage(mainCurentLevel);
                      }));
                    },

                    child: "CONTINUE"
                        .text
                        .size(context.screenHeight * 0.04)
                        .center
                        .italic
                        .color(Colors.white)
                        .fontFamily("f1")
                        .make()),
                (context.screenHeight * 0.02).heightBox,
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>allLevel(),));
                    },
                    child: "PUZZELES"
                        .text
                        .size(context.screenHeight * 0.04)
                        .center
                        .italic
                        .color(Colors.white)
                        .fontFamily("f1")
                        .make()),
                (context.screenHeight * 0.02).heightBox,
                OutlinedButton(

                    onPressed: () {},
                    child: "BUY PRO"
                        .text
                        .size(context.screenHeight * 0.04)
                        .center
                        .italic
                        .color(Colors.white)
                        .fontFamily("f1")
                        .make()),
              ],
            ),
          ).expand(flex: 5),
          (context.screenHeight * 0.05).heightBox,
          timer(),
          (context.screenHeight * 0.02).heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "myimg/ltlicon.png",
                fit: BoxFit.contain,
                width: context.screenWidth * 0.15,
                height: context.screenWidth * 0.15,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.attach_email)
                      ),
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.indigo),
                      onPressed: () {}, child: "Privacy Policy".text.make())
                ],
              )
            ],
          ).p(16)
        ],
      ),
    ));
  }
}
class timer extends StatefulWidget {
  const timer({Key? key}) : super(key: key);

  @override
  State<timer> createState() => _timerState();
}

class _timerState extends State<timer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clock();
  }
  Stream<String>clock()async*
  {
    while(true)
      {
          await Future.delayed(Duration(seconds: 1)).then((value) => clockSecond++);

          if(clockSecond>60)
            {
              clockSecond=0;
              clockMinit++;
            }
          if(clockMinit>60)
            {
              clockMinit=0;
              clockHour++;
            }
          yield "${clockHour.toString()} : ${clockMinit.toString()} : ${clockSecond.toString()}";
      }
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: clock(),builder: (context, snapshot) {
      if(snapshot.connectionState==ConnectionState.active)
      return Text("${snapshot.data}",style: TextStyle(color: Colors.purple,fontSize: 30,fontFamily: "f2"),textAlign: TextAlign.center,);
      else
        return CircularProgressIndicator();
    },);
  }
}
