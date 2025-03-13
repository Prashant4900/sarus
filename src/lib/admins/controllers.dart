import '../config/config.dart';
import '../controller/repository_controller.dart';
import 'model.dart';
import 'package:stormberry/stormberry.dart';

/// Controller for managing Admin entities
class AdminController extends BaseController<AdminModelInsertRequest,
    AdminModelUpdateRequest, AdminModelView, int> {
  /// Creates a new AdminController
  AdminController()
      : super(
          repository: Config.db.adminModels,
          queryOne: (id) => Config.db.adminModels.queryAdminModel(id),
          queryMany: (params) => Config.db.adminModels.queryAdminModels(params),
        );

  /// Gets only active admins
  Future<List<AdminModelView>> getActiveAdmins() async {
    final params = QueryParams(
      where: 'status = true',
      orderBy: 'created_at',
    );
    return getAll(params);
  }

  /// Gets admins by role
  Future<List<AdminModelView>> getAdminsByRole(String role) async {
    final params = QueryParams(
      where: 'role = @role',
      values: {'role': role},
    );
    return getAll(params);
  }

  /// Searches admins by name (first or last)
  Future<List<AdminModelView>> searchByName(String searchTerm) async {
    final params = QueryParams(
      where: 'first_name ILIKE @search OR last_name ILIKE @search',
      values: {'search': '%$searchTerm%'},
    );
    return getAll(params);
  }
}
