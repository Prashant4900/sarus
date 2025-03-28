import 'package:jaspr/jaspr.dart';

import '../components/sidebar.dart';

@client
class Dashboard extends StatelessComponent {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(classes: 'columns is-gapless is-fullheight main', [
      SideBar(),
      Content(),
    ]);
  }
}

class Content extends StatelessComponent {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'column content',
      styles: Styles(
        margin: Spacing.only(
          top: Unit.pixels(50),
          right: Unit.pixels(10),
          left: Unit.pixels(50),
        ),
      ),
      [
        h3([text('Hello Prashant')]),
        p([text('Welcome to your administration panel')])
      ],
    );
  }
}
