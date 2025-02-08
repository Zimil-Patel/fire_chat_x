import 'package:fire_chat_x/model/user_model.dart';
import 'package:fire_chat_x/services/noti_services.dart';
import 'package:fire_chat_x/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'components/firebase_user_list_stream.dart';
import 'components/profile_circle_button.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHomeAppBar(context),
      body: FutureBuilder<UserModel?>(
        future: homeController.setCurrentUser(),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          } else if(snapshot.hasData){
            return const FirebaseUsersListStream();
          } else {
            return const Center(child: Text('Failed to fetch current user'),);
          }

        },
      ),
    );
  }

  AppBar _buildHomeAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Text(
        'Chats',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: height * 0.026,
              fontWeight: FontWeight.w500,
            ),
      ),
      leading: profileCircleButton(),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.camera_alt_outlined),
        ),
        IconButton(
          onPressed: () {
            NotiServices.notiServices.showNotification();
          },
          icon: const Icon(Icons.notifications_active_outlined),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

