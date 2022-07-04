import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/shared/components/components.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return BlocConsumer<ShopCubit,ShopStates>(
          listener: (context,state){},
          builder: (context,state)
          {
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildCategoryItem(ShopCubit.get(context).categoryModel!.data.data[index]),
                separatorBuilder: (context,index)=> dividerBuilder(),
                itemCount: ShopCubit.get(context).categoryModel!.data.data.length);},
      );
    }
  Widget buildCategoryItem(DataModel dataModel) => Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      children:
       [
        Image(
          image: NetworkImage(dataModel.image!),
          height: 80,
          width: 80
          ,),
        const SizedBox(
          width: 10,
        ),
        Text(dataModel.name!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ), ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
