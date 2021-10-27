
import 'package:shop_app/modules/shop_app/login_screen/shop_login_screen.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';


import 'componanets.dart';

void signOut (context)
{
  CacheHelper.removeDate(
    key: 'token',
  ).then((value)
  {
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.(1,800)');
  pattern.allMatches(text).forEach((element) {
    print(element.group(0));
  });
}

String token = '';