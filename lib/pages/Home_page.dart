import 'package:chatter/components/User_tile.dart';
import 'package:chatter/services/auth_service.dart';
import 'package:chatter/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

import '../components/my_drawer.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  //getting chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        centerTitle: true,
      ),
      drawer: MyWidget(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        print("Snapshot state: ${snapshot.connectionState}");
        if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("Loading...");
          return Text("Loading..");
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print("No users found.");
          return Text("No users found.");
        }

        // Display the users
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    // Check for null values and provide default values if necessary
    final String? email = userData["email"];
    final String? uid = userData["uid"];

    // Debug prints
    print("User Data: $userData");
    if (email == null || uid == null) {
      print("Error: User data is missing required fields.");
      return Container();
    }

    // Display all users except the current user
    if (email != _authService.getCurrentUser()!.email) {
      return UserTile(
          text: email,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiveremail: email,
                  receiverID: uid,
                ),
              ),
            );
          });
    } else {
      return Container();
    }
  }
}
