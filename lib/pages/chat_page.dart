import 'package:chatter/components/MyTextField.dart';
import 'package:chatter/components/chat_bubble.dart';
import 'package:chatter/services/auth_service.dart';
import 'package:chatter/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ChatPage extends StatefulWidget {
  final String receiveremail;
  final String receiverID;

  ChatPage({super.key,
    required this.receiveremail,
    required this.receiverID
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  FocusNode myFocusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode.addListener(() {
      if(myFocusNode.hasFocus){
        Future.delayed(Duration(milliseconds: 500), ()=> scrollDown(),
        );
      }
    });
    Future.delayed(Duration(milliseconds: 500),
        () => scrollDown(),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  }

  //send message
  void sendMessage() async{
    //if there is something to send
    if(_messageController.text.isNotEmpty){
      //send msg
      await _chatService.sendMessage(widget.receiverID, _messageController.text);
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiveremail),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(child: _buildMessageList(),
          ),

          //user input
          _buildUserInput(),
        ],
      ),
    );
  }

  //build mesg list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        //errors check
        if (snapshot.hasError) {
          return const Text("Error");
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        //return list view
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment = isCurrentUser ? Alignment.centerRight:Alignment.centerLeft;
    return Container(
      alignment: alignment,
        child: Column(
          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(isCurrentUser: isCurrentUser, message: data["message"])
          ],
        ));
  }

  //build message input
  Widget _buildUserInput(){
    return  Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Expanded(child: MyTextField(
            controller: _messageController,
            hintText: "Type a message", tf: false,
            focusNode: myFocusNode,
          ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle
            ),
              margin: EdgeInsets.only(right: 25),
              child: IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward,
              color: Colors.white,)))
        ],
      ),
    );
  }
}
