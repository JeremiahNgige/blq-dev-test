import 'package:blq_developer_test/utils/image.dart';
import 'package:blq_developer_test/utils/sizes.dart';

import 'package:flutter/material.dart';

Widget senderBubble(BuildContext context, String message, String time,
    String userName, String image) {
  var theme = Theme.of(context);
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Material(
        color: Colors.pink.shade400,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(3),
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            message,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ),
    ],
  );
}
