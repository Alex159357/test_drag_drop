import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import 'bloc/drag/drag_bloc.dart';
import 'bloc/drag/drag_event.dart';
import 'drag_view.dart';


String panelId = "2";
String parameter = "h";
String token ="99d10fe4-1b2e-4a75-87a3-aa6c2c2d08dd";
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double acceptedData = 0;
  static double x = 0;
  static double y = 0;
  static double x1 = 0;
  static double y1 = 0;

  static List<Offset> offsets = [];

  @override
  void initState() {
    for (int i = 0; i < 5; i++){
      offsets.add(Offset(i*105, 30));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<DragBloc>().add(InitEvent());
    return Builder(builder: (context) => _buildPage(context));

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 150,
              child: Row(
                children: [
                  for (int i = 0; i < MediaQuery.of(context).size.width / 116.75; i++)
                    DragTarget<double>(
                      onMove: (v) {
                        // print("${v.data}");
                        // setState(() {
                        //   acceptedData = v.data;
                        // });
                      },
                      builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,) {
                        return Container(
                          height: 100.0,
                          width: 100.0,
                          margin: const EdgeInsets.all(5),
                          color: Colors.grey,
                        );
                      },
                      onAcceptWithDetails: (data){
                          // _showMyDialog("${data.data}", data.offset);
                      },
                      // onAccept: (double data) {
                      //
                      // },
                    )
                ],
              ),
            ),
              for(Offset offset in offsets)
              Positioned(
                left: offset.dx,
                top: offset.dy,
                child: Draggable<double>(
                  onDragEnd: (d) {
                    setState(() {
                      var t = offsets.indexOf(offset);
                      offset = d.offset;
                      offsets.removeAt(t);
                      offsets.insert(t, offset);
                    });
                  },
                  data: offsets.indexOf(offset).toDouble(),
                  feedback: Container(
                    height: 100.0,
                    width: 100.0,
                    color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(.5),
                    child: const Center(),
                  ),

                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                    child: const Center(),
                  ),
                ),
              ),

            //
            // Positioned(
            //   left: x1,
            //   top: y1,
            //   child: Draggable<double>(
            //     onDragUpdate: (d) {
            //       // if (d.globalPosition.dx + 100 >= x) {
            //       //   setState(() {
            //       //     x = x1 + 110;
            //       //   });
            //       // } else if (d.globalPosition.dx <= x + 100) {
            //       //   setState(() {
            //       //     x = x1 - 110;
            //       //   });
            //       // }
            //     },
            //     onDragEnd: (d) {
            //       setState(() {
            //         x1 = d.offset.dx;
            //         y1 = d.offset.dy;
            //       });
            //     },
            //     data: 11,
            //     feedback: Container(
            //       height: 100.0,
            //       width: 100.0,
            //       color: Colors.green.withOpacity(.5),
            //       child: const Center(),
            //     ),
            //     child: Container(
            //       height: 100.0,
            //       width: 100.0,
            //       color: Colors.green,
            //       child: const Center(),
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
  Widget _buildPage(BuildContext context) {
    DragBloc bloc = context.read<DragBloc>();
    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 150),
            child: DragViewWidget()));
  }



}
