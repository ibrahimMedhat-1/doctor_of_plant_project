import 'package:flutter/material.dart';

class ChatBubleWidget extends StatelessWidget {
  const ChatBubleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 28, bottom: 28, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32)),
          color: Colors.grey,
        ),
        child: const Text(
          'i\'m a new user hellow hellow  ',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
