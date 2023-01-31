import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'package:vita/Widget/ChatMessage.dart';

class ChattingWidget extends StatefulWidget {
  @override
  _ChattingWidgetState createState() => _ChattingWidgetState();
}

class _ChattingWidgetState extends State<ChattingWidget> {
  final _controller = TextEditingController();

  var _chattingMessages = [
    {'isMe': true, 'message': "123"},
    {'isMe': false, 'message': 'from vita'},
    {'isMe': true, 'message': 'hello HJ'}
  ];

  // aos => AndroidMainfest.xml과 ios => info.plist 추가 해야함
  _onMicPressHandler() async {
    print('mic !');
    try {
      PermissionStatus status = await Permission.microphone.request();
      PermissionStatus status1 = await Permission.notification.request();

      if (status == PermissionStatus.granted) {
        print('allow !');
      } else {
        print('not allowed');
      }
    } on RecordingPermissionException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              for (var chatMessage in _chattingMessages) ...[
                ChatMessage(
                    isMe: chatMessage['isMe'] as bool,
                    message: chatMessage['message'] as String)
              ]
            ],
          ),
        ),
        Container(
          height: 50,
          color: Colors.grey[200],
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Enter a message",
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.mic),
                onPressed: _onMicPressHandler,
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  setState(() {
                    _chattingMessages.add({
                      'isMe': true,
                      'message': _controller.text,
                    });
                  });
                  _controller.clear();
                },
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
