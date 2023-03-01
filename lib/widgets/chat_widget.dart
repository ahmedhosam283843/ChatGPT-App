import 'package:chatgpt_app/constants/constants.dart';
import 'package:chatgpt_app/services/assests_manager.dart';
import 'package:chatgpt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.chatIndex, required this.msg});

  final int chatIndex;
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.asset(
                chatIndex == 0 ? AssetManager.userImage : AssetManager.botImage,
                height: 30,
                width: 30,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(child: TextWidget(label: msg)),
              chatIndex == 0
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          color: Colors.white,
                          Icons.thumb_up_alt_outlined,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.thumb_down_alt_outlined, color: Colors.white)
                      ],
                    ),
            ]),
          ),
        )
      ],
    );
  }
}
