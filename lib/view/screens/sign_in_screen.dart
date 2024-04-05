import 'package:doctor_of_plant_project/view/screens/sign_up_screen.dart';
import 'package:doctor_of_plant_project/view_model/cubits/auth_cubit/auth_cubit.dart';
import 'package:doctor_of_plant_project/view_model/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../components/custom_text_field.dart';
import 'forget_password.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/signin.png',
                    scale: 5,
                  ),
                  const Text(
                    'Sign In',
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
                    hintText: 'Enter Email',
                    icon: Icons.alternate_email,
                    controller: cubit.emailController,
                  ),
                  CustomTextfield(
                    obscureText: true,
                    hintText: 'Enter Password',
                    icon: Icons.lock,
                    controller: cubit.passwordController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  state is SignInLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GestureDetector(
                          onTap: () {
                            cubit.login(context);
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
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: const ForgotPassword(), type: PageTransitionType.bottomToTop));
                    },
                    child: Center(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: 'Forgot Password? ',
                            style: TextStyle(
                              color: Constants.blackColor,
                            ),
                          ),
                          TextSpan(
                            text: 'Reset Here',
                            style: TextStyle(
                              color: Constants.primaryColor,
                            ),
                          ),
                        ]),
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
                  //         'Sign In with Google',
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
                          PageTransition(child: const SignUp(), type: PageTransitionType.bottomToTop));
                    },
                    child: Center(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: 'New to Planty? ',
                            style: TextStyle(
                              color: Constants.blackColor,
                            ),
                          ),
                          TextSpan(
                            text: 'Register',
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
        );
      },
    );
  }
}
