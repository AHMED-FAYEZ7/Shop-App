import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/cubit/register_cubit.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import 'package:shop_app/shared/componants/componants.dart';
import 'package:shop_app/shared/componants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../shared/cubit/cubit.dart';

class RegisterScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context , state)
        {
          if(state is RegisterSuccessState)
          {
            if(state.loginModel.status!)
            {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(context, const ShopLayout());
                AppCubit.get(context)..getProfile()..getFavorites()..getHomeData()..getCategories();
                AppCubit.get(context).currentIndex = 0;
              });
            }else
            {
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context , state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'register now to browse our offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Name',
                          prefix: Icons.person,
                          validator: (String? s)
                          {
                            if(s!.isEmpty)
                            {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15,),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email,
                          validator: (String? s)
                          {
                            if(s!.isEmpty)
                            {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15,),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          isPassword: RegisterCubit.get(context).isPassShown,
                          prefix: Icons.lock_open_outlined,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            RegisterCubit.get(context).passVisibility();
                          },
                          onSubmit: (value)
                          {

                          },
                          validator: (String? s)
                          {
                            if(s!.isEmpty)
                            {
                              return 'password is too short';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15,),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validator: (String? s)
                          {
                            if(s!.isEmpty)
                            {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                            text: 'register',
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                              return null;
                            },
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
