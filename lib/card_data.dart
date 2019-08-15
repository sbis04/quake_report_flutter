import 'package:flutter/material.dart';

class CardData extends StatelessWidget {
  final double magnitude;
  final String place;
  final String date;

  CardData(
      {@required this.magnitude, @required this.place, @required this.date});

  final String splitPosition = 'of ';

  @override
  Widget build(BuildContext context) {
    String placeDistance;
    String placeName;

    List<Color> magnitudeColor = [
      Color(0xFF04B4B3),
      Color(0xFF10CAC9),
      Color(0xFFF5A623),
      Color(0xFFFF7D50),
      Color(0xFFFC6644),
      Color(0xFFE75F40),
      Color(0xFFE13A20),
      Color(0xFFD93218),
    ];

    if (place.contains(splitPosition)) {
      List subString = place.split(splitPosition);
      placeDistance = subString[0];
      placeName = subString[1];
    } else {
      placeDistance = 'NEAR ';
      placeName = place;
    }

    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: magnitudeColor[magnitude.toInt()],
          child: Text(
            magnitude.toStringAsFixed(1),
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
              date,
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
