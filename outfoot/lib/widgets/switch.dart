import 'package:flutter/material.dart';
import 'package:outfoot/colors/colors.dart';

typedef OnCheckChange = void Function(bool isShow);

class CustomSwitch extends StatefulWidget {
  CustomSwitch({
    Key? key,
    this.onCheckChange,
  }) : super(key: key);

  OnCheckChange? onCheckChange;

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch> {
  final duration = Duration(milliseconds: 100);
  final width = 50.0, height = 29.0;
  final ballSize = 25.0, ballPadding = 2.0;

  bool isChecked = true;
  Color switchColor = greyColor8; // 기본 색상 (비활성화 상태)
  double switchLeft = 2.0; // 왼쪽에 위치하도록 초기화

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: duration,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: switchColor, // 상태에 따라 색상 변경
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: renderSwitchBall(),
      ),
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          switchColor = isChecked ? greyColor8 : mainBrownColor;

          switchLeft =
              isChecked ? ballPadding : (width - ballSize) - ballPadding;

          widget.onCheckChange?.call(isChecked);
        });
      },
    );
  }

  Widget renderSwitchBall() {
    final ballRadius = ballSize / 2;

    return Stack(
      children: [
        AnimatedPositioned(
          duration: duration,
          top: 2,
          left: switchLeft,
          child: Container(
            width: ballSize,
            height: ballSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(ballRadius),
              ),
              color: lightMainColor,
            ),
          ),
        ),
      ],
    );
  }
}
