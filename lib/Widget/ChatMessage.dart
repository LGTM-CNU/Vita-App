import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String talker;
  final String message;
  final String time;
  final bool isMe;

  const ChatMessage(
      {super.key,
      required this.isMe,
      required this.talker,
      required this.message,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            isMe
                ? Container()
                : Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: talker == "vita"
                              ? const AssetImage("assets/vita-profile.png")
                              : const AssetImage("assets/user-profile.png"),
                        )),
                  ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    width: 130,
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    child: Text(
                      time,
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
