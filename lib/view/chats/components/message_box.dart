import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_x/model/chat_model.dart';
import 'package:fire_chat_x/utils/constants.dart';
import 'package:fire_chat_x/view/chats/components/show_menu_option_for_receiver_message.dart';
import 'package:fire_chat_x/view/chats/components/show_menu_options.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../main.dart';
import '../../../services/firestore_services.dart';
import '../chats_screen.dart';

class MessageBox extends StatelessWidget {
  MessageBox({
    super.key,
    required this.chat,
    required this.isLastMsg,
  });

  final GlobalKey containerKey = GlobalKey();
  final ChatModel chat;
  final bool isLastMsg;

  @override
  Widget build(BuildContext context) {
    FireStoreServices.fireStoreServices.markMessageAsSeen(homeController.currentUser!.email!, chatController.receiver!.email!);

    final bool isSender = chat.sender == homeController.currentUser!.email!;
    final alignment = isSender ? Alignment.centerRight : Alignment.centerLeft;
    final margin = isSender
        ? const EdgeInsets.only(bottom: defPadding / 1.2, left: defPadding * 4)
        : const EdgeInsets.only(
            bottom: defPadding / 1.2, right: defPadding * 4);
    final time = getTimeFormat(chat.time);

    return GestureDetector(
      onLongPressStart: (details) {
        isSender
            ? showPopupMenu(context, chat, containerKey)
            : showPopupMenuForReceiverMsg(context, chat, containerKey);
      },
      child: Align(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            // MESSAGE AND TIME
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 120),
              child: Container(
                key: containerKey,
                margin: margin,
                padding: EdgeInsets.symmetric(
                  vertical: defPadding / 2,
                  horizontal: chat.isImage ? defPadding / 2 : defPadding,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSender ? Colors.blueAccent : Theme.of(context).cardColor,
                ),
                child: chat.isImage
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: chat.message,
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url, progress) => const CircularProgressIndicator(),
                                useOldImageOnUrlChange: true,
                              )),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            time,
                            style:
                                Theme.of(context).textTheme.displayMedium!.copyWith(
                                      fontSize: height * 0.012,
                                      fontWeight: FontWeight.w900,
                                    ),
                          )
                        ],
                      )
                    : Stack(
                        children: [
                          // Message Text
                          Padding(
                            padding: EdgeInsets.only(bottom: height * 0.02),
                            // Space for time
                            child: Text(
                              chat.message,
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontSize: height * 0.018,
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                          ),
                          // Time Text
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Row(
                              children: [
                                Text(
                                  time,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        fontSize: height * 0.012,
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            // DELIVERED OR NOT STATUS
            if(chat.sender == homeController.currentUser!.email && isLastMsg)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(chat.isSeen ? 'Read' : 'Delivered'),
                  const SizedBox(width: 4,),
                  Icon(chat.isSeen ? Icons.done_all_rounded : Icons.done_rounded, size: 12, color: chat.isSeen ? Colors.blueAccent : Colors.grey,),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class MessageAndTime extends StatelessWidget {
  const MessageAndTime({
    super.key,
    required this.chat,
    required this.time,
  });

  final ChatModel chat;
  final dynamic time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            chat.message,
            textAlign: TextAlign.start,
            softWrap: true,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: height * 0.018,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),

        // TIME OF THE MESSAGE
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            time,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: height * 0.012,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ),
      ],
    );
  }
}

// CONVERT TIME STAMP INTO HOUR
getTimeFormat(Timestamp timeStamp) {
  final format = DateFormat("jm");
  return format.format(timeStamp.toDate());
}
