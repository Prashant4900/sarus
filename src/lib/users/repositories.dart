import 'package:example/users/models.dart';
import 'package:sarus/sarus.dart';
import 'package:stormberry/stormberry.dart';

class UserRepository
    extends
        CoreRepository<UsersInsertRequest, UsersUpdateRequest, UsersView, int> {
  UserRepository(Session db)
    : super(
        repository: db.userses,
        queryOne: (id) => db.userses.queryUsers(id),
        queryMany: (params) => db.userses.queryUserses(params),
      );
}

class AddressRepository
    extends
        CoreRepository<
          AddressInsertRequest,
          AddressUpdateRequest,
          AddressView,
          int
        > {
  AddressRepository(Session db)
    : super(
        repository: db.addresses,
        queryOne: (id) => db.addresses.queryAddress(id),
        queryMany: (params) => db.addresses.queryAddresses(params),
      );
}
