import 'package:doctor_of_plant_project/firebase_options.dart';
import 'package:doctor_of_plant_project/view/screens/onboarding_screen.dart';
import 'package:doctor_of_plant_project/view/screens/profile/profile_cubit/profile_cubit.dart';
import 'package:doctor_of_plant_project/view_model/cubits/auth_cubit/auth_cubit.dart';
import 'package:doctor_of_plant_project/view_model/cubits/cart_cubit/cart_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Gemini.init(apiKey: 'AIzaSyAyq8J9URJd5YiOE02tS8bgnDPYwOrNr-I');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(
          create: (context) => ProfileCubit()..initialize(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doctor of Plant',
        home: OnboardingScreen(),
      ),
    );
  }
}
