import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeTheme = StateProvider((ref) =>  Themes.light);

enum Themes {
  dark,
  light
}

void updateTheme(String value) {
  final container = ProviderContainer();
  final themeNotifier = container.read(activeTheme.notifier);
  themeNotifier.state = value == "Themes.light" ? Themes.light : Themes.dark;
  StateProvider((ref) =>  value == "Themes.light" ? Themes.light : Themes.dark);
  container.dispose();
}

