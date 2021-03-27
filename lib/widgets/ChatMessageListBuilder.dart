import 'package:bot/widgets/ChatMessage.dart';
import 'package:flutter/material.dart';

class ChatMessageListBuilder extends StatelessWidget {
  const ChatMessageListBuilder({
    Key key,
    @required List<ChatMessage> messages,
  })  : _messages = messages,
        super(key: key);

  final List<ChatMessage> _messages;

  @override
  Widget build(BuildContext context) {
    return new Flexible(
        child: new ListView.builder(
      padding: new EdgeInsets.all(8.0),
      reverse: true,
      itemBuilder: (_, int index) {
        if (index == 0) {
          return _messages[index]..showQuickReplies = true;
        }
        return _messages[index]..showQuickReplies = false;
      },
      itemCount: _messages.length,
    ));
  }
}
