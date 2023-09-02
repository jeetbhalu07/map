import 'package:demo/first.dart';
import 'package:demo/two.dart';
import 'package:flutter/material.dart';

class second extends StatefulWidget {
  const second({super.key});

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  List<bool> temp = List.filled(10, false);
  int levelno = 0;
  bool t = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_pref();
  }

  get_pref() async {
    levelno = homepage.prefs!.getInt("levelno") ?? 0;
    print("LevelNO:$levelno");
    t = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SELECT MODE"), backgroundColor: Colors.teal),
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("myassets/img/background.jpg"))),
                  child: Row(
                    children: [
                      (t)
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: 9,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, myindex) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 3,
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "MATCH ${myindex + 1}",
                                                      style: TextStyle(
                                                          color: Colors.teal,
                                                          fontSize: 20),
                                                    ))),
                                            Expanded(
                                                flex: 1,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.teal,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Icon(
                                                        color: Colors.teal,
                                                        Icons
                                                            .question_mark_sharp)))
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.teal,
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: 10,
                                            itemBuilder: (context, index) {
                                              int l_no =
                                                  (myindex * 10) + index + 1;
                                              int l_no1 =
                                                  (myindex * 10) + index;
                                              return Card(
                                                child: ListTile(
                                                  onTap: () {
                                                    if(levelno>=l_no1){
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return first();
                                                            },
                                                          ));
                                                    }
                                                    setState(() {});
                                                  },
                                                  tileColor: (l_no1 <= levelno)
                                                      ? Colors.teal
                                                      : Colors.teal.shade100,
                                                  title: Text(
                                                      (levelno>l_no1)?"Level-${l_no} ${homepage.prefs!.getInt("level_time${l_no1}") ?? ""}s":"Level-${l_no}",
                                                    style:
                                                        TextStyle(fontSize: 25)
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    margin: EdgeInsets.all(50),
                                    height: double.infinity,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.teal.shade50,
                                        border: Border.all(
                                          color: Colors.teal,
                                          width: 5,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  );
                                },
                              ),
                            )
                          : CircularProgressIndicator(),
                    ],
                  ))),
          Expanded(
              flex: 1,
              child: Container(
                // width: double.infinity,
                color: Colors.teal,
              ))
        ],
      ),
    );
  }
}
