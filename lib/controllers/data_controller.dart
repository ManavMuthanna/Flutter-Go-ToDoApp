import 'package:app/services/service.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  DataService service = DataService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<dynamic> _myData = [];
  List<dynamic> get myData => _myData;

  dynamic _singleTask = {}; // Use Map<String, dynamic> for JSON object
  dynamic get singleTask => _singleTask; // Use Map<String, dynamic> for JSON object

  Future<void> getTasks() async {
    update(); // Update the state before setting _isLoading to true
    _isLoading = true;

    Response response = await service.getTasks();
    if (response.statusCode == 200) {
      _myData = response.body;
      print("Successfully Fetched Tasks!");
    } else {
      print("Failed!");
    }

    _isLoading = false;
    update();
  }

  Future<void> pushTasks(String task, String taskDetail) async {
    update(); // Update the state before setting _isLoading to true
    _isLoading = true;

    Response response =
        await service.pushTask({"TaskName": task, "TaskDetail": taskDetail});
    if (response.statusCode == 200) {
      print("Successfully Created Task!");
    } else {
      print("Failed!");
    }

    _isLoading = false;
    update();
  }

Future<void> getTask(String id) async {
  _isLoading = true;

  print("in cont $id");
  Response response = await service.getTask(id);
  if (response.statusCode == 200) {
      _singleTask = response.body;
      // print(_singleTask);
      print("Successfully Fetched Task!");
  } else {
    print("Failed!");
  }

  _isLoading = false;
  update();
}
}