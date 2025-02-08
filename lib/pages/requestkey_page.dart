import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lottie/lottie.dart';

import 'package:weatherer/models/api_use.dart';

import 'package:weatherer/providers/weather.dart';

class RequestkeyPage extends ConsumerStatefulWidget {
  const RequestkeyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RequestkeyPageState();
}

class _RequestkeyPageState extends ConsumerState<RequestkeyPage> {
  final TextEditingController _apiController = TextEditingController();

  setApi() {
    // format api key
    if (_apiController.text.isNotEmpty) {
      setApiKey(_apiController.text);
      _apiController.clear();
      print("object");
    }
    // add to local storage
  }

  @override
  Widget build(BuildContext context) {


    // final currentTheme = ref.watch(ThemeModeStateProvider);
    final greeting = ref.watch(greetingProvider);
    // final greeting = "Morning";
    // final greeting = "Mornig";

    //
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,

      backgroundColor:
          greeting == "Morning" ? Colors.white : Colors.grey.shade900,

      //
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LottieBuilder.asset(
                greeting == "Morning"
                    ? "assets/onday.json"
                    : "assets/onnight.json",
              ),
              Text(
                "Weatherer",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  // color: Colors.white,
                  color: greeting == "Morning"
                      ? Colors.grey.shade900
                      : Colors.white,

                  // .shade500,
                  fontSize: 50,
                  // fontWeight: FontWeight.w700,
                ),
              ),

              ///
              ListTile(
                // padding: EdgeInsets.all(25),
                // tileColor: Colors.pinkAccent,
                title: TextField(
                  controller: _apiController,
                  style: TextStyle(
                    color: greeting == "Morning"
                        ? Colors.grey.shade900
                        : Colors.white,
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.pink,
                    hintText: "https://home.openweathermap.org/api_keys...",
                    hintStyle: TextStyle(
                      color: greeting == "Morning"
                          ? Colors.grey.shade900
                          : Colors.grey.shade800,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: greeting == "Morning"
                            ? Colors.grey.shade900
                            : Colors.grey.shade500,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: greeting == "Morning"
                            ? Colors.grey.shade900
                            : Colors.grey.shade200,
                      ),
                    ),
                  ),
                ),

                //
                trailing: IconButton(
                  color: greeting == "Morning"
                      ? Colors.grey.shade900
                      : Colors.grey.shade500,
                  onPressed: () {
                    setApi();
                  },
                  icon: Lottie.asset(
                    Icons8.login,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
