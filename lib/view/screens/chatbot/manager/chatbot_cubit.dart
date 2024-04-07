import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../../../../models/chatbot_model.dart';

part 'chatbot_state.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  ChatbotCubit() : super(ChatbotInitial());

  static ChatbotCubit get(context) => BlocProvider.of(context);
  List<ChatMessage> chatMessage = [];
  List<ChatMessage> reversedChatMessage = [];
  final TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool isTyping = false;
  // String myApiKey = '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';

  void sendMessage(String message) async {
    chatMessage.add(ChatMessage(text: message, isUser: true));
    reversedChatMessage = chatMessage.reversed.toList();
    isTyping = true;
    emit(SendChatBotMessageLoading());
    final gemini = Gemini.instance;

    await gemini.text(message).then((value) {
      chatMessage.add(ChatMessage(text: value!.output!, isUser: false));
      isTyping = false;
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 1),
        curve: Curves.bounceIn,
      );
    })

        /// or value?.content?.parts?.last.text
        .catchError((e) => print(e));
    reversedChatMessage = chatMessage.reversed.toList();
    emit(SendMessage());
  }
}
