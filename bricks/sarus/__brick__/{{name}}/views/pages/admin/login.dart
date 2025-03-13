import 'package:jaspr/jaspr.dart';

class AdminLoginPage extends StatelessComponent {
  const AdminLoginPage({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section([
      h1([text('Admin Login')]),
      form([
        label([text('Username')]),
        label([text('Password')]),
        button([text('Login')]),
      ]),
    ]);
  }
}
