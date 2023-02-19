import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audio_session/audio_session.dart';

import 'package:vita/Util/Firebase.dart';

import '../Util/date.dart';
import '../Util/user.dart';
import 'ChatMessage.dart';

class Recorder extends StatefulWidget {
  final addChatMessage;
  const Recorder({super.key, required this.addChatMessage});
  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  final recorder = FlutterSoundRecorder();

  bool isRecorderReady = false;
  bool isRecord = false;
  bool finishRecorded = false;
  String path = "";
  var audioFile;
  late final userId;

  Future record() async {
    if (!isRecorderReady) return;
    var tempDir = await getTemporaryDirectory();
    path = '${tempDir.path}/audio.wav';

    await recorder.startRecorder(toFile: path, codec: Codec.pcm16WAV);

    setState(() {
      isRecord = true;
      audioFile = null;
    });

    print("record start !!!!!!!!!!!!!!!!");
  }

  Future stop() async {
    if (!isRecorderReady) return;
    await recorder.stopRecorder();

    print('===============$path==================');

    setState(() {
      isRecord = false;
      finishRecorded = true;
      audioFile = File(path!);
    });
  }

  Future send() async {
    if (audioFile == null) return;

    print('============== $audioFile =================');

    await Firebase.save(audioFile);

    widget.addChatMessage(ChatMessage(
        isMe: true,
        talker: userId,
        message: "음성 메세지 입니다.",
        time: Date.serialize(DateTime.now())));
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw "Microphone permission not granted";
    } else {
      print("======================micro phone granted=====================");
    }

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: false,
    ));

    print("before open recorder");
    await recorder.openRecorder();

    print("after open recorder");

    isRecorderReady = true;

    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  _getRecordIcon() {
    if (isRecord) return (Icons.stop);
    if (!finishRecorded) return (Icons.mic);
    return Icons.replay;
  }

  _getUserId() async {
    final id = await User.getUserId();
    userId = id;
  }

  @override
  void initState() {
    super.initState();
    initRecorder();
    _getUserId();
  }

  @override
  void dispose() {
    recorder.closeRecorder();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<RecordingDisposition>(
              stream: recorder.onProgress,
              builder: (context, snapshot) {
                var duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;

                print('test: ${duration.inSeconds} ${snapshot.data}');
                return Text(
                  '${duration.inSeconds}s',
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  "취소",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                child: Icon(
                  _getRecordIcon(),
                  size: 40,
                ),
                onPressed: () async {
                  if (isRecord) {
                    await stop();
                  } else {
                    await record();
                  }
                },
              ),
              const Spacer(),
              ElevatedButton(
                child: const Icon(
                  Icons.send,
                  size: 40,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        audioFile == null ? Colors.grey : Colors.orange),
                onPressed: () async {
                  await send();
                  Navigator.of(context).pop();
                },
              ),
              const Spacer(),
            ],
          )
        ],
      )),
    );
  }
}
