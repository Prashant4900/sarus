import 'package:example/users/models.dart';
import 'package:sarus/sarus.dart';

class UserService
    extends
        CoreRepository<UsersInsertRequest, UsersUpdateRequest, UsersView, int> {
  UserService(Session db)
    : super(
        repository: db.userses,
        queryOne: (id) => db.userses.queryUsers(id),
        queryMany: (params) => db.userses.queryUserses(params),
      );
}

class AddressService
    extends
        CoreRepository<
          AddressInsertRequest,
          AddressUpdateRequest,
          AddressView,
          int
        > {
  AddressService(Session db)
    : super(
        repository: db.addresses,
        queryOne: (id) => db.addresses.queryAddress(id),
        queryMany: (params) => db.addresses.queryAddresses(params),
      );
}
