// Copyright (c) 2019 Souvik Biswas

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:quake_report/card_data.dart';

class EarthquakeScreen extends StatefulWidget {
  @override
  _EarthquakeScreenState createState() => _EarthquakeScreenState();
}

class _EarthquakeScreenState extends State<EarthquakeScreen> {
  final String url =
      'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&eventtype=earthquake&orderby=time&minmag=5&limit=100';

  // List earthquakes;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.mounted);
    this.getJson();
  }

  Future<List> getJson() async {
    List earthquakes;

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {'Accept': 'application.json'},
    );

    if (response.statusCode == 200) {
      setState(() {
        var convertDataToJson = jsonDecode(response.body);
        earthquakes = convertDataToJson['features'];
      });
    }

    return earthquakes;
  }

  Future<List> _refresh() {
    return getJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quake Report'),
        backgroundColor: Color(0xFF3d5e80),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Refresh",
            onPressed: () {
              _refreshIndicatorKey.currentState.show();
            },
          )
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: FutureBuilder(
          future: getJson(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.hasData ? snapshot.data.length : 0,
              itemBuilder: (BuildContext context, int index) {
                Map properties = snapshot.data[index]['properties'];

                var magnitude = properties['mag'].toDouble().toString();

                String place = properties['place'];

                var time = properties['time'];
                // var quakeUrl = properties['url'];

                var formattedTime = DateFormat.yMMMd().format(
                  DateTime.fromMillisecondsSinceEpoch(time),
                );

                return Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Card(
                    elevation: 8,
                    color: Color(0x983d5e80),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CardData(
                        magnitude: magnitude,
                        place: place,
                        time: formattedTime,
                      ),
                      // Column(
                      //   children: <Widget>[
                      //     Text(place),
                      //     Text(magnitude.toString()),
                      //     Text(DateFormat.yMMMd()
                      //         .format(DateTime.fromMillisecondsSinceEpoch(time))),
                      //     Text(quakeUrl),
                      //   ],
                      // ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
