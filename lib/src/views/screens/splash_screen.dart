import 'package:flutter/material.dart';
import 'package:wiki_vault/src/core/messages.dart' as app_msg;

/// A Stateful Widget faking a loading animation
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController controller; // Controller for the progress indicator animation

  @override
  void initState() {
    controller = AnimationController(
      vsync: this, // animation to be synced with state of SplashScreenState object
      duration: const Duration(milliseconds: 1500),
    );
    controller.addListener(() => setState(() {})); // Add a listener to the animation controller to update the state when the animation changes
    // Wait for another 250 milliseconds after the animation is complete
    controller.forward().whenComplete(() async {
      await Future.delayed(const Duration(milliseconds: 250));
      Navigator.of(context).pushReplacementNamed('/search');
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose of animation controller as state itself is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build widget tree for SplashScreen
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          alignment: Alignment.center,
          widthFactor: 0.6,
          heightFactor: 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset(app_msg.appAssetIcon),
                          radius: 100,
                        ),
                      ),
                    ),
                    const Text(app_msg.appName, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w200, fontSize: 38.0))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 20, 60, 10),
                      child: LinearProgressIndicator(
                        color: Colors.redAccent,
                        backgroundColor: Colors.grey,
                        value: controller.value, // Set value of progress indicator to current value of animating controller
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}