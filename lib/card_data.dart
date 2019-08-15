import 'package:flutter/material.dart';

class CardData extends StatelessWidget {
  final String magnitude;
  final String place;
  final String time;

  CardData(
      {@required this.magnitude, @required this.place, @required this.time});

  @override
  Widget build(BuildContext context) {
    List subString = place.split('of ');
    String placeDistance = subString[0];
    String placeName = subString[1];
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.red,
          child: Text(
            magnitude,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  placeDistance.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  placeName,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              time,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
