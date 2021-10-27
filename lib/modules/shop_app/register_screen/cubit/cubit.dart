

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/shop_app/register_screen/cubit/states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{

  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)
      => BlocProvider.of(context);

  ShopLoginModel ? LoginModel;

  void userRegister({
  required String email,
    required String password,
    required String name,
    required String phone,
})
  {
    emit(ShopRegisterLoadingState());
    
    DioHelper.postData(
      url: REGISTER,
      date: {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,
      },
    ).then((value)
    {
      print(value.data);
      LoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(LoginModel!));
    }).catchError((error)
    {
      emit(ShopRegisterErrorState (error.toString()));
      print(error.toString());
    });
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true ;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix =isPassword? Icons.visibility_outlined :Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }


}