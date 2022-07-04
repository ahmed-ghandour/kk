import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state)
        {
          if (state is ChangeFavoritesSuccessState)
          {
            if (!state.changeFavoritesModel.status)
            {
              showToast(text: state.changeFavoritesModel.message, state: ToastStates.error);
            }
          }
        },
        builder: (context,state)
        {
          return ConditionalBuilderRec(
              condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoryModel != null,
              fallback: (BuildContext context)=> const Center(child: CircularProgressIndicator()),
              builder: (BuildContext context)=> productsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoryModel,context),
          );
        },
    );
  }
  Widget productsBuilder (HomeModel? homeModel,CategoryModel? categoryModel,context) =>SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
            items:
            [
               ...homeModel!.data.banners.map((e) => Image(
               image: NetworkImage('${e.image}'),
               width: double.infinity,
               fit: BoxFit.cover,
             ),).toList(),
            ],
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
        ),
        const SizedBox(
          height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Categories",
                      style: TextStyle(
                          fontSize:24,
                          fontWeight: FontWeight.w800,
                      ),),
              const SizedBox(
                height: 10,),
              Row(
                children:
                [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ( context, index) => buildCategories(categoryModel!.data.data[index]),
                          separatorBuilder: ( context ,  index)=> const SizedBox(width: 10,),
                          itemCount: categoryModel!.data.data.length
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,),
              const Text("New Products",
                style: TextStyle(
                  fontSize:24,
                  fontWeight: FontWeight.w800,
                ),),
            ],
          ),
        ),
        Container(
          color: Colors.grey[100],
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children:
            <Widget>[
              ...List.generate(homeModel.data.products.length,(index) => buildGridProduct(homeModel.data.products[index],context)),
            ],
          ),
        )
      ],
    ),
  );
  Widget buildGridProduct(ProductsModel model,context)=> Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                height: 150,
            ),
            if(model.discount != 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                color: Colors.red,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                  ),
                ),
            ),
              )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
              ),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    model.price!.toString()+' L.E',
                    style: const TextStyle(
                        fontSize:12,
                        color: defaultColor),),
                  const SizedBox(
                    width: 5,),
                  if(model.discount != 0)
                  Text(
                    model.oldPrice!.toString(),
                    style:const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                    ) ,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(model.id!);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubit.get(context).favourites[model.id]! ? defaultColor : Colors.grey[300],
                        child: const Icon(
                           Icons.favorite_border,
                           color: Colors.white,
                        ),
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget buildCategories(DataModel model )=> Stack(
    alignment: Alignment.bottomCenter,
    children:
    [
       Image(
        image: NetworkImage('${model.image}'
        ),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.4),
        width: 100,
        height: 20,
        child:  Text('${model.name}',
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
      ),
    ],
  );
}
