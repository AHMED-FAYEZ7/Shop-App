import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/componants/componants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shop App'
        ),
        actions: [
          IconButton(
            onPressed: ()
            {
              CacheHelper.removeData(key: 'token').then((value) {
                if(value)
                {
                  navigateAndFinish(context, LoginScreen());
                }
              });
            },
            icon: Icon(
              Icons.exit_to_app_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
