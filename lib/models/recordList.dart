import 'dart:convert';

import 'package:readr_app/models/customizedList.dart';
import 'package:readr_app/models/record.dart';

class RecordList extends CustomizedList<Record> {
  // constructor
  RecordList();

  factory RecordList.fromJson(List<dynamic> parsedJson) {
    if (parsedJson == null) {
      return null;
    }

    RecordList records = RecordList();
    List parseList = parsedJson.map((i) => Record.fromJson(i)).toList();
    parseList.forEach((element) {
      records.add(element);
    });

    return records;
  }

  factory RecordList.fromListingJson(List<dynamic> parsedJson) {
    if (parsedJson == null) {
      return null;
    }

    RecordList records = RecordList();
    List parseList = parsedJson.map((i) => Record.fromListingJson(i)).toList();
    parseList.forEach((element) {
      records.add(element);
    });

    return records;
  }

  factory RecordList.parseResponseBody(String body) {
    final jsonData = json.decode(body);

    return RecordList.fromJson(jsonData);
  }

  // your custom methods
  List<Map<dynamic, dynamic>> toJson() {
    List<Map> recordMaps = List();
    if (l == null) {
      return null;
    }

    for (Record record in l) {
      recordMaps.add(record.toJson());
    }
    return recordMaps;
  }

  String toJsonString() {
    List<Map> recordMaps = List();
    if (l == null) {
      return null;
    }

    for (Record record in l) {
      recordMaps.add(record.toJson());
    }
    return json.encode(recordMaps);
  }
}
