import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/search/shop_search_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          var cubit = ShopCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: const Text('Salla'),
                actions:
                [
                  TextButton(
                      onPressed: ()
                      {
                        navigateTo(context, ShopSearchScreen());
                      },
                      child: const Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                ],
              ),
              body: cubit.navbarScreens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index)
                {
                  cubit.changeBottom(index);
                },
                currentIndex: cubit.currentIndex,
                items:
                const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps),
                      label: 'Categories'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      label: 'Favorites'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings'
                  ),
                ],
              ),
          );
        },
    );
  }
}
