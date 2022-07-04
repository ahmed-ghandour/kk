import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/Favourites/favourites_screen.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super (ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List <Widget> navbarScreens =
  [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    SettingsScreen()
  ];
  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ChangeBottomNav());
  }

  HomeModel? homeModel;
  Map<int,bool> favourites = {};
  void getHomeData()
  {
    emit(HomeLoadingState());
    DioHelper.getData(
        url : home,
        token: token
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        favourites.addAll({
          element.id!: element.inFavorite!
        });
      }
      print(favourites.toString());
      emit(HomeSuccessState());
    }).catchError((onError){
      emit(HomeErrorState(onError));
    });
  }

  CategoryModel? categoryModel;
  void getCategoriesData()
  {
    emit(CategoriesLoadingState());
    DioHelper.getData(
        url : categories,
        token: token
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(CategoriesSuccessState());
    }).catchError((onError){
      emit(CategoriesErrorState(onError));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favourites.update(productId , (value) => !value);
    emit(ChangeFavoritesState());
    DioHelper.postData(
        url: favorites,
        data:
        {
          'product_id' : productId
        },
       token: token
    ).then((value){
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status)
      {
        favourites.update(productId , (value) => !value);
      }
      else
        {
          getFavoritesData();
        }
      emit(ChangeFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((error){
      favourites.update(productId , (value) => !value);
      emit(ChangeFavoritesErrorState(error));
    });
  }
  FavoritesModel? favoritesModel;
  void getFavoritesData ()
  {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(
        url : favorites,
        token: token
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(GetFavoritesSuccessState ());
    }).catchError((onError){
      emit(GetFavoritesErrorState(onError));
    });
  }

  ShopLoginModel? userModel;
  void getUserData ()
  {
    emit(UserDataLoadingState());
    DioHelper.getData(
        url : profile,
        token: token
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name!.toString());
      emit(UserDataSuccessState (userModel!));

    }).catchError((onError){
      emit(UserDataErrorState(onError));
      print(onError.toString());
    });
  }


  void updateUserData ({
  required String name,
  required String email,
  required String phone,
})
  {
    emit(UpdateUserDataLoadingState());
    DioHelper.putData(
        url : profileUp,
        token: token,
        data:
        {
          'name' : name,
          'email' : email,
          'phone' : phone,
        }
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name!.toString());
      emit(UpdateUserDataSuccessState (userModel!));

    }).catchError((onError){
      emit(UpdateUserDataErrorState(onError));
      print(onError.toString());
    });
  }

}