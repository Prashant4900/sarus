import 'package:jaspr/ui.dart';

import '../components/buttons.dart';
import '../components/input_field.dart';

@client
class ForgotPasswordAdminPage extends StatelessComponent {
  const ForgotPasswordAdminPage({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Column(
      children: [
        section(
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
            Spacer(height: Unit.rem(.5)),
            h1(
              styles: Styles(
                textAlign: TextAlign.center,
                fontSize: Unit.rem(1.5),
                fontWeight: FontWeight.bold,
              ),
              [text('Password Recovery')],
            ),
            Spacer(height: Unit.rem(.5)),
            form([
              InputField(labelText: 'Email﹡', hintText: "e.g. admin@sarus.com"),
              Spacer(height: Unit.rem(.5)),
              Spacer(height: Unit.rem(.5)),
              ElevatedButton(
                buttonText: "Send Email",
                buttonStyles: Styles(
                  margin: Spacing.only(top: Unit.rem(1)),
                ),
                onPressed: () {
                  print('Signup button pressed');
                },
              ),
            ]),
          ],
        ),
        Row(
          mainAxisAlignment: JustifyContent.center,
          children: [
            a(href: 'admin/auth/login', [text('Ready to Signin?')])
          ],
        ),
      ],
    );
  }
}
