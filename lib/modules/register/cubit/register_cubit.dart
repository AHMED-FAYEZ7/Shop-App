import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>
{

  RegisterCubit() :super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone,
})
  {
    emit(RegisterLoadingState());

    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'email' : email,
          'name' : name,
          'password' : password,
          'phone' : phone,
        },
    ).then((value) {
      // print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
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

    emit(RegisterPassVisibilityState());
  }


}