import 'package:bot/constants/ColorsConstants.dart';
import 'package:bot/widgets/JumpingDots.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class TypingBubbleRow extends StatelessWidget {
  const TypingBubbleRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Bubble(
          padding: BubbleEdges.only(
            left: 8,
            right: 8,
          ),
          style: BubbleStyle(
            radius: Radius.elliptical(50, 100),
            nipOffset: 20,
            padding: BubbleEdges.zero,
            nip: BubbleNip.leftTop,
            color: Color(botCircularAvatar),
            elevation: 0,
            alignment: Alignment.topLeft,
          ),
          child: Center(
            child: JumpingDotsProgressIndicator(
              color: Color(textComposerBtn),
              dotSpacing: 2,
              numberOfDots: 3,
              fontSize: 30,
              milliseconds: 200,
            ),
          ),
        ),
      ],
    );
  }
}
