import 'package:app/services/service.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  DataService service = DataService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<dynamic> _myData = [];
  List<dynamic> get myData => _myData;

  Future<void> getTasks() async {
    _isLoading = true;
    Response response = await service.getTasks();
    if (response.statusCode == 200) {
      _myData = response.body;
      update();
      print("Succesfully Fetched Tasks!");
    } else {
      print("Failed!");
    }
  }

  Future<void> pushTasks(String task, String taskDetail) async {
    _isLoading = true;
    Response response =
        await service.pushTask({"TaskName": task, "TaskDetail": taskDetail});
    if (response.statusCode == 200) {
      update();
      print("Succesfully Created Task!");
    } else {
      print("Failed!");
    }
  }
}