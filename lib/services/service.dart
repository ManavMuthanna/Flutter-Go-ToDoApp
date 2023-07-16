import 'package:get/get.dart';


class DataService extends GetConnect implements GetxService{

  Future<Response> getTasks() async{
    Response response = await get(
      "http://10.0.2.2:3000/api/tasks",
      );
    return response;
  }

    Future<Response> pushTask(dynamic body) async{  
    Response response = await post(
      "http://10.0.2.2:3000/api/create-task",
      body,
      );
    return response;
  }

  Future<Response> getTask(String id) async {
    print("in service $id");
    Response response = await get(
      "http://10.0.2.2:3000/api/task/$id",
    );
    return response;
  }
  }