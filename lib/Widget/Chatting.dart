import 'dart:ui';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class ChattingWidget extends StatefulWidget {
  @override
  _ChattingWidgetState createState() => _ChattingWidgetState();
}

class _ChattingWidgetState extends State<ChattingWidget> {
  final _controller = TextEditingController();

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
                Container(
                  height: 100,
                  color: Colors.yellow,
                  child: Center(
                    child: Text("Chat messages will appear here"),
                  ),
                ),
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
                    // send message by text
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
