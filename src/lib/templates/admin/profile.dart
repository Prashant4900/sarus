import 'package:jaspr/jaspr.dart';
import 'package:jaspr/ui.dart' show Row, Spacer;

import '../components/buttons.dart';
import '../components/input_field.dart';
import '../components/sidebar.dart';

@client
class Profile extends StatelessComponent {
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
          right: Unit.pixels(100),
          left: Unit.pixels(50),
        ),
      ),
      [
        Spacer(height: Unit.pixels(10)),
        h2([text('Prashant Nigam')]),
        Spacer(height: Unit.pixels(10)),
        div(classes: 'profile-box', [
          p(classes: 'body-title', [text('Profile')]),
          Spacer(height: Unit.pixels(10)),
          Row(children: [
            InputField(
              labelText: 'First name﹡',
              hintText: "e.g. John",
              value: 'Prashant',
            ),
            Spacer(width: Unit.rem(1)),
            InputField(
              labelText: 'Last name﹡',
              hintText: "e.g. Doe",
              value: 'Nigam',
            ),
          ]),
          Spacer(height: Unit.pixels(10)),
          InputField(
            labelText: 'Email﹡',
            hintText: "e.g. johndoe@sarus.com",
            width: Unit.percent(49.5),
            value: 'Prashantnigam490@gmail.com',
          ),
          Spacer(height: Unit.pixels(10)),
          Row(mainAxisAlignment: JustifyContent.end, children: [
            ElevatedButton(buttonText: 'save'),
          ]),
        ]),
        div(classes: 'profile-box', [
          p(classes: 'body-title', [text('Change password')]),
          Spacer(height: Unit.pixels(10)),
          InputField(labelText: 'Current Password', width: Unit.percent(49.5)),
          Spacer(height: Unit.pixels(10)),
          Row(children: [
            InputField(labelText: 'Password'),
            Spacer(width: Unit.rem(1)),
            InputField(labelText: 'Confirm Password'),
          ]),
          Spacer(height: Unit.pixels(10)),
          Row(mainAxisAlignment: JustifyContent.end, children: [
            ElevatedButton(buttonText: 'save'),
          ]),
        ]),
      ],
    );
  }
}
