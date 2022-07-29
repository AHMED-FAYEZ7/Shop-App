import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>
{

  LoginCubit() :super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({
  required String email,
  required String password,
})
  {
    emit(LoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email':email,
          'password':password,
        },
    ).then((value) {
      // print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });

  }

  IconData suffix = Icons.remove_red_eye;
  bool isPassShown = true;

  void passVisibility()
  {
    isPassShown = !isPassShown;
    suffix = isPassShown ?
        Icons.visibility_outlined :
        Icons.visibility_off_outlined;

    emit(LoginPassVisibilityState());
  }


}