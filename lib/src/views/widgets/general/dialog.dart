import 'package:flutter/material.dart';

/// create dialog with title, content in the middle and buttons (actions) at the bottom
Future<void> showDialogScreen({required BuildContext context, required String title, required Widget content, required List<Widget> actions}) async {
  await showDialog<String>(
      context: context,
      builder: (context) {
        return Dialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 24.0),
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.redAccent)),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 16.0),
                  child: content
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 16.0, bottom: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(actions.length, (index) {
                        return Expanded(child: Padding(padding: EdgeInsets.only(left: index != 0 ? 8 : 0, right: 0), child: actions[index]));
                      })))
            ]));
      });
}
