import 'package:jaspr/jaspr.dart';
import 'package:src/config/colors.dart';

// @client
class InputField extends StatelessComponent {
  const InputField({
    super.key,
    required this.labelText,
    this.helperText,
    this.value,
    this.hintText = '',
    this.onInput,
    this.width,
  });

  final String labelText;
  final String? helperText;
  final String? value;
  final String hintText;
  final Unit? width;
  final void Function(dynamic)? onInput;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      styles: Styles(
        display: Display.flex,
        width: Unit.percent(100),
        margin: Spacing.only(bottom: Unit.rem(.5)),
        flexDirection: FlexDirection.column,
      ),
      [
        label(
          styles: Styles(
            margin: Spacing.only(bottom: Unit.rem(.3)),
            fontSize: Unit.rem(.75),
            fontWeight: FontWeight.bold,
          ),
          [text(labelText)],
        ),
        input(
          styles: Styles(
            width: width,
            height: Unit.pixels(40),
            padding: Spacing.symmetric(horizontal: Unit.rem(.5)),
            border: Border(color: lightGrey),
            fontSize: Unit.rem(.85),
            fontWeight: FontWeight.normal,
          ),
          onInput: onInput,
          value: value,
          attributes: {
            "placeholder": hintText,
          },
          [],
        ),
        if (helperText != null)
          p(
            styles: Styles(
              fontSize: Unit.rem(.7),
              fontWeight: FontWeight.w400,
            ),
            [text(helperText!)],
          ),
      ],
    );
  }
}
