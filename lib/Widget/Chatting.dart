import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:vita/Widget/ChatMessage.dart';
import 'package:vita/Widget/Recorder.dart';
import 'package:vita/Util/date.dart';

import '../Util/fetcher.dart';
import '../Util/user.dart';

class ChattingWidget extends StatefulWidget {
  const ChattingWidget({Key? key}) : super(key: key);

  @override
  ChattingWidgetState createState() => ChattingWidgetState();
}

class ChattingWidgetState extends State<ChattingWidget> {
  final _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  var _mode = 'USER';
  late final _userId;

  final _chattingMessages = <ChatMessage>[];

  _getChattingMessage() async {
    await _getUserInfo();
    final res = jsonDecode(
        (await Fetcher.fetch('get', '/api/v1/chat/$_userId', {})).body);

    setState(() {
      for (var chat in res) {
        _chattingMessages.add(ChatMessage(
            isMe: _userId == chat['talker'],
            message: chat['content'],
            talker: chat['talker'],
            time: Date.serialize(DateTime.parse(chat['createdAt'] as String))));
      }
    });
  }

  // aos => AndroidMainfest.xml과 ios => info.plist 추가 해야함
  _onMicPressHandler() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (context) {
          return Recorder(
            addChatMessage: addChatMessage,
          );
        });
  }

  addChatMessage(ChatMessage message) {
    setState(() {
      _chattingMessages.add(message);
    });
  }

  _onSubmitHandler(isVoice) async {
    if (_textController.text.isEmpty) {
      FocusScope.of(context).unfocus();
      return;
    }

    final patientId = jsonDecode(
        (await Fetcher.fetch("get", '/api/v1/user/relation/$_userId', {}))
            .body);

    final res = await Fetcher.fetch(
        'post',
        '/api/v1/chat',
        jsonEncode({
          "talker": _userId,
          "destination": patientId['userId'],
          "content": _textController.text,
          "medicineId": null,
          "alarmed": false,
          "userId": _userId,
          "isVoice": isVoice,
        }));

    setState(() {
      _chattingMessages.add(ChatMessage(
          isMe: true,
          talker: _userId,
          message: _textController.text,
          time: Date.serialize(DateTime.now())));
    });
    _textController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    FocusScope.of(context).unfocus();
  }

  _getUserInfo() async {
    final mode = await User.getUserMode();
    final id = await User.getUserId();
    setState(() {
      _mode = mode;
      _userId = id;
    });
  }

  @override
  void initState() {
    super.initState();
    _getChattingMessage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
            body: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  repeat: ImageRepeat.repeat,
                  opacity: 0.7,
                )),
                child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Expanded(
                            child: Scrollbar(
                                controller: _scrollController,
                                child: ListView.builder(
                                    controller: _scrollController, // 스크롤 컨트롤러
                                    scrollDirection:
                                        Axis.vertical, // 리스트 스크롤 방향
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: _chattingMessages.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _chattingMessages[index];
                                    }))),
                        if (_mode == "ADMIN")
                          Container(
                            height: 50,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextField(
                                    controller: _textController,
                                    textInputAction: TextInputAction.go,
                                    decoration: const InputDecoration(
                                      hintText: "메시지를 입력해주세요.",
                                    ),
                                    onSubmitted: (value) async {
                                      await _onSubmitHandler(null);
                                    },
                                  ),
                                )),
                                IconButton(
                                  icon: const Icon(Icons.mic),
                                  onPressed: _onMicPressHandler,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () async {
                                    await _onSubmitHandler(null);
                                  },
                                ),
                              ],
                            ),
                          )
                      ],
                    )))));
  }
}
