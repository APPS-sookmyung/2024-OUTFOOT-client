import 'package:flutter/material.dart';
import 'package:outfoot/colors/colors.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;

  const LoadingOverlay({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return SizedBox.shrink();

    return Container(
      child: Center(
        child: CircularProgressIndicator(
          color: mainBrownColor2,
          strokeWidth: 6.0,
        ),
      ),
    );
  }
}
