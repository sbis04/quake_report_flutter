import 'package:flutter/material.dart';

class CardData extends StatelessWidget {
  final String magnitude;
  final String place;
  final String time;

  CardData(
      {@required this.magnitude, @required this.place, @required this.time});

  final String splitPosition = 'of ';
  String placeDistance;
  String placeName;

  @override
  Widget build(BuildContext context) {
    if (place.contains(splitPosition)) {
      List subString = place.split(splitPosition);
      placeDistance = subString[0];
      placeName = subString[1];
    }
    else {
      placeDistance = 'NEAR ';
      placeName = place;
    }

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
                  (placeDistance + splitPosition).toUpperCase(),
                  style: TextStyle(
                    color: Colors.white60,
                  ),
                ),
                SizedBox(height: 5),
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
