import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final bool isMe;
  final String message;

  ChatMessage({required this.isMe, required this.message});

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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            "https://picsum.photos/id/1005/35/35",
                          ),
                        ),
                      ),
                    ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Container(
                      width: double.infinity,
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text(
                        "12:30 PM",
                        style: TextStyle(
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
        ));
  }
}
