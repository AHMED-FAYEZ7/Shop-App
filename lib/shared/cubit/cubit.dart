import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Gategories_model.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/componants/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);


  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int , bool> favorites = {};

  void getHomeData()
  {
    emit(AppLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      print(token.toString());
      homeModel = HomeModel.fromJson(value.data);
      // printFullText(homeModel!.data!.banners[0].image);
      // print(homeModel?.status);
      for (var element in homeModel!.data!.products) {
        favorites.addAll({
          element.id: element.inFavorite,
        });
      }
      // print(favorites.toString());
      emit(AppSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(AppErrorHomeDataState(error));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories()
  {
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // printFullText(categoriesModel!.data!.currentPage);
      emit(AppSuccessCategoriesDataState());
    }).catchError((error){
      print(error.toString());
      emit(AppErrorCategoriesDataState(error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(AppChangeFavState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id':  productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // print(value.data);

      if(!changeFavoritesModel!.status!)
      {
        favorites[productId] = !favorites[productId]!;
      }else
      {
        getFavorites();
      }
      emit(AppSuccessChangeFavState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(AppErrorChangeFavState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites()
  {
    emit(AppLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      // print(token.toString());
      favoritesModel = FavoritesModel.fromJson(value.data);
      // printFullText(favoritesModel!.data!.toString());
      emit(AppSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(AppErrorGetFavoritesState(error.toString()));
    });
  }

  LoginModel? profileModel;

  void getProfile()
  {
    emit(AppLoadingGetProfileState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      profileModel = LoginModel.fromJson(value.data);
      // printFullText(profileModel!.data!.name);
      emit(AppSuccessGetProfileState(profileModel!));
    }).catchError((error){
      print(error.toString());
      emit(AppErrorGetProfileState(error.toString()));
    });
  }

  void updateProfile({
  required String name,
  required String email,
  required String phone,
})
  {
    emit(AppLoadingUpdateProfileState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value) {
      profileModel = LoginModel.fromJson(value.data);
      // printFullText(profileModel!.data!.name);
      emit(AppSuccessUpdateProfileState(profileModel!));
    }).catchError((error){
      print(error.toString());
      emit(AppErrorUpdateProfileState(error.toString()));
    });
  }


}