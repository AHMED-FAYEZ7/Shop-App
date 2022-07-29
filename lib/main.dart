import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/componants/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/theme.dart';

void main()
{
  BlocOverrides.runZoned(() async
  {
    WidgetsFlutterBinding.ensureInitialized();
    DioHelper.init();
    await CacheHelper.init();
    Widget? widget;
    bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
    if(onBoarding != null)
    {
      if(token != null)
      {
        widget = ShopLayout();
      } else
      {
        widget = LoginScreen();
      }
    }else
    {
      widget = OnBoardingScreen();
    }
    runApp(MyApp(widget));
  },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget
{
  final Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) =>
      AppCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getProfile()
      ,
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}