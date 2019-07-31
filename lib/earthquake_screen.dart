import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EarthquakeScreen extends StatefulWidget {
  @override
  _EarthquakeScreenState createState() => _EarthquakeScreenState();
}

class _EarthquakeScreenState extends State<EarthquakeScreen> {
  final String url =
      'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&eventtype=earthquake&orderby=time&minmag=6&limit=20';

  List earthquakes;

  @override
  void initState() {
    super.initState();
    this.getJson();
  }

  Future<dynamic> getJson() async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {'Accept': 'application.json'},
    );

    if (response.statusCode == 200) {
      print(response.body);

      setState(() {
        var convertDataToJson = jsonDecode(response.body);
        earthquakes = convertDataToJson['features'];
      });
    }

    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quake Report'),
      ),
      body: ListView.builder(
        itemCount: earthquakes == null ? 0 : earthquakes.length,
        itemBuilder: (_, index) {
          Map properties = earthquakes[index]['properties'];
          var magnitude = properties['mag'].toDouble();
          var place = properties['place'];
          var time = properties['time'];
          var quakeUrl = properties['url'];

          return Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Card(
              color: Colors.teal[100],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Text(place),
                    Text(magnitude.toString()),
                    Text(DateFormat.yMMMd()
                        .format(DateTime.fromMillisecondsSinceEpoch(time))),
                    Text(quakeUrl),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
