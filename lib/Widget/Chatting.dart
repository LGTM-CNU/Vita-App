import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'package:vita/Widget/ChatMessage.dart';
import 'package:vita/Util/date.dart';

class ChattingWidget extends StatefulWidget {
  @override
  _ChattingWidgetState createState() => _ChattingWidgetState();
}

class _ChattingWidgetState extends State<ChattingWidget> {
  final _controller = TextEditingController();

  final _chattingMessages = [
    {'isMe': true, 'message': "123", 'time': "2023/02/01 12:30 PM"},
    {'isMe': false, 'message': 'from vita', 'time': "2023/02/01 02:01 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"}
  ];

  // aos => AndroidMainfest.xml과 ios => info.plist 추가 해야함
  _onMicPressHandler() async {
    print('mic !');
    try {
      PermissionStatus status = await Permission.microphone.request();

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
        body: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      for (var chatMessage in _chattingMessages) ...[
                        ChatMessage(
                          isMe: chatMessage['isMe'] as bool,
                          message: chatMessage['message'] as String,
                          time: chatMessage['time'] as String,
                        )
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
                          child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: "Enter a message",
                          ),
                        ),
                      )),
                      IconButton(
                        icon: const Icon(Icons.mic),
                        onPressed: _onMicPressHandler,
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          setState(() {
                            _chattingMessages.add({
                              'isMe': true,
                              'message': _controller.text,
                              'time': Date.serialize(DateTime.now()),
                            });
                          });
                          _controller.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
