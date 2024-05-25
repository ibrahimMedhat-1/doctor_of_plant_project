// import 'dart:developer';
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../../models/chatbot_model.dart';
//
// part 'chatbot_state.dart';
//
// class ChatbotCubit extends Cubit<ChatbotState> {
//   ChatbotCubit() : super(ChatbotInitial());
//
//   static ChatbotCubit get(context) => BlocProvider.of(context);
//   final Gemini gemini = Gemini.instance;
//
//   List<ChatMessage> chatMessage = [];
//   List<ChatMessage> reversedChatMessage = [];
//   final TextEditingController messageController = TextEditingController();
//   ScrollController scrollController = ScrollController();
//   bool isTyping = false;
//
//   void sendMessage(String message) async {
//     chatMessage.add(ChatMessage(text: message, isUser: true));
//     reversedChatMessage = chatMessage.reversed.toList();
//     isTyping = true;
//     emit(SendChatBotMessageLoading());
//
//     await gemini.text(message).then((value) {
//       chatMessage.add(ChatMessage(text: value!.output!, isUser: false));
//       isTyping = false;
//       scrollController.animateTo(
//         scrollController.position.minScrollExtent,
//         duration: const Duration(milliseconds: 1),
//         curve: Curves.bounceIn,
//       );
//     });
//     reversedChatMessage = chatMessage.reversed.toList();
//     emit(SendMessage());
//   }
//   void _sendMediaMessage() async {
//     ImagePicker picker = ImagePicker();
//     XFile? file = await picker.pickImage(source: ImageSource.gallery);
//     if (file != null) {
//       ChatMessage chatMessage = ChatMessage(
//           user: currentUser,
//           createdAt: DateTime.now(),
//           text: "Describe this picture",
//           medias: [
//             ChatMedia(url: file.path, fileName: "", type: MediaType.image)
//           ]);
//       _sendMessage(chatMessage);
//     }
//   }
//
//
//
//
// }