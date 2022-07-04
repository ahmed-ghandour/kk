import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/shop_register_screen.dart';
/*import 'package:shop_app/shared/app_navigation.dart';*/
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context )=> ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
      listener: (context,state)
      {
        if ( state is ShopLoginSucceedState)
        {
          if (state.loginModel.status!)
          {
            CasheHelper.saveData(
                key: "token",
                value: state.loginModel.data!.token
            ).then((value){
              token = state.loginModel.data!.token;
              navigateAndFinish(context, const ShopLayout());
              //_goToHomeScreen(state,context);

            });
          }
          else
            {
              showToast(
                  text: state.loginModel.message!,
                  state: ToastStates.error,
              );
            }
        }
      },
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text('LOGIN',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text('login to discover some of our offers .......',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 20,
                      ),
                      defaultFormField(
                          label: 'Email Address',
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          prefix: Icons.email_outlined,
                          validate: (value)
                          {
                            if ( value == null || value.isEmpty)
                            {
                              return 'Email Can not be Empty ';
                            }
                          }
                      ),
                      const SizedBox(height: 20,
                      ),
                      defaultFormField(
                          label: 'Password',
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock,
                          suffix: ShopLoginCubit.get(context).suffix,
                          isPasword: ShopLoginCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          onSubmit: (value)
                          {
                            if (formKey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                          validate: (value)
                          {
                            if (value == null || value.isEmpty )
                            {
                              return ' Password Can not be Empty  ';
                            }
                          }
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilderRec(
                          condition: state is! ShopLoginSLoadingState,
                          builder: (context)=>defaultButton(
                              text: "Login",
                              function: ()
                              {
                                if (formKey.currentState!.validate())
                                  {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text
                                    );
                                  }
                              } ),
                          fallback: (context)=> const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          const Text('Don\'t have an account ? '),
                          defaultTextButton(
                              text:'Register Now',
                              function: ()
                              {
                                navigateTo(context, ShopRegisterScreen());
                              }
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
          ,
        );
      },
      ));
  }
/*  void _goToHomeScreen( state, BuildContext context ) {

      Navigator.pushReplacementNamed(context, AppRouter.homeLayoutScreen);
  }*/
}
