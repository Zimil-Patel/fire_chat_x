import 'package:fire_chat_x/utils/constants.dart';
import 'package:fire_chat_x/view/chats/chats_screen.dart';
import 'package:fire_chat_x/view/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.add,
          size: 24,
        ),
      ),
      onPressed: () {
        showMediaOptions(context);
      },
    );
  }
}

showMediaOptions(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: defPadding * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            // GALLERY
            GestureDetector(
              onTap: () async {
                await chatController.pickImage(ImageSource.gallery, homeController.currentUser!.email!);
                Navigator.pop(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.photo_library_sharp,
                      color: Colors.green.shade300,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text('Gallery'),
                ],
              ),
            ),

            // CAMERA
            GestureDetector(
              onTap: () async {
                await chatController.pickImage(ImageSource.camera, homeController.currentUser!.email!);
                Navigator.pop(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text('Camera'),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
