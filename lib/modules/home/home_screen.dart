import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return ConditionalBuilder(
              condition: AppCubit.get(context).homeModel != null,
              builder: (context) => homeBuilder(AppCubit.get(context).homeModel!),
              fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        },
    );
  }

  Widget homeBuilder(HomeModel model) => Column(
    children: [
      CarouselSlider(
        items: model.data!.banners.map((e) => Image(
          image: NetworkImage(e.image),
          width: double.infinity,
          fit: BoxFit.cover,
        )
        ).toList(),
        options: CarouselOptions(
          height: 250,
          enableInfiniteScroll: true,
          initialPage: 0,
          reverse: false,
          autoPlay: true,
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayInterval: Duration(seconds: 3),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
          viewportFraction: 1,
        ),
      ),
    ],
  );
}
