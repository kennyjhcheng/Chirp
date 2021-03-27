import 'package:bot/constants/ColorsConstants.dart';
import 'package:flutter/material.dart';

class BotCircularAvatar extends StatelessWidget {
  const BotCircularAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: new CircleAvatar(
        radius: 30,
        backgroundColor: Color(botCircularAvatar),
      ),
    );
  }
}
