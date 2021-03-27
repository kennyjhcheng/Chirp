import 'dart:async';

import 'package:bot/constants/ColorsConstants.dart';
import 'package:bot/models/LinkCard.dart';
import 'package:bot/widgets/LinkCardWidget.dart';
import 'package:bot/widgets/TypingBubbleRow.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MultipleBubble extends StatefulWidget {
  MultipleBubble(
      {Key key,
      this.afterCardTitle,
      @required this.multipleTexts,
      @required this.hasAnimation,
      this.animationTime = 1000,
      @required this.makeDynamicRows,
      @required this.showQuickReplies,
      @required this.card,
      @required this.quickReply,
      this.multiplier = 1})
      : super(key: key);
  final List multipleTexts;
  final bool hasAnimation;
  final animationTime;
  final String afterCardTitle;
  final makeDynamicRows;
  final List card;
  final multiplier;
  bool showQuickReplies;
  final List quickReply;
  @override
  _MultipleBubbleState createState() => _MultipleBubbleState();
}

class _MultipleBubbleState extends State<MultipleBubble> {
  //Zero = typing , One = text
  int state;
  bool _visible = false;
  int multiplier = 1;
  void updateShowQuickReplies() {
    if (widget.showQuickReplies == true) {
      setState(() {
        _visible = true;
      });
    }
  }

  Widget makeLinkCards(List<LinkCard> cards) {
    // List oneClickChipArr = [];
    // arr.forEach((element) {
    //   oneClickChipArr.add(OneClickChips(
    //       mapKey: element,
    //       displayMap: widget.displayMap,
    //       handleInput: widget.handleInput,
    //       quickReplyMap: widget.quickReplyMap));
    // });
    // return oneClickChipArr;

    List<Widget> c = [];
    cards.forEach((element) {
      c.add(LinkCardWidget(
        link: element.link,
        title: element.title,
      ));
    });

    return Container(
      height: 200,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: c,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ...widget.multipleTexts.asMap().entries.map((e) {
            int milliseconds = 1000;
            if (widget.multipleTexts.length - 1 == e.key) {
              return OneOfMultiple(
                text: e.value,
                last: widget.card.length > 0 ? false : true,
                updateShowQuickReplies: updateShowQuickReplies,
                animationTime: milliseconds,
                multiplier: e.key,
                hasAnimation: widget.hasAnimation,
              );
            } else {
              return OneOfMultiple(
                text: e.value,
                animationTime: milliseconds,
                multiplier: e.key,
                updateShowQuickReplies: updateShowQuickReplies,
                hasAnimation: widget.hasAnimation,
              );
            }
          }),
          // new Text(this.widget.name,
          //     style: new TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 15,
          ),

          _visible == true && widget.card.length > 0 == true
              ? makeLinkCards(widget.card)
              : SizedBox(
                  height: 0.5,
                ),
          widget.card.length > 0 == true
              ? OneOfMultiple(
                  text: widget.afterCardTitle,
                  animationTime: 500,
                  multiplier: 1,
                  last: true,
                  updateShowQuickReplies: updateShowQuickReplies,
                  hasAnimation: widget.hasAnimation,
                )
              : SizedBox(
                  height: 0.01,
                ),
          _visible == true
              ? widget.makeDynamicRows(widget.quickReply)
              : SizedBox(
                  height: 1,
                ),
        ],
      ),
    );
  }
}

class OneOfMultiple extends StatefulWidget {
  const OneOfMultiple(
      {Key key,
      @required this.text,
      this.last = false,
      this.animationTime = 1000,
      this.multiplier = 1,
      this.updateShowQuickReplies,
      @required this.hasAnimation})
      : super(key: key);

  final String text;
  final bool hasAnimation;
  final int animationTime;
  final int multiplier;
  final bool last;
  final updateShowQuickReplies;
  @override
  _OneOfMultipleState createState() => _OneOfMultipleState();
}

class _OneOfMultipleState extends State<OneOfMultiple> {
  int state;
  bool _visible = false;
  @override
  void initState() {
    //Zero = typing , One = text
    state = widget.hasAnimation == true ? 0 : 1;

    if (widget.hasAnimation) {
      Timer(
          Duration(
            milliseconds: (widget.animationTime * widget.multiplier) + 500,
          ), () {
        setState(() {
          state = 1;
          if (widget.last == true) {
            widget.updateShowQuickReplies();
          }
        });
      });
      Timer(
          Duration(
            milliseconds: widget.animationTime * widget.multiplier,
          ), () {
        return setState(() {
          _visible = true;
        });
      });
    } else {
      setState(() {
        _visible = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: _visible,
      child: state == 0
          ? Container(
              margin: EdgeInsets.only(left: 5, top: 15),
              child: TypingBubbleRow())
          : Bubble(
              color: Color(botBubbleColor),
              style: BubbleStyle(
                nip: BubbleNip.leftTop,
                nipOffset: 20,
                //color: Color.fromARGB(255, 225, 255, 199),
                //elevation: 5,
                padding: BubbleEdges.all(15),
                margin: BubbleEdges.only(top: 8.0),
                alignment: Alignment.topLeft,
              ),
              child: new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(
                  widget.text,
                  style: TextStyle(fontSize: width < 700 ? 12 : 15),
                ),
              ),
            ),
    );
  }
}
