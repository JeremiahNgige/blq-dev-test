import 'package:flutter/material.dart';

const kSubTextStyle = TextStyle(
  fontSize: 14,
  color: Color(0xFFBDBDBD),
);

const kBoxShadow2 = [
  BoxShadow(
    color: Colors.black12,
    blurRadius: 12.0, // soften the shadow
    spreadRadius: -1.0, //extend the shadow
    offset: Offset(
      1.0, // Move to right 10  horizontally
      1.0, // Move to bottom 10 Vertically
    ),
  )
];

const kSubTitleStyle = TextStyle(
  fontWeight: FontWeight.w100,
  fontSize: 16,
  color: Color(0xFFBDBDBD),
);

const kLinkStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 16,
  color: Colors.blueGrey,
);

const kSubTitle2Style = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 20,
);

const kOptionsText = TextStyle(fontSize: 12, color: Colors.white);

var kTitleStyle = const TextStyle(
  color: Color(0xBBFFFFFF),
);

const kBoxShadow = <BoxShadow>[
  BoxShadow(
      color: Color(0xFFE0E0E0),
      offset: Offset(4, 4),
      blurRadius: 8,
      spreadRadius: 0.8),
];

const kBoxShadowBlack = <BoxShadow>[
  BoxShadow(
      color: Colors.black12,
      offset: Offset(4, 4),
      blurRadius: 8,
      spreadRadius: 0.8),
];
