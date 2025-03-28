import 'package:jaspr/jaspr.dart';

class ElevatedButton extends StatelessComponent {
  const ElevatedButton({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.buttonStyles,
  });

  final String buttonText;
  final Styles? buttonStyles;
  final void Function()? onPressed;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield button(
      classes: 'button is-link',
      onClick: () {
        onPressed?.call();
      },
      type: ButtonType.button,
      styles: buttonStyles?.styles(
        width: Unit.percent(100),
        height: Unit.pixels(40),
        textAlign: TextAlign.center,
        fontSize: Unit.rem(.85),
        fontWeight: FontWeight.bold,
      ),
      [text(buttonText)],
    );
  }
}
