import 'dart:convert';
import 'package:demo/first.dart';
import 'package:demo/level.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timer_count_down/timer_count_down.dart';

void main() {
  runApp(MaterialApp(
    home: first(),
  ));
}

class first extends StatefulWidget {
 int? lno;
 first([this.lno]);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  List all_img = [];
  List final_img = [];
  bool t = false;
  List<bool> status = [];
  int click = 1;
  int pos1 = 0;
  int pos2 = 0;
  int sec = 0;
  bool x = false;
  bool x1 = false;
  int cnt = 0;
  int level_no = 0;

  @override
  void initState() {
    super.initState();
    if(widget.lno==null){
      level_no = homepage.prefs!.getInt("levelno") ?? 0;
    }else
    {
      level_no=widget.lno!;
    }
    get_img();
    status = List.filled(12, true);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("You Have 5 Second To Memorize All Images "),
            actions: [
              TextButton(
                  onPressed: () {
                    t = true;
                    x1=true;
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Text("OK"))
            ],
          );
        },
      );
    });
  }

  Future get_img() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('img/'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      all_img = imagePaths;
      all_img.shuffle();
      for (int i = 0; i < 6; i++) {
        final_img.add(all_img[i]);
        final_img.add(all_img[i]);
      }
      final_img.shuffle();
    });
  }

  Stream get_time() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      if(x!=false){
        sec++;
        yield sec;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (x1)
            ? Countdown(
                seconds: 5,
                build: (BuildContext context, double time) {
                  return Text("Time : ${time.toInt()}");
                },
                interval: Duration(seconds: 1),
                onFinished: () {
                  print('Timer is done!');
                  status = List.filled(12, false);
                  x1 = false;
                  setState(() {});
                },
              )
            : (x)
                ? StreamBuilder(
                    stream: get_time(),
                    initialData: 0,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.done) {
                        return Text("Time :${snapshot.data}");
                      } else {
                        return Text("Time :");
                      }
                    },
                  )
                : Text("Time: $sec"),
      ),
      body: Column(children: [
        (t)
            ? Countdown(
                seconds: 5,
                build: (BuildContext context, double time) {
                  return SliderTheme(
                    child: Slider(
                      value: time,
                      max: 5,
                      min: 0,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      onChanged: (double value) {},
                    ),
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 10,
                        thumbColor: Colors.transparent,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 0.0)),
                  );
                },
                interval: Duration(seconds: 1),
                onFinished: () {
                  print('Timer is done!');
                  status = List.filled(12, false);
                  x=true;
                  setState(() {});
                },
              )
            : Text(""),
        Expanded(
          child: (t)
              ? GridView.builder(
                  itemCount: final_img.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        status[index] = true;
                        if (click == 1) {
                          click = 3;
                          pos1 = index;
                          Future.delayed(Duration(milliseconds: 200))
                              .then((value) {
                            click = 2;
                            setState(() {});
                          });
                        }
                        if (click == 2) {
                          pos2 = index;
                          click = 3;
                          if (final_img[pos1] == final_img[pos2]) {
                            click = 1;
                            cnt++;
                            if(cnt==6){
                              x=false;
                              int temp_sec=homepage.prefs!.getInt("level_time${level_no}") ?? 0;
                              if(sec<temp_sec)
                              {
                                homepage.prefs!.setInt("level_time${level_no}", sec);
                              }
                              if(widget.lno==null){
                                homepage.prefs!.setInt("level_time${level_no}", sec);
                                level_no++;
                                homepage.prefs!.setInt("levelno", level_no);

                              }
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("New Record!."),
                                    content: Wrap(children: [
                                      Text(" Seconds : $sec "),
                                      Text(" Level  Completed "),
                                    ],),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return second();
                                                  },
                                                ));
                                          },
                                          child: Text("OK"))
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            Future.delayed(Duration(milliseconds: 200))
                                .then((value) {
                              click = 1;
                              status[pos1] = false;
                              status[pos2] = false;
                              setState(() {});
                            });
                          }
                        }
                        setState(() {});
                      },
                      child: Visibility(
                        visible: status[index],
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration:
                              BoxDecoration(border: Border.all(width: 3)),
                          child: Image.asset("${final_img[index]}"),
                        ),
                        replacement: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey, border: Border.all(width: 3)),
                        ),
                      ),
                    );
                  },
                )
              : Text(""),
        ),
      ]),
    );
  }
}
