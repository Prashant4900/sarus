import 'package:jaspr/ui.dart';

import '../components/buttons.dart';
import '../components/input_field.dart';

// @client
class RegisterAdminPage extends StatelessComponent {
  const RegisterAdminPage({
    super.key,
    this.nameCallback,
    this.lastNameCallback,
    this.emailCallback,
    this.passwordCallback,
    this.confirmPassworCallback,
    this.onPressed,
  });

  final void Function(dynamic)? nameCallback;
  final void Function(dynamic)? emailCallback;
  final void Function(dynamic)? passwordCallback;
  final void Function(dynamic)? confirmPassworCallback;
  final void Function(dynamic)? lastNameCallback;
  final void Function()? onPressed;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section(
      classes: 'box',
      styles: Styles(
        width: Unit.pixels(550),
        padding: Spacing.all(Unit.pixels(50)),
      ),
      [
        Row(mainAxisAlignment: JustifyContent.center, children: [
          img(
            src: 'images/logo.svg',
            styles: Styles(
              display: Display.flex,
              width: Unit.pixels(70),
              flexDirection: FlexDirection.column,
              alignItems: AlignItems.center,
            ),
          ),
        ]),
        Spacer(height: Unit.rem(1.5)),
        h1(
          styles: Styles(
            margin: Spacing.only(bottom: Unit.rem(.7)),
            textAlign: TextAlign.center,
            fontSize: Unit.rem(1.5),
            fontWeight: FontWeight.bold,
          ),
          [text('Welcome to Sarus!')],
        ),
        p(
          styles: Styles(
            margin: Spacing.only(bottom: Unit.rem(1)),
            textAlign: TextAlign.center,
            fontSize: Unit.rem(.9),
            fontWeight: FontWeight.normal,
          ),
          [
            text(
                'Credentials are only used to authenticate in Sarus. All saved data will be stored in your database.'),
          ],
        ),
        Spacer(height: Unit.rem(.5)),
        form([
          Row(mainAxisAlignment: JustifyContent.spaceBetween, children: [
            InputField(
              labelText: 'First Name﹡',
              hintText: 'John',
              onInput: nameCallback,
            ),
            Spacer(width: Unit.rem(1)),
            InputField(
              labelText: 'Last Name﹡',
              hintText: 'Doe',
              onInput: lastNameCallback,
            ),
          ]),
          Spacer(height: Unit.rem(.5)),
          InputField(
            labelText: 'Email﹡',
            hintText: "e.g. admin@sarus.com",
            onInput: emailCallback,
          ),
          Spacer(height: Unit.rem(.5)),
          InputField(
            labelText: 'Password﹡',
            hintText: '********',
            helperText:
                'Must be at least 8 characters, 1 uppercase, 1 lowercase & 1 number',
            onInput: passwordCallback,
          ),
          Spacer(height: Unit.rem(.5)),
          InputField(
            labelText: 'Confirm Password﹡',
            hintText: '********',
            onInput: confirmPassworCallback,
          ),
          Spacer(height: Unit.rem(.5)),
          Row(
            crossAxisAlignment: AlignItems.center,
            children: [
              input(
                type: InputType.button,
                styles: Styles(
                  width: Unit.pixels(10),
                  height: Unit.pixels(15),
                ),
                [],
              ),
              Spacer(width: Unit.pixels(20)),
              p(
                styles: Styles(
                  fontSize: Unit.pixels(14),
                ),
                [
                  text(
                      'Keep me updated about new features & upcoming improvements (by doing this you accept the terms and the privacy policy).')
                ],
              )
            ],
          ),
          Spacer(height: Unit.rem(.5)),
          ElevatedButton(
            buttonText: "Let's get started",
            buttonStyles: Styles(
              margin: Spacing.only(top: Unit.rem(1)),
            ),
            onPressed: onPressed,
          ),
        ]),
      ],
    );
  }
}
