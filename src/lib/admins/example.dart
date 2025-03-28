// import 'controllers.dart';
// import 'model.dart';

// Future<void> exampleUsage() async {
//   // Create the controller
//   final adminController = AdminController();

//   // Create a new admin
//   final adminId = await adminController.insert(AdminModelInsertRequest(
//     firstName: 'John',
//     lastName: 'Doe',
//     password: 'hashedPassword123',
//     email: 'john.doe@example.com',
//     role: 'admin',
//     status: true,
//     createdAt: DateTime.now().toIso8601String(),
//     updatedAt: DateTime.now().toIso8601String(),
//   ));

//   // Get the admin by ID
//   final admin = await adminController.get(adminId);
//   print('Created admin: ${admin?.firstName} ${admin?.lastName}');

//   // Update the admin
//   await adminController.update(AdminModelUpdateRequest(
//     id: adminId,
//     role: 'super_admin',
//   ));

//   // Get all admins with pagination
//   final admins = await adminController.getPaginated(
//     limit: 10,
//     offset: 0,
//     orderBy: 'last_name',
//     orderDesc: false,
//   );
//   print('Number of admins: ${admins.length}');

//   // Using custom methods
//   final activeAdmins = await adminController.getActiveAdmins();
//   print('Number of active admins: ${activeAdmins.length}');

//   // Search by name
//   final searchResults = await adminController.searchByName('Jo');
//   print('Search results: ${searchResults.length}');

//   // Delete the admin
//   await adminController.delete(adminId);
//   final exists = await adminController.exists(adminId);
//   print('Admin still exists: $exists');
// }
