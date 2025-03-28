import 'package:jaspr/jaspr.dart';

// @client
class Divider extends StatelessComponent {
  const Divider();

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield hr(
      styles: Styles(
        width: Unit.percent(100),
        padding: Spacing.all(Unit.pixels(0)),
        margin: Spacing.all(Unit.pixels(0)),
      ),
    );
  }
}
