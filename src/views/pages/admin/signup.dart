import 'package:jaspr/jaspr.dart';

class AdminSignupPage extends StatelessComponent {
  const AdminSignupPage({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section([
      h1([text('Admin Signup')]),
      form([
        label([text('Username')]),
        label([text('Password')]),
        label([text('Confirm Password')]),
        button([text('Signup')]),
      ]),
    ]);
  }
}
