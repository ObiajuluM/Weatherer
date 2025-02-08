import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:weatherer/models/api_use.dart';
import 'package:weatherer/pages/requestkey_page.dart';
import 'package:weatherer/pages/weather_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherer/pages/wrong_page.dart';
import 'package:weatherer/providers/weather.dart';
import 'package:weatherer/services/weather_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  final apiKey = await retrieveApiKeyFromLocal();
  WeatherService(apiKey: apiKey ?? "").getCurrentLatlan();

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    Future(() {
      ref.read(greetingProvider.notifier).greet();
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratAlternatesTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(103, 161, 197, 1),
        ),
      ),
      home: StreamBuilder(
          stream: apiKeyChanges.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const WeatherPage();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center();
            }

            if (snapshot.hasError) {
              return const WrongPage();
            }

            return const RequestkeyPage();
          }),
      // home: WeatherPage(),
    );
  }
}
