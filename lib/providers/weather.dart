import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Greeting extends StateNotifier<String> {
  Greeting() : super("Morning");

  greet() {
    var hour = DateTime.now().hour;
    if (hour < 17) {
      state = 'Morning';
    } else {
      state = 'Evening';
    }
  }
}

final greetingProvider = StateNotifierProvider<Greeting, String>((ref) {
  return Greeting();
});

///
class ThemeModeState extends StateNotifier<ThemeMode> {
  ThemeModeState() : super(ThemeMode.light);

  changeState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // set state in UI
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    // set state in local storage
    state == ThemeMode.dark
        ? await prefs.setBool('night', true)
        : await prefs.setBool('night', false);

    // print(" is dark 1: ${prefs.getBool('night')}");
  }

  toDark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // set state in UI
    state = ThemeMode.dark;

    // set state in local storage
    state == ThemeMode.dark
        ? await prefs.setBool('night', true)
        : await prefs.setBool('night', false);

    // print(" is dark 2: ${prefs.getBool('night')}");
  }
}

final ThemeModeStateProvider =
    StateNotifierProvider<ThemeModeState, ThemeMode>((ref) {
  return ThemeModeState();
});

class Weatherer {
  void init() {}
}
