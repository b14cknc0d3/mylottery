import 'package:flutter/material.dart';
import 'package:my_lottery/src/ui/user_home/chart_view/line_chart_2.dart';
import 'package:my_lottery/src/ui/user_home/chart_view/line_chart_sample.dart';
class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green,
      child: SafeArea(child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
children: <Widget>[
  SizedBox(height: 20,),
//  Padding(
//    padding: const EdgeInsets.all(20.0,),
//    child: LineChartSample1(),
//  ),
  SizedBox(height: 20,),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: LineChartSample2(),

  ),
  Divider(color: Colors.white,),
],
        ),
      )),
    );
  }
}
