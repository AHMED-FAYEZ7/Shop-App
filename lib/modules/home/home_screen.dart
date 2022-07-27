import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

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

  Widget homeBuilder(HomeModel model) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
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
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: .9,
          ),
        ),
        const SizedBox(height: 10,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            crossAxisCount: 2,
            childAspectRatio: 1/1.49,
            children: List.generate(
              model.data!.products.length,
                  (index) => buildGridItem(model.data!.products[index]),
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildGridItem(ProductsModel model) => Container(
    color: Colors.white,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 200,
              width: double.infinity,
            ),
            if(model.discount != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: .9,),
                child: Text(
                  'Discount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  if(model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){},
                    icon: Icon(
                      Icons.favorite_border_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
