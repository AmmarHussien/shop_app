import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/compmnant/conestants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'layout/shop_app/shop_layout.dart';
import 'models/shop_app/cubit/cubit.dart';
import 'modules/shop_app/login_screen/shop_login_screen.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool? isDark = CacheHelper.getDate(key: 'isDark');

  //String token = CacheHelper.getDate(key: 'token');
  bool onBoarding = CacheHelper.getDate(key: 'onBoarding');

  token =  CacheHelper.getDate(key: 'token');

  if(onBoarding != null)
  {
    if(token!=null)
    {
      widget = ShopLayout();
    }
    else
    {
      widget = ShopLoginScreen();
    }
  }
  else
  {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}
class MyApp extends StatelessWidget
{

  bool? isDark;
  Widget  startWidget;
  MyApp({Key? key,
    this.isDark,
    required this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(
          fromShared: isDark,
        ),
        ),

        BlocProvider(
          create: (context) =>  ShopCubit()..getHomeData()..getCategoriesData()..getUserData()..getFavorites(),)
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context , state ){},
        builder:(context , state )
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false ,
            theme: lightTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.light: ThemeMode.dark,
            darkTheme: darkTheme,
            home: startWidget,
          );
        } ,

      ),
    );

  }

}