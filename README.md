<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This library is for user Firebase authentication purposes for my flutter app projects. It shares common widgets and logic for registration, logging in and out, changing password etc.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

Add dependency to _pubspec.yaml_ with github url and the most recent commit as value for ref field (since not published yet to a package repository):

```yaml
dependencies:
  auth_lib: 
    git: 
      url: https://github.com/zorrokid/flutter-auth-lib.git
      ref: d35dd0bb6d3b627f46164bd573a4edc177dab89
```

Initialize the library dependecies with _initializeAuthLib()_ in main

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initializeAuthLib();

  runApp(const MainApp());
}
```

Then use _UserForm_ in a widget:

```dart
class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserForm(),
    );
  }
}
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
