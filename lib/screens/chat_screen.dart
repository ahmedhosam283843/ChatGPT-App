import 'dart:developer';

import 'package:chatgpt_app/constants/constants.dart';
import 'package:chatgpt_app/models/chat_model.dart';
import 'package:chatgpt_app/services/api_sevices.dart';
import 'package:chatgpt_app/services/assests_manager.dart';
import 'package:chatgpt_app/services/services.dart';
import 'package:chatgpt_app/widgets/chat_widget.dart';
import 'package:chatgpt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../providers/models_providers.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ScrollController _scrollController;
  late FocusNode focusNode;
  late TextEditingController textEditingController;

  @override
  void initState() {
    _scrollController = ScrollController();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    focusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];

  bool _isTyping = false;
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await Services.showModalSheet(context: context);
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
                controller: _scrollController,
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatList[index].msg,
                    chatIndex: chatList[index].chatIndex,
                  );
                }),
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
              color: Colors.white,
              size: 18,
            ),
          ],
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
                    focusNode: focusNode,
                    style: TextStyle(color: Colors.white),
                    controller: textEditingController,
                    onSubmitted: (value) async {
                      await sendMessagesFCT(modelsProvider: modelsProvider);
                    },
                    decoration: InputDecoration.collapsed(
                        hintText: "How can I help you?",
                        hintStyle: TextStyle(color: Colors.grey)),
                  )),
                  IconButton(
                      onPressed: () async {
                        await sendMessagesFCT(modelsProvider: modelsProvider);
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Future<void> sendMessagesFCT({required ModelsProvider modelsProvider}) async {
    try {
      setState(() {
        chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
        _isTyping = true;
        focusNode.unfocus();
        textEditingController.clear();
      });
      chatList.addAll(await ApiService.sendMessage(
          message: textEditingController.text,
          modelId: modelsProvider.getCurrentModel));
      setState(() {});
    } catch (error) {
      log("error message: error");
    } finally {
      scrollListToEnd();
      _isTyping = false;
    }
  }

  void scrollListToEnd() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.easeOut);
  }
}
