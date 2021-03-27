import 'package:bot/constants/ColorsConstants.dart';
import 'package:flutter/material.dart';

class TextComposer extends StatelessWidget {
  const TextComposer({
    Key key,
    @required this.context,
    @required this.isComposerHidden,
    @required TextEditingController textController,
    @required this.handleSubmitted,
    this.implicitResponse,
  })  : _textController = textController,
        super(key: key);

  final BuildContext context;
  final bool isComposerHidden;
  final TextEditingController _textController;
  final Function handleSubmitted;
  final String implicitResponse;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            color: Color(textComposerBackground)),
        // margin: const EdgeInsets.symmetric(
        //   horizontal: 8.0,
        // ),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: new TextField(
                  style: width < 700
                      ? TextStyle(
                          height: 1,
                          fontSize: 12,
                        )
                      : TextStyle(),
                  enabled: !isComposerHidden,
                  controller: _textController,
                  onSubmitted: (value) {
                    return handleSubmitted(func: value, displayText: value);
                  },
                  decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(homeScreenBlueColor)),
                          borderRadius: BorderRadius.circular(
                            20,
                          )),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Color(t)),
                      //   borderRadius: BorderRadius.circular(
                      //     20,
                      //   ),
                      // ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(homeScreenBlueColor)),
                          borderRadius: BorderRadius.circular(
                            20,
                          )),
                      focusColor: Color(homeScreenBlueColor),
                      hintText: "Send a message"),
                ),
              ),
            ),
            new Container(
              padding: EdgeInsets.all(20),
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      width > 700
                          ? EdgeInsets.only(
                              left: 30, right: 30, top: 20, bottom: 20)
                          : EdgeInsets.only(
                              left: 20, right: 20, top: 15, bottom: 15)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      // if (states.contains(MaterialState.pressed))
                      return Color(homeScreenBlueColor);
                      // return null; // Use the component's default.
                    },
                  ),
                ),
                child: Text(
                  "Send",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: isComposerHidden == true
                    ? null
                    : () {
                        if (implicitResponse == "") {
                          handleSubmitted(func: _textController.text);
                        } else {
                          handleSubmitted(
                              func: implicitResponse,
                              displayText: _textController.text);
                        }
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
