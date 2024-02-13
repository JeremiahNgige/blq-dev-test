import 'package:blq_developer_test/utils/image.dart';
import 'package:flutter/material.dart';

import '../../utils/sizes.dart';

Widget recipientBubble(BuildContext context, String message, String time,
    String userName, String image, bool isOnline) {
  var theme = Theme.of(context);
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            margin: Spacing.all(10),
            child: Image.asset(
              (image != "") ? image : Images.profile1,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            // width: MediaQuery.of(context).size.width * 0.3,
            child: Material(
              elevation: 0,
              color: theme.cardColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          userName,
                          style: theme.textTheme.bodySmall!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        (!isOnline)
                            ? Container(
                                height: 4,
                                width: 4,
                                color: Colors.lightBlue,
                              )
                            : Container(
                                height: 4,
                                width: 4,
                                color: Colors.grey,
                              )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      message,
                      style: theme.textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        width: 8,
      ),
      Text(
        time,
        style: theme.textTheme.bodySmall,
      )
    ],
  );
}
