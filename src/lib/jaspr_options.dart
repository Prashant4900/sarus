// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';

import 'templates/admin/forgot.dart' as prefix0;
import 'templates/admin/login.dart' as prefix1;
import 'templates/admin/profile.dart' as prefix2;
import 'templates/dashboard/dashboard.dart' as prefix3;

/// Default [JasprOptions] for use with your jaspr project.
///
/// Use this to initialize jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'jaspr_options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultJasprOptions,
///   );
///
///   runApp(...);
/// }
/// ```
final defaultJasprOptions = JasprOptions(
  clients: {
    prefix0.ForgotPasswordAdminPage:
        ClientTarget<prefix0.ForgotPasswordAdminPage>('templates/admin/forgot'),
    prefix1.LoginAdminPage:
        ClientTarget<prefix1.LoginAdminPage>('templates/admin/login'),
    prefix2.Profile: ClientTarget<prefix2.Profile>('templates/admin/profile'),
    prefix3.Dashboard:
        ClientTarget<prefix3.Dashboard>('templates/dashboard/dashboard'),
  },
  styles: () => [StyleRule.import("styles.css")],
);
