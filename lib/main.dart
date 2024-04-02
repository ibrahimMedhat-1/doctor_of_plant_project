import 'package:doctor_of_plant_project/view/screens/onboarding_screen.dart';
import 'package:doctor_of_plant_project/view_model/cubits/auth_cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyB1e8smNLlzIOREYfhPu-6QHeBf3sitbgM',
          appId: '1:88974985675:android:cca4e502adb274712f4e4e',
          messagingSenderId: '88974985675',
          projectId: 'flutterprpject'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('========User is currently signed out!========');
      } else {
        print('======User is signed in!======');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Onboarding Screen',
        home: OnboardingScreen(),
      ),
    );
  }
}
