import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/componants/componants.dart';
import 'package:shop_app/shared/componants/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {},
      builder: (context,state)
      {
        var model = AppCubit.get(context).profileModel!;
        nameController.text = model.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: AppCubit.get(context).profileModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is AppLoadingUpdateProfileState)
                      LinearProgressIndicator(),
                    SizedBox(height: 20,),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validator: (s)
                      {
                        if(s!.isEmpty)
                        {
                          return 'name must cot be empty';
                        }
                        return null;
                      },
                      label: 'name',
                      prefix: Icons.person,
                    ),
                    const SizedBox(height: 20,),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validator: (s)
                      {
                        if(s!.isEmpty)
                        {
                          return 'email must cot be empty';
                        }
                        return null;
                      },
                      label: 'email',
                      prefix: Icons.email,
                    ),
                    const SizedBox(height: 20,),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validator: (s)
                      {
                        if(s!.isEmpty)
                        {
                          return 'phone must cot be empty';
                        }
                        return null;
                      },
                      label: 'phone',
                      prefix: Icons.phone,
                    ),
                    const SizedBox(height: 20,),
                    defaultButton(
                      function: ()
                      {
                        if(formKey.currentState!.validate())
                        {
                          AppCubit.get(context).updateProfile(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: 'Update',
                    ),
                    const SizedBox(height: 20,),
                    defaultButton(
                      function: ()
                      {
                        signOut(context);
                      },
                      text: 'Logout',
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: const CircularProgressIndicator()),
        );
      },
    );
  }
}