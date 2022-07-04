import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
    {
      if (ShopCubit.get(context).favoritesModel!.data == null)
      {
        return const Center(child: Text(' There are No Favorites yet please add some'));
      }
      else
        {
          return ConditionalBuilderRec(
            condition: state is! GetFavoritesLoadingState,
            builder:(context)=> ListView.separated(
              itemBuilder: (context,index)=>buildListProducts(ShopCubit.get(context).favoritesModel!.data!.data![index].product!,context),
              separatorBuilder: (context,index)=> dividerBuilder(),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
              physics: const BouncingScrollPhysics(),
            ),
            fallback: (context)=> const Center(child: CircularProgressIndicator()),
          );
        }

    },);
  }
}
