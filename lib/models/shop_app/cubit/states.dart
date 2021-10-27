

import '../change_favorites_model.dart';
import '../login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState  extends ShopStates {}

class ShopLoadingHomeDataState  extends ShopStates {}

class ShopSuccessHomeDataState  extends ShopStates {}

class ShopErrorHomeDataState  extends ShopStates {}

class ShopSuccessCategoriesDataState  extends ShopStates {}

class ShopErrorCategoriesDataState  extends ShopStates {}

class ShopSuccessChangeFavoritesDataState  extends ShopStates
{
  late final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesDataState(this.model);
}

class ShopChangeFavoritesDataState  extends ShopStates{}

class ShopErrorChangeFavoritesDataState  extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingUserDataState  extends ShopStates {}

class ShopSuccessUserDataState  extends ShopStates
{
  late final ShopLoginModel loginModel ;
  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState  extends ShopStates {}

class ShopLoadingUpdateState  extends ShopStates {}

class ShopSuccessUpdateState  extends ShopStates
{
  late final ShopLoginModel loginModel ;
  ShopSuccessUpdateState(this.loginModel);
}

class ShopErrorUpdateState  extends ShopStates {}