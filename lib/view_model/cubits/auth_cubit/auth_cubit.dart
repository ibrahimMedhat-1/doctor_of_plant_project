 import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

}
