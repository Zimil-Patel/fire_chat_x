import 'package:cached_network_image/cached_network_image.dart';
import 'package:fire_chat_x/controller/home_controller.dart';
import 'package:fire_chat_x/utils/constants.dart';
import 'package:fire_chat_x/view/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhotoSection extends StatelessWidget {
  const ProfilePhotoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _showUpdateProfilePhotoOptions(context);
        },
        child: SizedBox(
          // color: Colors.white,
          height: 100,
          width: 100,
          child: Stack(
            children: [
              GetBuilder<HomeController>(
                builder: (controller) => CircleAvatar(
                  radius: height * 0.06,
                  backgroundColor: Colors.grey,
                  child: controller.currentUser!.photoURL == null
                      ? Icon(
                          Icons.person,
                          color: Colors.white,
                          size: height * 0.06,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: controller.currentUser!.photoURL!,
                            fit: BoxFit.cover,
                            useOldImageOnUrlChange: true,
                            height: 100,
                            width: 100,
                          ),
                        ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_showUpdateProfilePhotoOptions(BuildContext context) {
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
                Navigator.pop(context);
                await homeController
                    .pickProfilePictureImage(ImageSource.gallery);
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
                Navigator.pop(context);
                await homeController
                    .pickProfilePictureImage(ImageSource.camera);
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
