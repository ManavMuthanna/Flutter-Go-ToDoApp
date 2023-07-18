import 'package:get/get.dart';


class DataService extends GetConnect implements GetxService{

  String baseUri = "https://taskmanager-backend-gr7lmdgx6q-el.a.run.app";

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