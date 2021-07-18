import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class CropPrediction extends StatefulWidget {
  @override
  _CropPredictionState createState() => _CropPredictionState();
}

String stateValue = '';

List<String> states = ['Karnataka'];
List<String> districts = ['DAVANGERE', 'BAGALKOT'];
List<String> seasons = ['kharif', 'Whole Year'];

class _CropPredictionState extends State<CropPrediction> {
  String districtValue = 'BAGALKOT';
  String seasonValue = 'Whole Year';
  TextEditingController minTempController = TextEditingController();
  TextEditingController maxTempController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Agro-Care'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DropdownButton(
                value: districtValue,
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                hint: Text('District'),
                items: <String>['DAVANGERE', 'BAGALKOT']
                    .map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    districtValue = newValue!;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButton(
                value: seasonValue,
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                hint: Text('Season'),
                items: seasons.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    seasonValue = newValue!;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: minTempController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (arg) {
                  double minTemp;
                  try {
                    minTemp = double.parse(arg.toString());
                  } catch (Exception) {
                    return "Avoid Special Characters";
                  }

                  if (minTemp < 0)
                    return "Minimum Temperature Should not be negative";
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Min Temperature',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: maxTempController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (arg) {
                  double maxTemp;
                  try {
                    maxTemp = double.parse(arg.toString());
                  } catch (Exception) {
                    return "Avoid Special Characters";
                  }
                  if (maxTemp > 40) return "Maximum Temperature range 40";
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Max Temperature',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  callApi(
                    districtValue,
                    seasonValue,
                    minTempController.text,
                    maxTempController.text,
                  ).then((value) => print('value:' + value.toString()));
                },
                child: Text('Predict'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future callApi(
    String district, String season, String minTemp, String maxTemp) async {
  Map<String, dynamic> bodyParams = {
    "district": district,
    "season": season,
    "min_temp": minTemp,
    "max_temp": maxTemp,
  };
  Map<String, String> headers = {'Content-type': 'application/json'};
  Uri url = Uri.parse('https://agrocare-api.herokuapp.com/predictCrop');
  String uri = 'https://agrocare-api.herokuapp.com/predictCrop';
  String json =
      '{"district": $district,"season": $season, "min_temp": $minTemp, "max_temp": $maxTemp}';
  // http.Response response = await http.post(url, headers: headers, body: json);
  Dio dio = Dio();
  final response = await dio.post(uri,
      data: bodyParams,
      options: Options(
          headers: {'Content-Type': 'application/json; charset=UTF-8'}));
  print(response.data);
  return response;
}

class Crop {
  final String name;
  Crop({required this.name});

  factory Crop.fromJson(Map<String, String> json) {
    return Crop(name: json['crop'] ?? '');
  }
}
