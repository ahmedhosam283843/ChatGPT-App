import 'package:chatgpt_app/constants/constants.dart';
import 'package:chatgpt_app/services/assests_manager.dart';
import 'package:chatgpt_app/widgets/chat_widget.dart';
import 'package:chatgpt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  bool _isTyping = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    backgroundColor: scaffoldBackgroundColor,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Flexible(
                                child: TextWidget(
                              label: "Chosen Model:",
                              fontSize: 16,
                            ))
                          ],
                        ),
                      );
                    });
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ))
        ],
        title: Text("ChatGPT"),
        elevation: 2,
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetManager.openaiLogo)),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatMessages[index]["msg"].toString(),
                    chatIndex:
                        int.parse(chatMessages[index]["chatIndex"].toString()),
                  );
                }),
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
              color: Colors.white,
              size: 18,
            ),
            SizedBox(
              height: 15,
            ),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: textEditingController,
                      onSubmitted: (value) {
                        // Todo: Submit message
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: "How can I help you?",
                          hintStyle: TextStyle(color: Colors.grey)),
                    )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          ]
        ],
      )),
    );
  }
}
