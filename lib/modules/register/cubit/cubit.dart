import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super (ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=> BlocProvider.of(context);
  ShopLoginModel? registeredUser;
  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: register,
        data:
        {
          'name' : name,
          'phone' : phone,
          'email': email,
          'password' : password,
          'image': 'image',
        }
    ).then((value){
      registeredUser = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSucceedState(registeredUser!));
    }).catchError((onError){
      emit(ShopRegisterErrorState(onError));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ?  Icons.visibility_outlined : Icons.visibility_off;
    emit(ShopRegisterChangePasswordVisibilityState());
  }

}