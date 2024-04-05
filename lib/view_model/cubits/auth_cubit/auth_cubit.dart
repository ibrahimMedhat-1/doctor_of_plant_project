import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_of_plant_project/models/user_model.dart';
import 'package:doctor_of_plant_project/view/screens/root_page.dart';
import 'package:doctor_of_plant_project/view_model/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

import '../../../view/screens/sign_in_screen.dart';
import '../../utils/navigation.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signUp(context) async {
    emit(CreateAccountLoading());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text)
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .set(UserModel(
            id: value.user!.uid,
            image: '',
            name: fullNameController.text,
            email: emailController.text,
          ).toMap())
          .then((value) {
        emailController.clear();
        passwordController.clear();
        fullNameController.clear();
        Navigation.pushAndReplacement(context, const SignIn());
        emit(CreateAccountSuccess());
      });
    }).catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString());
      emit(CreateAccountError());
    });
  }

  void login(context) async {
    emit(SignInLoading());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text)
        .then((value) async {
      await FirebaseFirestore.instance.collection('users').doc(value.user!.uid).get().then((value) {
        Constants.userModel = UserModel.fromJson(value.data());
        emit(SignInSuccess());
        Navigator.pushReplacement(
          context,
          PageTransition(child: const RootPage(), type: PageTransitionType.bottomToTop),
        );
      }).catchError((onError) {
        Fluttertoast.showToast(msg: onError.toString());
        emit(SignInError());
      });
    }).catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString());
      emit(SignInError());
    });
  }
}
