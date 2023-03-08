import 'package:chat_app/widgets/drop_down.dart';
import 'package:flutter/material.dart';

import '../constansts/constants.dart';
import '../widgets/text_Widget.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
      backgroundColor: scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                child: TextWidget(
                  label: "Chosen Model",
                  fontSize: 16,
                ),
              ),
              Flexible(flex: 2, child: ModelDropdownWidget()),
            ],
          ),
        );
      },
    );
  }
}
