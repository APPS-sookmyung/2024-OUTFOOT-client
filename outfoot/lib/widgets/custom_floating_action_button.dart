import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget customFloatingActionButton(String assetPath, {required VoidCallback onPressed}) {
  return FloatingActionButton(
    onPressed: onPressed,
    backgroundColor: Colors.transparent,
    elevation: 0,
    child: SvgPicture.asset(
      assetPath,
      width: 65.035,
      height: 65.035,
      fit: BoxFit.contain,
    ),
  );
}