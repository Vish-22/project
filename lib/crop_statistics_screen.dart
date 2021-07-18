import 'package:flutter/material.dart';

class CropStatisticsScreen extends StatefulWidget {
  const CropStatisticsScreen({Key? key}) : super(key: key);

  @override
  _CropStatisticsScreenState createState() => _CropStatisticsScreenState();
}

class _CropStatisticsScreenState extends State<CropStatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agro-Care'),
      ),
      body: Column(),
    );
  }
}
