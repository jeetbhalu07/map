first.dart//
-------------
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'level.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homepage(),
    ),
  );
}

class homepage extends StatefulWidget {
  static SharedPreferences? prefs;

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int levelno=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    share_prefs();
  }
  share_prefs() async {
    homepage.prefs=await SharedPreferences.getInstance();
    levelno=homepage.prefs!.getInt("levelno")??0;
    print("level First page ${levelno}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
        "Select mode",
        style: TextStyle(color: Colors.white),
      ),
      ),
      body: Column(
        children: [
          Expanded(flex: 5,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("myassets/img/background.jpg"))),
              child: Column(children: [
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: 180,
                    margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
                    decoration: BoxDecoration(
                        color: Colors.tealAccent,
                        border: Border.all(width: 5, color: Colors.teal),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            color: Colors.teal,
                            child: Text(
                              "NO TIME LIMIT",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) {
                              return second();
                            },));
                          },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              color: Colors.teal,
                              child: Text(
                                "   NOMAL    ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(onTap:() {
                           Navigator.push(context, MaterialPageRoute(builder: (context) {
                             return second();
                           },));
                          },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              color: Colors.teal,
                              child: Text(
                                "    HARD    ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
               Expanded(child: Text("")),
                Expanded(
                  flex: 2,
                    child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      border: Border.all(width: 5, color: Colors.teal),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          height: 150,
                          width: 100,
                          margin: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          color: Colors.teal,
                          child: Text(
                            "REMOVE ADS",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                Expanded(child: Text("")),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 250,
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        color: Colors.tealAccent,
                        border: Border.all(width: 5, color: Colors.teal),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 200,
                            width: 50,
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            color: Colors.teal,
                            child: Text(
                              "SHARE",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 200,
                            width: 50,
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            color: Colors.teal,
                            child: Text(
                              "MORE GAMES",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ]),
            ),
          ),
          Expanded(child: Container(color: Colors.teal,),),
        ],
      ),
    );
  }
}
