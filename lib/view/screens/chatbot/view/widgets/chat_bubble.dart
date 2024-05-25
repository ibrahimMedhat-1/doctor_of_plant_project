import 'package:flutter/material.dart';

import '../../../../../models/chatbot_model.dart';
import '../../../../../view_model/utils/colors.dart';


class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) // Display user avatar
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: CircleAvatar(
                backgroundColor: Constants.primaryColor,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width + 0.7),
                decoration: BoxDecoration(
                    color: message.isUser ? Colors.black87 : Constants.primaryColor,
                    borderRadius: !message.isUser
                        ? const BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )
                        : const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )),
                child: message.imageUrl != null // Check for image URL
                    ? Image.network(
                  message.imageUrl!, // Display image
                  fit: BoxFit.cover,
                  width: double.infinity, // Adjust width as needed
                )
                    : Text( // Display text if no image
                  message.text,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          if (message.isUser) // Display user avatar (optional)
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0, left: 5),
              child: CircleAvatar(
                backgroundColor: Constants.primaryColor,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
