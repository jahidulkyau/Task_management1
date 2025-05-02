import 'package:get/get.dart';
import 'package:task_management/ui/controllers/login_controller.dart';
import 'package:task_management/ui/controllers/new_task_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(NewTaskController());

  }

}