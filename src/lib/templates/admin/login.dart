import 'package:jaspr/ui.dart';
import '../../config/logger.dart';

import '../components/buttons.dart';
import '../components/input_field.dart';

@client
class LoginAdminPage extends StatefulComponent {
  const LoginAdminPage({super.key});

  @override
  State createState() => LoginAdminPageState();
}

class LoginAdminPageState extends State<LoginAdminPage> {
  int _value = 0;

  void counter(int newValue) {
    setState(() {
      _value = newValue;
    });
  }

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
        Spacer(height: Unit.rem(.5)),
        h1(
          styles: Styles(
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
            text('Login to your Sarus account'),
          ],
        ),
        Spacer(height: Unit.rem(.5)),
        InputField(labelText: 'Email﹡', hintText: "e.g. admin@sarus.com"),
        Spacer(height: Unit.rem(.5)),
        InputField(labelText: 'Password﹡', hintText: "*********"),
        Spacer(height: Unit.rem(.5)),
        Row(
          crossAxisAlignment: AlignItems.center,
          mainAxisAlignment: JustifyContent.spaceBetween,
          children: [
            Row(
              children: [
                input(
                  type: InputType.button,
                  styles: Styles(
                    width: Unit.pixels(10),
                    height: Unit.pixels(15),
                  ),
                  [],
                ),
                Spacer(width: Unit.pixels(5)),
                p(
                  styles: Styles(
                    fontSize: Unit.pixels(14),
                  ),
                  [text('Remember Me')],
                ),
              ],
            ),
            a(
              styles: Styles(
                fontSize: Unit.pixels(14),
              ),
              href: 'admin/auth/forgot',
              [text('Forgot your password?')],
            )
          ],
        ),
        Spacer(height: Unit.rem(.5)),
        ElevatedButton(
          buttonText: "Login $_value",
          buttonStyles: Styles(
            margin: Spacing.only(top: Unit.rem(1)),
          ),
          onPressed: () {
            counter(1);
            Logger.info("9090");
            print("object");
          },
        ),
      ],
    );
  }
}
