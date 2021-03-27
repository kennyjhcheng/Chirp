import 'package:bot/constants/ColorsConstants.dart';
import 'package:flutter/material.dart';

class OneClickChips extends StatelessWidget {
  const OneClickChips(
      {Key key,
      @required this.handleInput,
      @required this.quickReplyMap,
      @required this.displayMap,
      @required this.mapKey})
      : super(key: key);

  final handleInput;
  final quickReplyMap;
  final mapKey;
  final displayMap;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(6),
      child: FilterChip(
        padding: EdgeInsets.all(12),
        shape: StadiumBorder(
            side: BorderSide(color: Color(suggestionsOutlineColor))),
        backgroundColor: Colors.transparent,
        pressElevation: 10,
        onSelected: (value) async {
          //print("Once clicked ${displayMap[mapKey]}");
          if (displayMap[mapKey] == null) {
            handleInput(func: quickReplyMap[mapKey]);
          } else {
            handleInput(
                displayText: displayMap[mapKey], func: quickReplyMap[mapKey]);
          }
        },

        elevation: 0,
        // avatar: CircleAvatar(
        //   backgroundColor: Colors.grey.shade800,
        //   child: Text(""),
        // ),
        label: Text(
          mapKey,
          softWrap: true,
          style: TextStyle(fontSize: width < 700 ? 12 : 15),
        ),
      ),
    );
  }
}
