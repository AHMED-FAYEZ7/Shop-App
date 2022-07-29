import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';

import '../../shared/componants/componants.dart';
import '../../shared/componants/constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => AppSearchCubit(),
      child: BlocConsumer<AppSearchCubit,AppSearchState>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, const SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                  ),
                ),

              ],
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validator: (s)
                        {
                          if(s!.isEmpty)
                          {
                            return 'fill form first';
                          }
                          return null;
                        },
                        label: 'Search',
                        prefix: Icons.search,
                        onSubmit: (String? text)
                        {
                          AppSearchCubit.get(context).search(text!);
                          return null;
                        }
                    ),
                    const SizedBox(height: 10,),
                    if(state is AppSearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 10,),
                    if(state is AppSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildListItems(
                            AppSearchCubit.get(context).model!.data!.data?[index],
                            context,
                            isOldPrice: false,
                        ),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,),
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                            width: double.infinity,
                          ),
                        ),
                        itemCount: AppSearchCubit.get(context).model!.data!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}