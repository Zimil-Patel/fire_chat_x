import 'package:fire_chat_x/controller/image_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

final imageController = Get.put(ImageController());

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Request',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: height * 0.026,
                fontWeight: FontWeight.w500,
              ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),

      // body
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () =>  SizedBox(
                  height: 500,
                  width: 500,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child:Image.network(imageController.image.value, fit: BoxFit.cover,),
                  ),
                ),
              ),
            ),

            // PICK IMAGE
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: const Text(
                  'Pick Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () => imageController.pickImage(),
            ),
          ],
        ),
      ),
    );
  }
}
