import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/shared/compmnant/componanets.dart';
import 'package:shop_app/shared/compmnant/conestants.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ShopRegisterScreen extends StatelessWidget {


  var fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context)
  {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),

      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context , state)
        {
          if(state is ShopRegisterSuccessState)
          {
            if(state.loginModel.status)
            {
              print(state.loginModel.data.token);
              print(state.loginModel.message);

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
              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'REGISTER now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height:15.0 ,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'User Name',
                          prefix: Icons.person,
                          onSubmit: (value)
                          {

                          },
                        ),
                        SizedBox(
                          height:30.0 ,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email address',
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
                            suffix: ShopRegisterCubit.get(context).suffix,
                            isPassword: ShopRegisterCubit.get(context).isPassword,
                            onSubmit: (value)
                            {
                              ShopRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            },
                            suffixPressed: ()
                            {
                              ShopRegisterCubit.get(context).changePasswordVisibility();
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
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            label: 'phone',
                            prefix: Icons.phone,

                        ),

                        SizedBox(
                          height:30.0 ,
                        ),

                        ConditionalBuilder(
                          condition:  state is! ShopRegisterLoadingState,
                          builder:(context) => defaultButton(
                            function: ()
                            {
                              ShopRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );

                            },
                            text: 'register' ,
                            isUpperCase: true,
                          ),
                          fallback:(context) =>
                              Center(child: CircularProgressIndicator()),
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
