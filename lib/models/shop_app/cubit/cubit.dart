import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/cubit/states.dart';
import 'package:shop_app/modules/shop_app/categories/shop_categories_screen.dart';
import 'package:shop_app/modules/shop_app/favorites/shop_favorites_screen.dart';
import 'package:shop_app/modules/shop_app/products/shop_products_screen.dart';
import 'package:shop_app/modules/shop_app/setting/shop_setting_screen.dart';
import 'package:shop_app/shared/compmnant/conestants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


import '../categories_model.dart';
import '../change_favorites_model.dart';
import '../favorites_model.dart';
import '../home_model.dart';
import '../login_model.dart';
import '../login_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen =
  [
    ShopProductScreen(),
    ShopCategoriesScreen(),
    ShopFavoritesScreen(),
    ShopSettingScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

   HomeModel  ? homeModel;

   late Map<int, bool>  favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      print(homeModel!.data!.banners.toString());
      print(homeModel!.status);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel ? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);


      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  late ChangeFavoritesModel  changeFavoritesModel;

  void changeFavorites(int productID)
  {
    favorites[productID]= !favorites[productID]!;
    emit(ShopChangeFavoritesDataState());

    DioHelper.postData(
        date: {
          'product_id':productID
        },
      token: token,
        url: FAVORITES,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.formJson(value.data);
      print(value.data);

      emit(ShopSuccessChangeFavoritesDataState(changeFavoritesModel));
      if(!changeFavoritesModel.status)
        {
          favorites[productID]= !favorites[productID]!;
        }
    })
    .catchError((error){
      favorites[productID]= !favorites[productID]!;

      emit(ShopErrorChangeFavoritesDataState());
      print(error.toString());
    }
    );

  }

   FavoritesModel ? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel ? userModel;

  void getUserData() {

    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data.name);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
  required String name,
    required String email,
    required String phone,
}) {

    emit(ShopLoadingUpdateState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      date: {
        'name':name ,
        'email': email,
        'phone' : phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data.name);
      emit(ShopSuccessUpdateState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateState());
    });
  }
}