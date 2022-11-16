import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_puzzel/continue.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'main.dart';

class allLevel extends StatefulWidget {
  List<String> LevelStatus=List.filled(75, "lock");

  int mainCurentLevel=0;

  @override
  State<allLevel> createState() => _allLevelState();
}

class _allLevelState extends State<allLevel> {

  SharedPreferences ?pref;

  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData()
  async{

    pref= await SharedPreferences.getInstance();
    widget.mainCurentLevel=pref!.getInt("curentLevel")??0;

    for(int i=0;i<75;i++)
    {
      widget.LevelStatus[i]=pref!.getString("StatusOf_$i")??"lock";
    }
    widget.LevelStatus[widget.mainCurentLevel]="skip";
    print(" ${widget.LevelStatus}");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future:getData(),builder: (context, snapshot) {
      if(snapshot.connectionState==ConnectionState.done)
        {
          return SafeArea(child: Scaffold(
            //  appBar: AppBar(backgroundColor:Colors.transparent,title: "Selected Puzzel".text.make(),),
            body: Ink.image(height:double.infinity,width: double.infinity,image: AssetImage("myimg/background.jpg"),fit: BoxFit.fill
              ,child: Column(children: [
                "Select Puzzle".text.fontFamily("f2").size(context.screenHeight*0.1).color(Colors.indigo).center.make().p(context.screenHeight*0.01).expand(flex:1),
                GridView.builder(
                    itemCount: 75,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            if(widget.LevelStatus[index]!="lock")
                            {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => uperpage(index)));
                            }
                          },
                          child:Container(
                            alignment: Alignment.center,
                            height: context.screenHeight/7,
                            margin: EdgeInsets.all(context.screenWidth*0.016),

                            decoration: (widget.LevelStatus[index]!="lock")?
                            BoxDecoration(
                              image: (widget.LevelStatus[index]=="skip")?null:DecorationImage(fit: BoxFit.fill,image: AssetImage("myimg/tick.png")),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 2,color: Colors.black),
                            ):
                            BoxDecoration(
                              image: DecorationImage(fit: BoxFit.fill,image: AssetImage("myimg/lock.png")),
                            ),
                            child:widget.LevelStatus[index]!="lock" ? "${index+1}".text.color(Colors.black).fontFamily("f1").center.size(context.screenHeight*0.6).make():null ,
                          ) );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4)
                ).expand(flex: 8),
              ],),
            ),
          ));
        }
      else
        {
         return Container(alignment:Alignment.center,child:CircularProgressIndicator());
        }
    },);
  }
}


