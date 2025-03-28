import 'dart:developer';

import 'controllers.dart';
import 'model.dart';

class AdminServices {
  final _adminController = AdminController();

  Future<int> insert(AdminModelInsertRequest adminModelInsertRequest) async {
    return await _adminController.insert(adminModelInsertRequest);
  }

  Future<List<int>> insertAll(
      List<AdminModelInsertRequest> adminModelInsertRequests) async {
    return await _adminController.insertMany(adminModelInsertRequests);
  }

  Future<int> count() async {
    return await _adminController
        .getActiveAdmins()
        .then((value) => value.length);
  }

  Future<void> login(String email, String password) async {
    try {
      print("login");
      log("login");
    } catch (exception, stackTrace) {
      print("exception: $exception");
      print("stackTrace: $stackTrace");
    }
  }
}
