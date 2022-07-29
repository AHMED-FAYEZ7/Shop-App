import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class AppLoadingHomeDataState extends AppStates {}
class AppSuccessHomeDataState extends AppStates {}
class AppErrorHomeDataState extends AppStates
{
  final String error;

  AppErrorHomeDataState(this.error);
}

class AppSuccessCategoriesDataState extends AppStates {}
class AppErrorCategoriesDataState extends AppStates
{
  final String error;

  AppErrorCategoriesDataState(this.error);
}

class AppChangeFavState extends AppStates {}
class AppSuccessChangeFavState extends AppStates
{
  final ChangeFavoritesModel model;

  AppSuccessChangeFavState(this.model);
}
class AppErrorChangeFavState extends AppStates
{
  final String error;

  AppErrorChangeFavState(this.error);
}

class AppLoadingGetFavoritesState extends AppStates {}
class AppSuccessGetFavoritesState extends AppStates {}
class AppErrorGetFavoritesState extends AppStates
{
  final String error;

  AppErrorGetFavoritesState(this.error);
}

class AppLoadingGetProfileState extends AppStates {}
class AppSuccessGetProfileState extends AppStates
{
  final LoginModel profileModel;

  AppSuccessGetProfileState(this.profileModel);
}
class AppErrorGetProfileState extends AppStates
{
  final String error;

  AppErrorGetProfileState(this.error);
}

class AppLoadingUpdateProfileState extends AppStates {}
class AppSuccessUpdateProfileState extends AppStates
{
  final LoginModel profileModel;

  AppSuccessUpdateProfileState(this.profileModel);
}
class AppErrorUpdateProfileState extends AppStates
{
  final String error;

  AppErrorUpdateProfileState(this.error);
}