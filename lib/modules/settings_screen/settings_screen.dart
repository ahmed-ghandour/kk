import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context, state)
      {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return SingleChildScrollView(
          child:Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children:
                [
                  defaultFormField(
                      label: "Name",
                      controller: nameController,
                      prefix: Icons.person,
                      type: TextInputType.text,
                      validate: (value)
                      {
                        if(value == null || value.isEmpty)
                        {
                          return "Name must not be empty";
                        }
                        return null;
                      }
                  ),
                  const SizedBox(
                    height: 10,),
                  defaultFormField(
                      label: "Email",
                      controller: emailController,
                      prefix: Icons.email,
                      type: TextInputType.text,
                      validate: (value)
                      {
                        if(value == null || value.isEmpty)
                        {
                          return "Name must not be empty";
                        }
                        return null;
                      }
                  ),
                  const SizedBox(
                    height: 10,),
                  defaultFormField(
                      label: "Phone",
                      controller: phoneController,
                      prefix: Icons.phone,
                      type: TextInputType.text,
                      validate: (value)
                      {
                        if(value == null || value.isEmpty)
                        {
                          return "Name must not be empty";
                        }
                        return null;
                      }
                  ),
                  const SizedBox(
                    height: 20,),
                  defaultButton(
                      text: "update",
                      function: ()
                      {
                        if (formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text
                          );
                        }

                      }
                  ),
                  const SizedBox(
                    height: 20,),
                  defaultButton(
                      text: "logout",
                      function: ()
                      {
                        signOut(context);
                      }
                      ),
                ],
              ),
            ),
          ),
        );
      }

    );
  }
}
