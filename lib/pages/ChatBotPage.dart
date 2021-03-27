import 'package:bot/models/LinkCard.dart';
import 'package:bot/models/QuickReply.dart';
import 'package:bot/widgets/ChatMessage.dart';
import 'package:bot/widgets/ChatMessageListBuilder.dart';
import 'package:bot/widgets/TextComposer.dart';
import 'package:bot/widgets/TypingBubbleRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageDialogflowV2 extends StatefulWidget {
  const HomePageDialogflowV2({Key key, this.title}) : super(key: key);
  static String routeName = "/bot";
  final String title;

  @override
  _HomePageDialogflowV2 createState() => new _HomePageDialogflowV2();
}

class _HomePageDialogflowV2 extends State<HomePageDialogflowV2> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool implicitTextComposer = false;
  bool isComposerHidden = false;
  bool isBotTyping = false;
  String implicitText = "";
  void hideTextComposer() {
    setState(() {
      isComposerHidden = true;
    });
  }

  void updateImplicitText(AIResponse response) {
    if (checkForImplicitResponse(response)) {
      implicitText =
          response.getListMessage().toList()[1]["payload"]["implicit"];
      implicitTextComposer = true;
    } else {
      implicitText = "";
      implicitTextComposer = false;
    }
  }

  void Response(query) async {
    setState(() {
      isBotTyping = true;
    });
    _textController.clear();

    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "Add your asset file here")
            .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);

    QuickReply qr = new QuickReply(response.getListMessage().toList());

    updateImplicitText(response);
    updateBotMessage(qr: qr, response: response);
    setState(() {
      isBotTyping = false;
    });
  }

  void _handleSubmitted({String displayText = "", String func}) {
    if (_textController.text.isEmpty && isComposerHidden == false) {
      return;
    }
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: displayText == "" ? func : displayText,
      name: "You",
      handleInput: _handleSubmitted,
      type: true,
      card: [LinkCard(link: "www.google.com", title: "HEY")],
      quickReply: [],
      quickReplyMap: {},
      displayMap: {},
      hideComposer: hideTextComposer,
    );
    setState(() {
      _messages.insert(0, message);
    });

    if (implicitText != "") {
      Response(implicitText);
      implicitText = "";
    } else {
      Response(func);
      implicitText = "";
    }
  }

  bool checkForMultipleTexts(AIResponse response) {
    try {
      return response.getListMessage().toList()[0]["text"]["text"].length ==
              1 &&
          response.getListMessage().toList()[1]["payload"]["multiple"].length >
              0;
    } catch (e) {
      return false;
    }
  }

  bool checkForImplicitResponse(AIResponse response) {
    try {
      return response.getListMessage().toList()[1]["payload"]["implicit"] !=
          null;
    } catch (e) {
      return false;
    }
  }

  void updateBotMessage({AIResponse response, QuickReply qr}) {
    ChatMessage message;

    if (checkForMultipleTexts(response) == true) {
      message = ChatMessage(
          text: "text",
          name: "Chirp",
          type: false,
          card: qr.card,
          afterCardTitle: qr.afterCardTitle,
          quickReply: qr.suggestions,
          quickReplyMap: qr.onClick,
          handleInput: _handleSubmitted,
          multipleTexts: response.getListMessage().toList()[1]["payload"]
              ["multiple"],
          displayMap: qr.displayMap,
          hasMultipleTexts: true,
          setstate: setState,
          hideComposer: hideTextComposer,
          rows: qr.rows);
    } else {
      message = ChatMessage(
          text: response.getMessage() ??
              new TypeMessage(response.getListMessage()[0]).platform,
          name: "Chirp",
          type: false,
          afterCardTitle: qr.afterCardTitle,
          card: qr.card,
          quickReply: qr.suggestions,
          quickReplyMap: qr.onClick,
          displayMap: qr.displayMap,
          handleInput: _handleSubmitted,
          setstate: setState,
          hideComposer: hideTextComposer,
          rows: qr.rows);
    }
    if (qr.suggestions.length > 0) {
      setState(() {
        isComposerHidden = true;
        _messages.insert(0, message);
      });
    } else {
      setState(() {
        isComposerHidden = false;
        _messages.insert(0, message);
      });
    }
  }

  void sayHello() async {
    final sp = await SharedPreferences.getInstance();
    String name = sp.getString("chirpUserName");
    // List<LinkCard> lc = [
    //   LinkCard(link: "www.google.com", title: "HEY"),
    //   LinkCard(link: "www.google.com", title: "HEY"),
    //   LinkCard(link: "www.google.com", title: "HEY"),
    //   LinkCard(link: "www.google.com", title: "HEY"),
    //   LinkCard(link: "www.google.com", title: "HEY"),
    //   LinkCard(link: "www.google.com", title: "HEY"),
    //   LinkCard(link: "www.google.com", title: "HEY"),
    //   LinkCard(link: "www.google.com", title: "HEY"),
    //   LinkCard(link: "www.google.com", title: "HEY")
    // ];
    ChatMessage message = new ChatMessage(
      hideComposer: hideTextComposer,
      text: name == "unknown" ? "Hello there !" : "Hello $name!",
      name: "Chirp",
      type: false,
      handleInput: _handleSubmitted,
      setstate: setState,
      card: [],
      quickReply: [],
      quickReplyMap: {},
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  void initState() {
    sayHello();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(children: <Widget>[
        ChatMessageListBuilder(messages: _messages),
        isBotTyping
            ? Container(
                margin: EdgeInsets.only(left: 10, bottom: 25),
                child: TypingBubbleRow())
            : SizedBox(
                width: 0.01,
              ),
        Visibility(
          visible: !isComposerHidden,
          child: TextComposer(
              handleSubmitted: _handleSubmitted,
              context: context,
              implicitResponse: implicitText,
              isComposerHidden: isComposerHidden,
              textController: _textController),
        ),
      ]),
    );
  }
}
