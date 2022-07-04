import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/on_boarding_app/on_boarding_screen.dart';
import 'package:shop_app/modules/register/shop_register_screen.dart';
import 'package:shop_app/modules/search/shop_search_screen.dart';
import 'package:shop_app/shared/components/constants.dart';



class AppRouter  {
  static const String startScreen = '/';
  static const String onBoardingScreen = '/boarding';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String homeLayoutScreen = '/home';
  static const String searchScreen = '/search';



  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case startScreen:
        return _startScreen();
      case onBoardingScreen:
        return _goToOnBoardingScreen();
      case loginScreen:
        return _goToLoginScreen();
      case registerScreen:
        return _goToRegisterScreen();
      case homeLayoutScreen:
        return _goToHomeLayoutScreen();
      case searchScreen:
        return _goToSearchScreen();
      default:
        return _startScreen();
    }
  }

  //bool? onBoarding = CasheHelper.getData(key:'onBoarding');
  MaterialPageRoute<dynamic> _startScreen() {
    if (onBoarding != null) {
      // onBoarding = true
      if (token != null) {
        return _goToHomeLayoutScreen();
      } else {
        return _goToLoginScreen();
      }
    } else {
      return _goToOnBoardingScreen();
    }
  }

  MaterialPageRoute<dynamic> _goToOnBoardingScreen() {
    return MaterialPageRoute(
      builder: (_) => const OnBoardingScreen(),
    );
  }

  MaterialPageRoute<dynamic> _goToLoginScreen() {
    return MaterialPageRoute(
      builder: (_) => ShopLoginScreen(),
    );
  }

  MaterialPageRoute<dynamic> _goToRegisterScreen() {
    return MaterialPageRoute(
      builder: (_) => ShopRegisterScreen(),
    );
  }

  MaterialPageRoute<dynamic> _goToHomeLayoutScreen() {
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

  MaterialPageRoute<dynamic> _goToSearchScreen() {
    return MaterialPageRoute(
      builder: (_) => const ShopSearchScreen(),
    );
  }
}