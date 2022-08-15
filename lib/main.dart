import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:fire_and_ice/FireOrIceController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(FatemaApp());
}

class FatemaApp extends StatefulWidget {
  FireOrIceController fireOrIceController = Get.put(FireOrIceController());
  bool pickNewMode = false;

  @override
  _FatemaAppState createState() => _FatemaAppState();
}

class _FatemaAppState extends State<FatemaApp> {
  @override
  Widget build(BuildContext context) {
    widget.fireOrIceController.getFireOrIce();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fire or Ice?'),
          actions: [
            IconButton(onPressed: () {
              widget.fireOrIceController.fireOrIceModel.emoji = '';
              widget.fireOrIceController.getFireOrIce();
            }, icon: Icon(Icons.refresh))
          ],
        ),
        body: GetBuilder<FireOrIceController>(
          builder: (_) {
            // ignore: unnecessary_null_comparison
            if (_.fireOrIceModel.emoji.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return widget.pickNewMode
                ? EmojiPicker(
                    onEmojiSelected: (category, emoji) async {
                      print('Emoji is selected ' + emoji.emoji);
                      DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
                      _.fireOrIceModel.date = format.format(DateTime.now());
                      _.fireOrIceModel.emoji = emoji.emoji;

                      _.updateFireOrIce();

                      setState(() {
                        widget.pickNewMode = false;
                      });
                    },
                    config: Config(
                        columns: 7,
                        emojiSizeMax: 32.0,
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        initCategory: Category.RECENT,
                        bgColor: Color(0xFFF2F2F2),
                        indicatorColor: Colors.blue,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.blue,
                        progressIndicatorColor: Colors.blue,
                        showRecentsTab: true,
                        recentsLimit: 28,
                        noRecentsText: "No Recents",
                        noRecentsStyle: const TextStyle(
                            fontSize: 20, color: Colors.black26),
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.CUPERTINO),
                  )
                : Center(
                    child: TextButton(
                    onPressed: () {
                      setState(() {
                        widget.pickNewMode = true;
                      });
                    },
                    child: Text(
                      _.fireOrIceModel.emoji,
                      style: TextStyle(fontSize: 300),
                    ),
                  ));
          },
        ),
      ),
    );
  }
}
