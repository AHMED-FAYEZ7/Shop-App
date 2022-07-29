import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Gategories_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ListView.separated(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => builtCatItem(
              AppCubit.get(context).categoriesModel!.data!.data[index]
          ),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: Container(
              height: 1,
              color: Colors.grey,
              width: double.infinity,
            ),
          ),
          itemCount: AppCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget builtCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image!),
          height: 100,
          width: 100,
        ),
        const SizedBox(width: 20,),
        Text(
          model.name!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios,),
      ],
    ),
  );
}