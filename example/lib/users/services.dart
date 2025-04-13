import 'dart:convert';

import 'package:example/users/models.dart' hide AddressRepository;
import 'package:example/users/repositories.dart';
import 'package:stormberry/stormberry.dart';

class UserServices {
  UserServices(this._userRepo, this._addressRepo);

  final UserRepository _userRepo;
  final AddressRepository _addressRepo;

  Future<UsersView?> getUserById(int id) => _userRepo.get(id);

  Future<List<UsersView>> getAllUsers() => _userRepo.getAll();

  Future<List<AddressView>> getUserAddresses(int userId) async {
    final address = _addressRepo.getAll(
      QueryParams(where: jsonEncode({'users_id': userId})),
    );

    return address;
  }
}
