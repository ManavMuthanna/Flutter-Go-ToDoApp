import 'dart:convert';
import 'package:http/http.dart' as http;

class DataModel {
  final int id;
  final String name;
  final String details;
  final int created;

  DataModel({
    required this.id,
    required this.name,
    required this.details,
    required this.created,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['ID'],
      name: json['TaskName'],
      details: json['TaskDetail'],
      created: json['Created'],
    );
  }
}

Future<List<DataModel>> fetchData() async {
    final uri = Uri.parse("http://10.0.2.2:3000/api/tasks");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final List<DataModel> dataList = jsonResponse
          .map((data) => DataModel.fromJson(data))
          .toList();
      return dataList;
    } else {
      throw Exception("Failed to Fetch Data");
    }
}




