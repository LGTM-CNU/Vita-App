import 'package:flutter/material.dart';

class ChattingWidget extends StatefulWidget {
  @override
  _ChattingWidgetState createState() => _ChattingWidgetState();
}

class _ChattingWidgetState extends State<ChattingWidget> {
  final _controller = TextEditingController();

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
                  onPressed: () {
                    // send message by voice
                  },
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
