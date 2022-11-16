import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_puzzel/allLevel.dart';
import 'package:math_puzzel/main.dart';
import 'package:math_puzzel/winPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import  'package:fluttertoast/fluttertoast.dart';
class uperpage extends StatefulWidget {
  //int curentLevel;
  int mainCurentLevel;
  uperpage(this.mainCurentLevel);

  @override
  State<uperpage> createState() => _uperpageState();
}

class _uperpageState extends State<uperpage> {
     DateTime CurentTime=DateTime.now();

  SharedPreferences ?pref;

  initState(){
    super.initState();
    setData();
  }

  setData()async{
    pref = await SharedPreferences.getInstance();
    String pastSkipTime= pref!.getString("pastSkiped")??(CurentTime.subtract(Duration(minutes: 3))).toString();
    print("past time === ${pastSkipTime}\ncurent time = ${CurentTime}");
    print("Continue page main Level= ${widget.mainCurentLevel}+1");
  }

  String typed = "";

  @override
  Widget build(BuildContext context) {
    print("upperPage Level ${widget.mainCurentLevel}");
    double screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("myimg/gameplaybackground.jpg")),
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                onTap: () {
                  DateTime dt2 = DateTime.parse(pref!.getString("pastSkiped")??(CurentTime.subtract(Duration(minutes: 3))).toString());
                  DateTime dt1 = CurentTime;
                   Duration diff = dt1.difference(dt2);
                   print(dt2);
                   if(pref!.getString("StatusOf_${widget.mainCurentLevel}")!="skip" ||pref!.getString("StatusOf_${widget.mainCurentLevel}")!="yes") {
                     if (diff.inMinutes >= 2) {
                       // print("IsLock == ");
                       // print(pref!.getString("StatusOf_${widget.mainCurentLevel}"));
                       if (pref!.getString("StatusOf_${widget
                           .mainCurentLevel}") == null ||pref!.getString("StatusOf_${widget.mainCurentLevel}") == "lock") {
                         pref!.setInt("curentLevel", widget.mainCurentLevel);
                         pref!.setString("StatusOf_${widget.mainCurentLevel}",
                             "skip");
                         widget.mainCurentLevel++;
                         pref!.setString("pastSkiped", CurentTime.toString());
                         Navigator.pushReplacement(context, MaterialPageRoute(
                           builder: (context) {
                             return uperpage(widget.mainCurentLevel);
                           },));
                       }
                     }
                     else {
                       Fluttertoast.showToast(
                           msg: "you can Skip affeter 2 Miutes",
                           timeInSecForIosWeb: 3);
                     }
                   }
                   else
                     {
                       Navigator.pushReplacement(context, MaterialPageRoute(
                         builder: (context) {
                           return uperpage(widget.mainCurentLevel);
                         },));
                     }
                },
                  child: Image(
                      height: context.screenHeight * 0.07,
                      image: AssetImage("myimg/skip.png"))),
              Container(
                  child: "Level ${widget.mainCurentLevel + 1}"
                      .text
                      .fontFamily("f2")
                      .color(Colors.white)
                      .size(context.screenHeight * 0.07)
                      .make(),
                  alignment: Alignment.center,
                  height: context.screenHeight * 0.07,
                  width: context.screenWidth * 0.50,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("myimg/level_board.png"),
                          fit: BoxFit.fill))),
              InkWell(
                  child: Image(
                      height: context.screenHeight * 0.07,
                      image: AssetImage("myimg/hint.png")))
            ]),
            Container(
              margin: EdgeInsets.only(
                  bottom: context.screenHeight * 0.05,
                  top: context.screenHeight * 0.04),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(levelImage.Level[widget.mainCurentLevel]))),
            ).expand(flex: 10),
            putText(widget.mainCurentLevel).expand(flex: 3)
          ],
        ),
      ),
    ));
  }
}

class putText extends StatefulWidget {

  int mainCurentLevel;
  putText(this.mainCurentLevel);

  @override
  State<putText> createState() => _putTextState();
}

class _putTextState extends State<putText> {
  SharedPreferences ?pref;
  initState(){
    super.initState();
    setData();
  }

