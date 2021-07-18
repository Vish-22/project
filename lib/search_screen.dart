import 'package:final_year_demo/details_page.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> crops = [
    'Bangalore',
    'Chennai',
    'New York',
    'Mumbai',
    'Delhi',
    'Tokyo',
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Agro-Care'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: InkWell(
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // getDetailsFromFirebase();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => DetailsScreen()));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
