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