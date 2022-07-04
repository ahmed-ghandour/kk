

import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginSLoadingState extends ShopLoginStates{}

class ShopLoginSucceedState extends ShopLoginStates
{
  final ShopLoginModel loginModel;

  ShopLoginSucceedState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates
{
  final dynamic error;

  ShopLoginErrorState(this.error);

}
class ShopChangePasswordVisibilityState extends ShopLoginStates{}
