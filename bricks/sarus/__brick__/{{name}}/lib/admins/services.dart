import 'controllers.dart';
import 'model.dart';

class AdminServices {
  final _adminController = AdminController();

  Future<int> insert(AdminModelInsertRequest adminModelInsertRequest) async {
    return await _adminController.insert(adminModelInsertRequest);
  }

  Future<List<int>> insertAll(
    List<AdminModelInsertRequest> adminModelInsertRequests,
  ) async {
    return await _adminController.insertMany(adminModelInsertRequests);
  }

  Future<int> count() async {
    return await _adminController.getActiveAdmins().then(
      (value) => value.length,
    );
  }
}
