import 'package:flutter/material.dart';

// Cicrular progress indicator to be used as a loading widget across the app
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.grey.withOpacity(0.75),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: const Center(
        child: CircularProgressIndicator(
            backgroundColor: Colors.white70,
            color: Colors.redAccent
        ),
      ),
    );
  }
}
