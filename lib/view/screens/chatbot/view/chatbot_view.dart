import 'package:doctor_of_plant_project/view/screens/chatbot/view/widgets/chat_bubble.dart';
import 'package:doctor_of_plant_project/view/screens/chatbot/view/widgets/typing_indicator.dart';
import 'package:doctor_of_plant_project/view_model/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/chatbot_cubit.dart';

class ChatBotPage extends StatelessWidget {
  final String? search;
  const ChatBotPage({super.key, this.search});

  static final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    if (search != null) {
      ChatbotCubit.get(context).sendMessage('what is $search');
    }
    return BlocConsumer<ChatbotCubit, ChatbotState>(
      listener: (context, state) {},
      builder: (context, state) {
        ChatbotCubit cubit = ChatbotCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/icons8-chatgpt-64.png",
                  scale: 2,
                ),
                const SizedBox(
                  width: 2,
                ),
                const Text("Chatbot"),
                const SizedBox(
                  width: 2,
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: cubit.scrollController,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final message = cubit.reversedChatMessage[index];
                    return ChatBubble(
                      text: message.text,
                      isUser: message.isUser,
                    );
                  },
                  itemCount: cubit.reversedChatMessage.length,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: TypingIndicator(
                  showIndicator: cubit.isTyping,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: cubit.messageController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Send Message",
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.sendMessage(cubit.messageController.text);
                              cubit.messageController.clear();
                            }
                          },
                          icon: const Icon(Icons.send),
                        ),
                        errorStyle: const TextStyle(height: 0),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Constants.primaryColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Constants.primaryColor,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Constants.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
