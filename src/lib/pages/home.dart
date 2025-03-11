import 'package:jaspr/jaspr.dart';

import '../config/env.dart';

class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section([
      img(src: 'images/logo.svg', width: 80),
      h1([text('Welcome to Jaspr: ${Env.get(EnvKey.DB_USER)}')]),
      p([text('You successfully create a new Jaspr site.')]),
      div(styles: Styles(height: 100.px), []),
    ]);
  }
}
