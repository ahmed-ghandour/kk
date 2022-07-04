import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/on_boarding_app/on_boarding_screen.dart';



void main() async
{
  BlocOverrides.runZoned( () async
  {
    WidgetsFlutterBinding.ensureInitialized();
    DioHelper.init();
    await CasheHelper.init();
    Widget? widget;
    bool? onBoarding = await CasheHelper.getData(key:'onBoarding');
    token = await CasheHelper.getData(key:'token');
    debugPrint(token.toString());
    if(onBoarding != null)
    {
      if( token != null)
      {
        widget = const ShopLayout();
      }
      else
      {
        widget = ShopLoginScreen();
      }
    }
    else
    {
      widget = const OnBoardingScreen();
    }


    runApp( MyApp(
      startWidget : widget,
      //appRouter: AppRouter(),
    ));

  },
    blocObserver: MyBlocObserver(),
  );


}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  //final AppRouter appRouter;
  const MyApp({
    Key? key,
    required this.startWidget
  }) : super( key:key );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (BuildContext context)=> ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData()),
      ],
      child: BlocConsumer< ShopCubit, ShopStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
            /*onGenerateRoute: appRouter.generateRoute,
            onUnknownRoute: appRouter.generateRoute,*/
            //initialRoute: ShopLayout(),

          );
        },
      ),

    );
  }
}
