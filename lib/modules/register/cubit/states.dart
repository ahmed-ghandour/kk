import 'package:shop_app/models/login_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSucceedState extends ShopRegisterStates
{
  final ShopLoginModel loginModel;

  ShopRegisterSucceedState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates
{
  final dynamic error;

  ShopRegisterErrorState(this.error);

}
class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates{}
