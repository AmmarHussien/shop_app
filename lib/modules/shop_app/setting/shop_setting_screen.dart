import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/cubit/cubit.dart';
import 'package:shop_app/models/shop_app/cubit/states.dart';
import 'package:shop_app/shared/compmnant/componanets.dart';
import 'package:shop_app/shared/compmnant/conestants.dart';


class ShopSettingScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context,state) {

      },
      builder: (context,state) {

        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
            builder: (context) =>  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'name',
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'email',
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'phone',
                    prefix: Icons.phone,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultButton(
                      function: () {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,

                        );
                      },
                      text: 'Update You Data'),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: 'Logout')
                ],
              ),
            ),
          fallback: (context) => Center(child: CircularProgressIndicator()),

        );
      },
    );
  }
}