  setData()async{
    pref = await SharedPreferences.getInstance();
  }
  String typed = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                        alignment: Alignment.center,
                        height: context.screenHeight * 0.07,
                        margin: EdgeInsets.all(10),
                        child: Text("${typed}",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: context.screenHeight * 0.06,
                                fontFamily: "f2",
                                color: Colors.black)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white))
                    .expand(flex: 5),
                InkWell(
                        onTap: () {
                          setState(() {
                            typed = typed.substring(0, typed.length - 1);
                          });
                        },
                        child: Image(
                            image: AssetImage("myimg/delete.png"),
                            height: context.screenHeight * 0.07))
                    .expand(),
                OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            maximumSize: Size(context.screenWidth * 0.25,
                                context.screenHeight * 0.07),
                            side: BorderSide(width: 3, color: Colors.white)),
                        onPressed: () {
                          print("submited");
                          if (int.parse(typed) == ans.rightAns[widget.mainCurentLevel]) {

                            //if(pref!.getString("StatusOf_${widget.mainCurentLevel}")=="lock"||pref!.getString("StatusOf_${widget.mainCurentLevel}")=="skip") {
                            if(pref!.getString("StatusOf_${widget.mainCurentLevel}")==null || pref!.getString("StatusOf_${widget.mainCurentLevel}")=="skip" ) {
                              pref!.setString(
                                  "StatusOf_${widget.mainCurentLevel}", "yes");
                              widget.mainCurentLevel++;
                              pref!.setInt(
                                  "curentLevel", widget.mainCurentLevel);
                            }


                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => youAreWin(widget.mainCurentLevel),
                                ));
                          }
                        },
                        child: "SUBMIT"
                            .text
                            .color(Colors.white)
                            .fontFamily("f2")
                            .size(context.screenWidth * 0.055)
                            .make())
                    .expand(flex: 2)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                numButton(1),
                numButton(2),
                numButton(3),
                numButton(4),
                numButton(5),
                numButton(6),
                numButton(7),
                numButton(8),
                numButton(9),
                numButton(0),
              ],
            )
          ],
        ));
  }

  numButton(int num) {
    return OutlinedButton(
            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                side: BorderSide(width: 1, color: Colors.white)),
            onPressed: () {
              setState(() {
                typed = typed + num.toString();
              });
            },
            child: num.text.fontFamily("f2").color(Colors.white).make())
        .expand();
  }
}

class levelImage {
  static List<String> Level = [
    "myimg/p1.png",
    "myimg/p2.png",
    "myimg/p3.png",
    "myimg/p4.png",
    "myimg/p5.png",
    "myimg/p6.png",
    "myimg/p7.png",
    "myimg/p8.png",
    "myimg/p9.png",
    "myimg/p10.png",
    "myimg/p11.png",
    "myimg/p12.png",
    "myimg/p13.png",
    "myimg/p14.png",
    "myimg/p15.png",
    "myimg/p16.png",
    "myimg/p17.png",
    "myimg/p18.png",
    "myimg/p19.png",
    "myimg/p20.png",
    "myimg/p21.png",
    "myimg/p22.png",
    "myimg/p23.png",
    "myimg/p24.png",
    "myimg/p25.png",
    "myimg/p26.png",
    "myimg/p27.png",
    "myimg/p28.png",
    "myimg/p29.png",
    "myimg/p30.png",
    "myimg/p31.png",
    "myimg/p32.png",
    "myimg/p33.png",
    "myimg/p34.png",
    "myimg/p35.png",
    "myimg/p36.png",
    "myimg/p37.png",
    "myimg/p38.png",
    "myimg/p39.png",
    "myimg/p40.png",
    "myimg/p41.png",
    "myimg/p42.png",
    "myimg/p43.png",
    "myimg/p44.png",
    "myimg/p45.png",
    "myimg/p46.png",
    "myimg/p47.png",
    "myimg/p48.png",
    "myimg/p49.png",
    "myimg/p50.png",
    "myimg/p51.png",
    "myimg/p52.png",
    "myimg/p53.png",
    "myimg/p54.png",
    "myimg/p55.png",
    "myimg/p56.png",
    "myimg/p57.png",
    "myimg/p58.png",
    "myimg/p59.png",
    "myimg/p60.png",
    "myimg/p61.png",
    "myimg/p62.png",
    "myimg/p63.png",
    "myimg/p64.png",
    "myimg/p65.png",
    "myimg/p66.png",
    "myimg/p67.png",
    "myimg/p68.png",
    "myimg/p69.png",
    "myimg/p70.png",
    "myimg/p71.png",
    "myimg/p72.png",
    "myimg/p73.png",
    "myimg/p74.png",
    "myimg/p75.png",
  ];
}

class ans {
  static List rightAns = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
}
