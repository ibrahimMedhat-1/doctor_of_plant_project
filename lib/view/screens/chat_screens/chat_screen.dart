import 'package:doctor_of_plant_project/view/screens/chat_screens/get_started_screen.dart';
import 'package:doctor_of_plant_project/view_model/utils/colors.dart';
import 'package:doctor_of_plant_project/view_model/utils/navigation.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        title: const Text('Chat With Us '),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chat.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Hello!',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'I\'m your personal assistant,',
                style: TextStyle(
                    color: Color(0xFF424242),
                    // fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
              const Text(
                'How can i help you ?',
                style: TextStyle(
                    color: Color(0xFF424242),
                    // fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
              const SizedBox(
                height: 70,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigation.pushAndReplacement(
                        context, const GetStartedScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(170, 50),
                      backgroundColor: Constants.primaryColor,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(22))),
                  child: const Text(
                    'let\'s chat',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
