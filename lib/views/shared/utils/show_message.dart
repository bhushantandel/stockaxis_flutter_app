import 'package:flutter/material.dart';
import 'package:stockaxis_flutter_app/views/shared/constants/size_config.dart';

class ShowMessage {
  static showScaffoldMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static showScaffoldErrorMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red));
  }

  static showMessage(String title, String body, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(0),
      content: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18 * SizeConfig.textScaleFactor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'X',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18 * SizeConfig.textScaleFactor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Text(
              body,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16 * SizeConfig.textScaleFactor),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(minutes: 1),
    ));
  }
}
