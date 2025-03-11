import 'package:jaspr/jaspr.dart';

class About extends StatelessComponent {
  const About({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section([
      ol([
        li([
          h3([text('📖 Documentation')]),
          text("Jaspr's "),
          a(
            href: 'https://docs.page/schultek/jaspr',
            [text('official documentation')],
          ),
          text(' provides you with all information you need to get started.'),
        ]),
        li([
          h3([text('💬 Community')]),
          text('Got stuck? Ask your question on the official '),
          a(href: 'https://docs.page/schultek/jaspr', [text('Discord server')]),
          text(' for the Jaspr community.'),
        ]),
        li([
          h3([text('📦 Ecosystem')]),
          text(
            'Get official packages and integrations for your project like jaspr_router, jaspr_tailwind or jaspr_riverpod. Find packages built for Jaspr on pub.dev using the ',
          ),
          a(href: 'https://pub.dev/packages?q=topic%3Ajaspr', [text('#jaspr')]),
          text(' topic, or publish your own.'),
        ]),
        li([
          h3([text('💙 Support Jaspr')]),
          text('If you like Jaspr, consider starring us on '),
          a(href: 'https://github.com/schultek/jaspr', [text('Github')]),
          text(' and tell your friends.'),
        ]),
      ]),
    ]);
  }

  @css
  static final styles = [
    // css('ol').box(maxWidth: 500.px),
  ];
}
