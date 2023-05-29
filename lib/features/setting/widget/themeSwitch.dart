import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/activateTheme.dart';

class ThemeSwitch extends ConsumerStatefulWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  ConsumerState<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends ConsumerState<ThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    return  Switch.adaptive(
        activeColor: Theme.of(context).colorScheme.secondary,
        value: ref.watch(activeTheme) == Themes.dark,
        onChanged: (value) async {
          ref.read(activeTheme.notifier).state = value ? Themes.dark : Themes.light;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('theme', ref.read(activeTheme.notifier).state.toString());
        }
    );
  }
}