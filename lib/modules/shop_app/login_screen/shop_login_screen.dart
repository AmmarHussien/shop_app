import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/register_screen/shop_register_screen.dart';
import 'package:shop_app/shared/compmnant/componanets.dart';
import 'package:shop_app/shared/compmnant/conestants.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {

var fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context)
  {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),

      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context , state)
        {
          if(state is ShopLoginSuccessState)
            {
              if(state.loginModel.status)
                {
                  //print(state.loginModel.data.token);


                  CacheHelper.saveDate(
                      key: 'token',
                      value: state.loginModel.data.token
                  ).then((value)
                  {
                    token = state.loginModel.data.token;
                    navigateAndFinish(context, ShopLayout());
                  });
                } else
                  {
                    print(state.loginModel.message);
                    showToast(
                      text: state.loginModel.message.toString(),
                      state: ToastStates.SUCCESS,
                    );
                }
            }
        },
        builder:  (context , state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: fromKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height:15.0 ,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          onSubmit: (value)
                          {

                          },
                        ),
                        SizedBox(
                          height:30.0 ,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: ShopLoginCubit.get(context).suffix,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          onSubmit: (value)
                            {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            },
                          suffixPressed: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          validate: (String value)
                            {
                              if(value.isEmpty)
                                {
                                  return 'password is too short';
                                }
                            }
                        ),
                        SizedBox(
                          height:30.0 ,
                        ),
                        ConditionalBuilder(
                          condition:  state is! ShopLoginLoadingState,
                          builder:(context) => defaultButton(
                            function: ()
                            {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );

                            },
                            text: 'login' ,
                            isUpperCase: true,
                          ),
                          fallback:(context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height:30.0 ,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Don\'t have an account?'
                            ),
                            defaultTextButton(
                              function:()
                              {
                                navigateTo(
                                  context,
                                  ShopRegisterScreen(),
                                );
                              },
                              text: 'register' ,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
