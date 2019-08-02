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

// To parse this JSON data, do
//
//     final earthquake = earthquakeFromJson(jsonString);
import 'dart:convert';

Earthquake earthquakeFromJson(String str) =>
    Earthquake.fromJson(json.decode(str));

String earthquakeToJson(Earthquake data) => json.encode(data.toJson());

class Earthquake {
  String type;
  Metadata metadata;
  List<Feature> features;

  Earthquake({
    this.type,
    this.metadata,
    this.features,
  });

  factory Earthquake.fromJson(Map<String, dynamic> json) => new Earthquake(
        type: json["type"],
        metadata: Metadata.fromJson(json["metadata"]),
        features: new List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "metadata": metadata.toJson(),
        "features": new List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  Properties properties;
  String id;

  Feature({
    this.properties,
    this.id,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => new Feature(
        properties: Properties.fromJson(json["properties"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "properties": properties.toJson(),
        "id": id,
      };
}

class Properties {
  double mag;
  String place;
  int time;
  String url;

  Properties({
    this.mag,
    this.place,
    this.time,
    this.url,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => new Properties(
        mag: json["mag"].toDouble(),
        place: json["place"],
        time: json["time"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "mag": mag,
        "place": place,
        "time": time,
        "url": url,
      };
}

class Metadata {
  int status;

  Metadata({
    this.status,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => new Metadata(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
