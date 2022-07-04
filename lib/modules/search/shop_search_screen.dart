import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopSearchScreen extends StatelessWidget {
  const ShopSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=> SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state)
        {
         return Scaffold(
           appBar: AppBar(),
           body: Form(
             key: formKey,
             child: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Column(
                 children:
                 [
                   defaultFormField(
                       label: 'Search',
                       controller: searchController,
                       prefix: Icons.search,
                       type: TextInputType.text,
                       validate: (value)
                       {
                         if (value == null || value.isEmpty)
                         {
                           return "Enter a product for search";
                         }
                         return null;
                       },
                       onSubmit: (text)
                       {
                         SearchCubit.get(context).search(text!);
                       },
                   ),
                   const SizedBox(
                     height: 20,
                   ),
                   if(state is SearchLoadingState)
                   const LinearProgressIndicator(),
                   const SizedBox(
                     height: 20,
                   ),
                   if(state is SearchSuccessState)
                   Expanded(
                     child: ListView.separated(
                       itemBuilder: (context,index)=>buildListProducts(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false),
                       separatorBuilder: (context,index)=> dividerBuilder(),
                       itemCount: SearchCubit.get(context).model!.data!.data!.length,
                       physics: const BouncingScrollPhysics(),
                     ),
                   )
                 ],
               ),
             ),
           ),
         );
        },
      ),
    );
  }
}
