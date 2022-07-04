//https://newsapi.org/v2/everything?q=Apple&apiKey=f5e2fdff5ed4431291d70648074f17


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

import 'components.dart';

void signOut (context)
{
CasheHelper.removeData(key:'token').then((value){
if(value)
{
navigateTo(context, ShopLoginScreen());
}
});
}

MaterialPageRoute<dynamic> goToHomeLayoutScreen()
{
  return MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (_) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavoritesData()
        ..getUserData(),
      child: const ShopLayout(),
    ),
  );
}
void printFullText(String? text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((match) => print(match.group(0)));
}
String? token = '';
bool? onBoarding = CasheHelper.getData(key: "onBoarding");