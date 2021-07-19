import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<Details> futureData = Future.value();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureData = getDetails('rice');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Agro-Care',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

class Details {
  final String description;
  final String rainfall;
  final String duration;
  final String yield;
  final String seedTreatment;
  final String seedRate;
  Details({
    required this.description,
    required this.rainfall,
    required this.duration,
    required this.seedRate,
    required this.seedTreatment,
    required this.yield,
  });
  factory Details.fromSnapshot(DocumentSnapshot docSnap) {
    return Details(
      description: docSnap.get(''),
      rainfall: docSnap.get(''),
      duration: docSnap.get(''),
      seedRate: docSnap.get(''),
      seedTreatment: docSnap.get(''),
      yield: docSnap.get(''),
    );
  }
}

Future<Details> getDetails(String cropName) async {
  Future<Details> details = Future.value();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance
      .collection('crops')
      .doc(cropName)
      .get()
      .then((DocumentSnapshot docSnap) {
    if (docSnap.exists) {
      details = prepareData(docSnap);
    }
  });
  return details;
}

Future<Details> prepareData(DocumentSnapshot snapshot) async {
  return await Details.fromSnapshot(snapshot);
}
