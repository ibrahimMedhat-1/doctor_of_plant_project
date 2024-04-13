import 'package:doctor_of_plant_project/view/screens/sign_in_screen.dart';
import 'package:doctor_of_plant_project/view_model/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../view_model/cubits/auth_cubit/auth_cubit.dart';
import '../components/custom_text_field.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        final AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/signup.png',
                      scale: 5,
                    ),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextfield(
                      obscureText: false,
                      hintText: 'Enter Full name',
                      icon: Icons.person,
                      controller: cubit.fullNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please insert your name';
                        }
                        return null;
                      },
                    ),
                    CustomTextfield(
                      obscureText: false,
                      hintText: 'Enter Email',
                      icon: Icons.alternate_email,
                      controller: cubit.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please insert your email';
                        }
                        return null;
                      },
                    ),
                    CustomTextfield(
                      obscureText: true,
                      hintText: 'Enter Password',
                      icon: Icons.lock,
                      controller: cubit.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please insert your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    state is CreateAccountLoading
                        ? const Center(child: CircularProgressIndicator())
                        : GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.signUp(context);
                              }
                            },
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Constants.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: const Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('OR'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   width: size.width,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: Constants.primaryColor),
                    //       borderRadius: BorderRadius.circular(10)),
                    //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: [
                    //       SizedBox(
                    //         height: 30,
                    //         child: Image.asset('assets/images/google.png'),
                    //       ),
                    //       Text(
                    //         'Sign Up with Google',
                    //         style: TextStyle(
                    //           color: Constants.blackColor,
                    //           fontSize: 18.0,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            PageTransition(child: const SignIn(), type: PageTransitionType.bottomToTop));
                      },
                      child: Center(
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: 'Have an Account? ',
                              style: TextStyle(
                                color: Constants.blackColor,
                              ),
                            ),
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                color: Constants.primaryColor,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
