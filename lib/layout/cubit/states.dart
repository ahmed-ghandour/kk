import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';


abstract class ShopStates {}
class ShopInitialState extends ShopStates{}
class ChangeBottomNav extends ShopStates{}
class HomeLoadingState extends ShopStates{}
class HomeSuccessState extends ShopStates{}
class HomeErrorState extends ShopStates
{
  final dynamic error;

  HomeErrorState(this.error);
}
class CategoriesLoadingState extends ShopStates{}
class CategoriesSuccessState extends ShopStates{}
class CategoriesErrorState extends ShopStates
{
  final dynamic error;

  CategoriesErrorState(this.error);
}
class ChangeFavoritesState extends ShopStates {}
class ChangeFavoritesSuccessState extends ShopStates
{
  final ChangeFavoritesModel changeFavoritesModel;

  ChangeFavoritesSuccessState(this.changeFavoritesModel);
}
class ChangeFavoritesErrorState extends ShopStates
{
  final dynamic error;

  ChangeFavoritesErrorState(this.error);
}
class GetFavoritesLoadingState extends ShopStates{}
class GetFavoritesSuccessState extends ShopStates{}
class GetFavoritesErrorState extends ShopStates
{
  final dynamic error;

  GetFavoritesErrorState(this.error);

}
class UserDataLoadingState extends ShopStates{}
class UserDataSuccessState extends ShopStates {
  final ShopLoginModel loginModel;

  UserDataSuccessState(this.loginModel);
}
class UserDataErrorState extends ShopStates {
  final dynamic error;

  UserDataErrorState(this.error);
}
class UpdateUserDataLoadingState extends ShopStates{}
class UpdateUserDataSuccessState extends ShopStates {
 final ShopLoginModel loginModel;

  UpdateUserDataSuccessState(this.loginModel);
}
class UpdateUserDataErrorState extends ShopStates {
  final dynamic error;
  UpdateUserDataErrorState(this.error);
}

