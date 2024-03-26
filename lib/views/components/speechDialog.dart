import 'package:app_leohis/views/utils/contants.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechDialog extends StatefulWidget {
  const SpeechDialog({
    super.key,
  });

  @override
  State<SpeechDialog> createState() => _SpeechDialogState();
}

class _SpeechDialogState extends State<SpeechDialog> {
  String text = '';
  bool isListening = false;
  SpeechToText speechToText = SpeechToText();
  String displayText = '';
  @override
  void dispose() {
    speechToText.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: screen(context).height / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(isListening ? displayText : text),
            AvatarGlow(
              endRadius: 60,
              animate: isListening,
              glowColor: primaryColor,
              duration: Duration(milliseconds: 1000),
              repeatPauseDuration: Duration(milliseconds: 200),
              showTwoGlows: true,
              repeat: true,
              child: GestureDetector(
                  onTapDown: (_) async {
                    try {
                      if (!isListening) {
                        var available = await speechToText.initialize();
                        if (available) {
                          setState(() {
                            isListening = true;
                            speechToText.listen(
                              onResult: (result) {
                                try {
                                  setState(() {
                                    displayText =
                                        '${text} ${result.recognizedWords}';
                                  });
                                } catch (e) {}
                              },
                            );
                          });
                        }
                      }
                    } catch (e) {}
                  },
                  onTapUp: (_) async {
                    try {
                      setState(() {
                        text = displayText;
                        isListening = false;
                      });
                    } catch (e) {}

                    await speechToText.stop();
                  },
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.mic,
                      color: themeModeColor,
                      size: 30,
                    ),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '(Ấn giữ)',
                  style: TextStyle(color: primaryColor),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(text);
            },
            child: Text("Đồng ý"))
      ],
    );
  }
}

// ignore: must_be_immutable
class RowField extends StatelessWidget {
  RowField({
    super.key,
    required this.textField,
    required this.title,
    required this.unit,
  });
  String title;
  TextEditingController textField;
  String unit;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(width: 120, child: Text(title)),
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: textField,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        Container(
            width: 60,
            margin: EdgeInsets.only(left: 10),
            child: Text(
              unit,
              style: TextStyle(fontSize: 13, color: primaryColor),
            )),
      ],
    );
  }
}
