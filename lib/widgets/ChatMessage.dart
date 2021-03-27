import 'dart:async';
import 'dart:io';

import 'package:bot/constants/ColorsConstants.dart';
import 'package:bot/models/LinkCard.dart';
import 'package:bot/widgets/BotCircularAvatar.dart';
import 'package:bot/widgets/LinkCardWidget.dart';
import 'package:bot/widgets/MultipleBubble.dart';
import 'package:bot/widgets/OneClickChips.dart';
import 'package:bot/widgets/UserCircularAvatar.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatefulWidget {
  ChatMessage(
      {@required this.text,
      @required this.name,
      @required this.type,
      this.setstate,
      this.displayMap,
      this.afterCardTitle = "",
      @required this.quickReply,
      this.rows,
      @required this.card,
      this.handleInput,
      this.hasMultipleTexts = false,
      this.showQuickReplies = false,
      this.multipleTexts,
      @required this.hideComposer,
      @required this.quickReplyMap});
  final String text;
  final String name;
  final bool type;
  final quickReply;
  final hideComposer;
  final displayMap;
  final rows;
  final String afterCardTitle;
  final List card;
  final setstate;
  final handleInput;
  final quickReplyMap;
  final hasMultipleTexts;
  final List multipleTexts;
  bool showQuickReplies;
  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  List splitArray(List arr, int len) {
    var chunks = [];
    for (var i = 0; i < arr.length; i += len) {
      chunks.add(arr.sublist(i, i + len > arr.length ? arr.length : i + len));
    }
    return chunks;
  }

  List wrapWithOneClickChip(List arr) {
    List oneClickChipArr = [];
    arr.forEach((element) {
      oneClickChipArr.add(OneClickChips(
          mapKey: element,
          displayMap: widget.displayMap,
          handleInput: widget.handleInput,
          quickReplyMap: widget.quickReplyMap));
    });
    return oneClickChipArr;
  }

  Widget makeDynamicRows(List chips, {int rowLength = 1}) {
    if (widget.showQuickReplies == false) {
      return SizedBox(
        height: 1,
      );
    }
    if (chips.length <= rowLength) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [...wrapWithOneClickChip(widget.quickReply)],
      );
    }
    List<Row> rows = [];
    List oneClickChipList = wrapWithOneClickChip(widget.quickReply);
    List splitList = splitArray(oneClickChipList, rowLength);
    for (int i = 0; i < splitList.length; i++) {
      List<OneClickChips> currentRowChildren = [...splitList[i]];
      rows.add(Row(children: currentRowChildren));
    }

    return Column(
      children: rows,
    );
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
        title: element.title,
        link: element.link,
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

  List<Widget> otherMessage(context) {
    double width = MediaQuery.of(context).size.width;
    return <Widget>[
      BotCircularAvatar(),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // new Text(this.widget.name,
            //     style: new TextStyle(fontWeight: FontWeight.bold)),
            Bubble(
              style: BubbleStyle(
                nip: BubbleNip.leftTop,
                nipOffset: 20,
                padding: BubbleEdges.all(15),
                color: Color(botBubbleColor),
                //elevation: 1 * px,
                margin: BubbleEdges.only(top: 8.0, right: 50.0),
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
            SizedBox(
              height: 15,
            ),
            widget.card.length > 0 == true
                ? makeLinkCards(widget.card)
                : SizedBox(
                    height: 0.5,
                  ),
            widget.card.length > 0 == true
                ? Bubble(
                    style: BubbleStyle(
                      nip: BubbleNip.leftTop,
                      nipOffset: 20,
                      padding: BubbleEdges.all(15),
                      color: Color(botBubbleColor),
                      //elevation: 1 * px,
                      margin: BubbleEdges.only(top: 8.0, right: 50.0),
                      alignment: Alignment.topLeft,
                    ),
                    child: new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        widget.afterCardTitle,
                        style: TextStyle(fontSize: width < 700 ? 12 : 15),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 0.01,
                  ),
            widget.showQuickReplies == true
                ? makeDynamicRows(widget.quickReply, rowLength: 1)
                : SizedBox(
                    height: 1,
                  )
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    double width = MediaQuery.of(context).size.width;
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // new Text(this.widget.name,
            //     style: Theme.of(context).textTheme.subtitle1),
            Bubble(
              style: BubbleStyle(
                nip: BubbleNip.rightTop,
                color: Color(userBubbleColor),
                nipOffset: 20,
                padding: BubbleEdges.all(15),
                //elevation: 1 * px,
                margin: const BubbleEdges.only(top: 8.0, left: 50.0),
                alignment: Alignment.topRight,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(
                  widget.text,
                  style: TextStyle(fontSize: width < 700 ? 12 : 15),
                ),
              ),
            ),
          ],
        ),
      ),
      UserCircularAvatar(),
      // new Container(
      //   margin: const EdgeInsets.only(left: 16.0),
      //   child: new CircleAvatar(child: new Text(this.widget.name[0])),
      // ),
    ];
  }

  List<Widget> multipleTexts(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(
          radius: 30,
          backgroundColor: Color(botCircularAvatar),
        ),
      ),
      MultipleBubble(
        card: widget.card,
        afterCardTitle: widget.afterCardTitle,
        quickReply: widget.quickReply,
        showQuickReplies: widget.showQuickReplies,
        multipleTexts: widget.multipleTexts,
        hasAnimation: widget.showQuickReplies,
        makeDynamicRows: makeDynamicRows,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.type
            ? myMessage(context)
            : widget.hasMultipleTexts
                ? multipleTexts(context)
                : otherMessage(context),
      ),
    );
  }
}
