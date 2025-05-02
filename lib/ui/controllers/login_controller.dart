import 'package:get/get.dart';

import '../../data/models/login_models.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class LoginController extends GetxController{
  bool _loginInProgress = false;

  bool get loginInProgress => _loginInProgress;

  String ? _errorMessage;
  String ? get errorMessage => _errorMessage;




  Future<bool> login(String email,String password)async{
    bool isSuccess =false;
    _loginInProgress = true;
     update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };
    NetworkResponse response = await NetworkClient.postRequest(
        url: Urls.loginUrl, body: requestBody);

    if (response.isSuccess) {

      LoginModel loginModel =LoginModel.fromJson(response.data!);
      // TODO: Save token to local
      await AuthController.saveUserInformation(loginModel.token, loginModel.userModel);
      // TODO: Local database set up
      // TODO: Logged in /or not
      isSuccess =true;
      _errorMessage =null;


    } else {
     _errorMessage= response.errorMessage;
    }
    _loginInProgress = false;
    update();
    return isSuccess;
  }



}