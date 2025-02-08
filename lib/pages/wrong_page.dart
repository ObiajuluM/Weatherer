import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherer/providers/weather.dart';

class WrongPage extends ConsumerStatefulWidget {
  const WrongPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WrongPageState();
}

class _WrongPageState extends ConsumerState<WrongPage> {
  @override
  Widget build(BuildContext context) {
    final greeting = ref.watch(greetingProvider);
    return Scaffold(
      backgroundColor:
          greeting == "Morning" ? Colors.white : Colors.grey.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              // alignment: Alignment.center,
              height: 200,
              child: Lottie.asset("assets/wrong.json"),
            ),
            const Text(
              "Something went wrong!",
              maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                // color: Colors.white,
                fontSize: 50,
                // fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
