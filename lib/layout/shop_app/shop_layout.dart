import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/cubit/cubit.dart';
import 'package:shop_app/models/shop_app/cubit/states.dart';
import 'package:shop_app/modules/shop_app/search/shop_search_screen.dart';
import 'package:shop_app/shared/compmnant/componanets.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)=> (){},
      builder: (context,state)
      {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'salla'
            ),
            actions: [
              IconButton(
                  onPressed: ()
                {
                  navigateTo(context, ShopSearchScreen());
                },
                  icon: Icon(Icons.search),)
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar:  BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottom(index);
            },
            currentIndex:  cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home,),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps,),
                    label: 'Categories'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite,),
                    label: 'favorites'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings,),
                    label: 'Settings'
                ),
              ],
          ),
        );
      },
    );
  }
}
