import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition: state is! AppLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildFavItem(AppCubit.get(context).favoritesModel!.data!.data![index],context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,),
              child: Container(
                height: 1,
                color: Colors.grey,
                width: double.infinity,
              ),
            ),
            itemCount: AppCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem(FavoritesData model,context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.product!.image!),
                height: 120,
                width:120,
                fit: BoxFit.contain,
              ),
              if(model.product!.oldPrice! != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: .9,),
                  child: const Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product!.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      model.product!.price!.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    if(model.product!.oldPrice! != 0)
                      Text(
                        model.product!.oldPrice!.toString(),
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: AppCubit.get(context).favorites[model.product!.id]! ? defaultColor: Colors.grey,
                      radius: 14,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: ()
                        {
                          AppCubit.get(context).changeFavorites(model.product!.id!);
                        },
                        icon: const Icon(
                          Icons.favorite_border_outlined,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}