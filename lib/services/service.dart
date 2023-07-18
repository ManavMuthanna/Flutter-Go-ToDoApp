import 'package:get/get.dart';


class DataService extends GetConnect implements GetxService{

  String baseUri = "http://10.0.2.2:3000";

  Future<Response> getTasks() async{
    Response response = await get(
      "$baseUri/api/tasks",
      );
    return response;
  }

    Future<Response> pushTask(dynamic body) async{  
    Response response = await post(
      "$baseUri/api/create-task",
      body,
      );
    return response;
  }

    Future<Response> editTask(String id, dynamic body) async{  
    Response response = await patch(
      "$baseUri/api/task/$id",
      body,
      );
    return response;
  }

  Future<Response> getTask(String id) async {
    print("in service $id");
    Response response = await get(
      "$baseUri/api/task/$id",
    );
    return response;
  }

    Future<Response> deleteTask(String id) async {
    Response response = await delete(
      "$baseUri/api/task/$id",
    );
    return response;
  }
  }