import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super (ShopLoginInitialState());
  static ShopLoginCubit get(context)=> BlocProvider.of(context);
  late ShopLoginModel loginModel;
  void userLogin({
    required String email,
    required String password
})
  {
    emit(ShopLoginSLoadingState());
    DioHelper.postData(
        url: login,
        data:
        {
          'email': email,
          'password' : password
        }
    ).then((value){
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSucceedState(loginModel));
    }).catchError((onError){
      emit(ShopLoginErrorState(onError));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ?  Icons.visibility_outlined : Icons.visibility_off;
    emit(ShopChangePasswordVisibilityState());
  }

}