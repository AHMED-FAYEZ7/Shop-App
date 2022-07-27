import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
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
    bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
    runApp(MyApp(onBoarding!));

  },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget
{
  final bool onBoarding;

  MyApp(this.onBoarding);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: onBoarding ? LoginScreen() : OnBoardingScreen(),
    );
  }
}