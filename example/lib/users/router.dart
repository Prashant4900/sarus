import 'package:sarus/sarus.dart';

class UserRouter extends FeatureRouter {
  @override
  void configureRoutes() {
    super.configureRoutes();

    addRoute(Method.get, '/users', _getAllUsers);
    addRoute(Method.get, '/users/:id', _getUserById);
    addRoute(Method.post, '/users', _createUser);
    addRoute(Method.put, '/users/:id', _updateUser);
    addRoute(Method.delete, '/users/:id', _deleteUser);
  }

  Response _getAllUsers(Request request) => Response.ok('All users');
  Response _getUserById(Request request) => Response.ok('User details');
  Response _createUser(Request request) => Response.ok('User created');
  Response _updateUser(Request request) => Response.ok('User updated');
  Response _deleteUser(Request request) => Response.ok('User deleted');
}

class ProductRouter extends FeatureRouter {
  @override
  void configureRoutes() {
    addRoute(Method.get, '/products', _getAllProducts);
    addRoute(Method.post, '/products', _createProduct);
  }

  Response _getAllProducts(Request request) => Response.ok('All products');
  Response _createProduct(Request request) => Response.ok('Product created');
}
