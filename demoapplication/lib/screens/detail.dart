import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:demoapplication/model/languagedata.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

class Detail extends StatefulWidget {
  final LanguageData languageData;

  const Detail({Key? key, required this.languageData}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  AudioPlayer audioPlayer = AudioPlayer();
  FlutterSoundRecorder? _soundRecorder;
  bool isPlaying = false;
  bool isRecording = false;
  String? recordedFilePath;

  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _soundRecorder!.closeAudioSession();
    _soundRecorder = null;
    super.dispose();
  }

  Future<bool> _requestMicrophonePermission() async {
    var status = await Permission.microphone.request();
    return status.isGranted;
  }

  void playAudio(String audioUrl) async {
    if (isPlaying) {
      await audioPlayer.stop();
      setState(() {
        isPlaying = false;
      });
    } else {
      // Convert the audio URL (String) to Uri
      await audioPlayer.play(UrlSource(
          'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3'));
      setState(() {
        isPlaying = true;
      });
    }
  }

  void _onMicButtonPressed() async {
    if (isRecording) {
      await _stopRecording();
    } else {
      bool hasMicrophonePermission = await _requestMicrophonePermission();
      if (hasMicrophonePermission) {
        await _startRecording();
      } else {
        // Handle the case when the user denies microphone permission.
        // You can show a dialog or a snackbar informing the user about the necessity of the permission.
        // You may also redirect the user to the app settings to grant the permission manually.
      }
    }
  }

  Future<void> _startRecording() async {
    try {
      bool hasPermission = await _requestMicrophonePermission();
      if (hasPermission) {
        await _soundRecorder!.openAudioSession();
        String filePath =
            'recorded_audio.aac'; // Replace with your desired path and file extension
        await _soundRecorder!.startRecorder(toFile: filePath);
        setState(() {
          isRecording = true;
        });
      } else {
        // Handle the case when the user denies microphone permission.
        // You can show a dialog or a snackbar informing the user about the necessity of the permission.
        // You may also redirect the user to the app settings to grant the permission manually.
      }
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      if (isRecording) {
        String? filePath = await _soundRecorder!.stopRecorder();
        if (filePath != null) {
          setState(() {
            isRecording = false;
            recordedFilePath = filePath;
          });
        }
      }
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text(widget.languageData.englishText),
                trailing: IconButton(
                  onPressed: () {
                    playAudio(widget.languageData.englishAudio);
                  },
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                ),
              ),
              ListTile(
                title: Text(widget.languageData.hindiText),
                trailing: IconButton(
                  onPressed: () {
                    playAudio(widget.languageData.hindiAudio);
                  },
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              IconButton(
                onPressed: _onMicButtonPressed,
                icon: Icon(
                  isRecording ? Icons.stop : Icons.mic,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
