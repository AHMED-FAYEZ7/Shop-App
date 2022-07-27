import 'package:flutter/material.dart';

import '../../shared/componants/componants.dart';
import '../../shared/componants/constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
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
          IconButton(
            onPressed: ()
            {
              signOut(context);
            },
            icon: Icon(
              Icons.exit_to_app_outlined,
            ),
          ),
        ],
      ),
      body: Center(
          child: Text(
            'search',
            style: Theme.of(context).textTheme.bodyText1,
          )
      ),
    );
  }
}