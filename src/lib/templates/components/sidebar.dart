import 'dart:developer';

import 'package:jaspr/jaspr.dart';

import 'divider.dart';

// @client
class SideBar extends StatelessComponent {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'box column is-2 sidebar',
      styles: Styles(width: Unit.pixels(70)),
      [
        a(href: '/', [
          img(
            src: 'images/logo.svg',
            styles: Styles(
              width: Unit.pixels(30),
              margin: Spacing.symmetric(vertical: Unit.pixels(10)),
            ),
          )
        ]),
        Divider(),
        div(styles: Styles(height: Unit.percent(100)), []),
        Divider(),
        ProfileCard(),
      ],
    );
  }
}

// @client
class ProfileCard extends StatefulComponent {
  @override
  State<StatefulComponent> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool showHoverText = true;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // If showing hover text, render a full-screen overlay first
    if (showHoverText) {
      yield div(
        styles: Styles(
          position: Position.fixed(
            top: Unit.pixels(0),
            left: Unit.pixels(0),
            right: Unit.pixels(0),
            bottom: Unit.pixels(0),
          ),
          zIndex: ZIndex(51),
        ),
        events: {
          'click': (event) {
            setState(() {
              showHoverText = false;
            });
          },
        },
        [],
      );
    }

    // The actual profile card
    yield div(
      classes: 'circle card',
      styles: Styles(
        position: Position.relative(),
        zIndex: ZIndex(51),
        margin: Spacing.symmetric(vertical: Unit.pixels(10)),
      ),
      events: {
        'click': (event) {
          // Stop the event from bubbling up
          event.stopPropagation();
          log('message');
          print('object');
          setState(() {
            showHoverText = !showHoverText;
          });
        }
      },
      [
        text('PN'),
        if (showHoverText)
          div(
            classes: 'hover-text',
            styles: Styles(
              position: Position.absolute(
                left: Unit.pixels(0),
                bottom: Unit.pixels(50),
              ),
              zIndex: ZIndex(5),
              width: Unit.pixels(100),
              height: Unit.pixels(80),
              padding: Spacing.all(Unit.pixels(8)),
              shadow: BoxShadow(
                offsetX: Unit.pixels(2),
                offsetY: Unit.pixels(5),
                blur: Unit.pixels(2),
                spread: Unit.pixels(2),
                color: Color.rgba(0, 0, 0, 0.08),
              ),
              color: Color.hex('#000'),
              backgroundColor: Color.hex('#fff'),
            ),
            [
              text('Profile'),
              Divider(),
              text('Logout'),
            ],
          ),
      ],
    );
  }
}
