import 'package:final_year_demo/crop_prediction_screen.dart';
import 'package:final_year_demo/crop_statistics_screen.dart';
import 'package:final_year_demo/search_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MainScreen()));
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Agro-Care'),
      ),
      body: Column(
        children: [
          Container(
            width: width,
            height: height * 0.5,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset('images/farm.png'),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                CardWidget(
                  height: height,
                  text: 'Search',
                  nextScreen: SearchScreen(),
                ),
                CardWidget(
                  height: height,
                  text: 'Crop Prediction',
                  nextScreen: CropPrediction(),
                ),
                CardWidget(
                  height: height,
                  text: 'Crop Statistics',
                  nextScreen: CropStatisticsScreen(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    required this.height,
    required this.text,
    required this.nextScreen,
  });

  final double height;
  final String text;
  final nextScreen;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => nextScreen,
        ),
      ),
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: height * 0.1,
          child: Row(
            children: [
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
