import 'package:flutter/material.dart';

import 'package:vita/Widget/ChatMessage.dart';
import 'package:vita/Widget/Recorder.dart';
import 'package:vita/Util/date.dart';

class ChattingWidget extends StatefulWidget {
  @override
  _ChattingWidgetState createState() => _ChattingWidgetState();
}

class _ChattingWidgetState extends State<ChattingWidget> {
  final _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final _chattingMessages = [
    {'isMe': true, 'message': "123", 'time': "2023/02/01 12:30 PM"},
    {'isMe': false, 'message': 'from vita', 'time': "2023/02/01 02:01 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
    {'isMe': true, 'message': 'hello HJ', 'time': "2023/02/02 04:21 PM"},
  ];

  // aos => AndroidMainfest.xml과 ios => info.plist 추가 해야함
  _onMicPressHandler() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (context) {
          return Recorder();
        });
  }

  _onSubmitHandler() {
    if (_textController.text.isEmpty) {
      FocusScope.of(context).unfocus();
      return;
    }
    setState(() {
      _chattingMessages.add({
        'isMe': true,
        'message': _textController.text,
        'time': Date.serialize(DateTime.now()),
      });
    });
    _textController.clear();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Expanded(
                        child: Scrollbar(
                            controller: _scrollController,
                            child: ListView.builder(
                                controller: _scrollController, // 스크롤 컨트롤러
                                scrollDirection: Axis.vertical, // 리스트 스크롤 방향
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: _chattingMessages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ChatMessage(
                                      isMe: _chattingMessages[index]['isMe']
                                          as bool,
                                      message: _chattingMessages[index]
                                          ['message'] as String,
                                      time: _chattingMessages[index]['time']
                                          as String);
                                }))),
                    Container(
                      height: 50,
                      color: Colors.grey[200],
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextField(
                              controller: _textController,
                              textInputAction: TextInputAction.go,
                              decoration: const InputDecoration(
                                hintText: "Enter a message",
                              ),
                              onSubmitted: (value) async {
                                _onSubmitHandler();
                              },
                            ),
                          )),
                          IconButton(
                            icon: const Icon(Icons.mic),
                            onPressed: _onMicPressHandler,
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: _onSubmitHandler,
                          ),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
