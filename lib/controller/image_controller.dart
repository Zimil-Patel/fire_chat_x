import 'dart:developer';
import 'dart:typed_data';

import 'package:fire_chat_x/services/api_services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController{
  RxString image = "https://www.techsmith.com/blog/wp-content/uploads/2023/08/What-are-High-Resolution-Images.png".obs;

  // PICK IMAGE
  Future<void> pickImage() async {
    ImagePicker picker = ImagePicker();
    final XFile? data = await picker.pickImage(source: ImageSource.gallery);
    try{
      final Uint8List byteImage = await data!.readAsBytes();
      log("image pick success...");
      image.value = await ApiServices.apiServices.postImage(byteImage);
    } catch(e) {
      log("image pick failed!!!");
    }
  }
}