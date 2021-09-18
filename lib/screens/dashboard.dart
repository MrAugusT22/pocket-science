import 'package:flutter/material.dart';

// class Dashboard extends StatefulWidget {
//   const Dashboard({Key? key}) : super(key: key);

//   static const String id = 'dashboard';

//   @override
//   _DashboardState createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//     );
//   }
// }

class Dashboard extends StatefulWidget {
  static const String id = 'dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Color bottomColor = Colors.red;
  Color topColor = Colors.yellow;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        AnimatedContainer(
          duration: Duration(seconds: 2),
          onEnd: () {
            setState(() {
              index = index + 1;
              // animate the color
              bottomColor = colorList[index % colorList.length];
              topColor = colorList[(index + 1) % colorList.length];

              //// animate the alignment
              begin = alignmentList[index % alignmentList.length];
              end = alignmentList[(index + 2) % alignmentList.length];
            });
          },
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, end: end, colors: [bottomColor, topColor])),
        ),
        Positioned.fill(
          child: IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              setState(() {
                bottomColor = Colors.blue;
              });
            },
          ),
        )
      ],
    ));
  }
}