import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tvopcheck/models/user_model.dart';
import 'package:tvopcheck/states/my_service.dart';
import 'package:tvopcheck/utility/my_constant.dart';
import 'package:tvopcheck/utility/my_dialog.dart';
import 'package:tvopcheck/widgets/show_button.dart';
import 'package:tvopcheck/widgets/show_form.dart';
import 'package:tvopcheck/widgets/show_image.dart';
import 'package:tvopcheck/widgets/show_text.dart';

class Authen extends StatefulWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: MyConstant().normalBox(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                newImage(),
                newAppName(),
                newUser(),
                newPassword(),
                newLogin()
              ],
            ),
          ),
        ),
      ),
    );
  }

  ShowButton newLogin() {
    return ShowButton(
      label: 'Login',
      pressFunction: () {
        print('user = $user, password = $password');

        if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
          print('Have Space');
          MyDialog(context: context).normalDialog(
              title: 'Have Space ?', message: 'Please Fill Every Blank');
        } else {
          print('No space');
          processCheckAuthen();
        }
      },
    );
  }

  Future<void> processCheckAuthen() async {
    String path =
        'https://www.androidthai.in.th/bigc/getUserWhereUserUng.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) {
      print('value => $value');

      if (value.toString() == 'null') {
        MyDialog(context: context).normalDialog(
            title: 'User False', message: 'No $user in my Database');
      } else {
        var result = json.decode(value.data);
        print('result => $result');

        for (var item in result) {
          print('item => $item');
          UserModel userModel = UserModel.fromMap(item);
          if (password == userModel.password) {
            print('Authen Success');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MyService(userModel: userModel,),
                ),
                (route) => false);
          } else {
            MyDialog(context: context).normalDialog(
                title: 'Password False',
                message: 'Please Try Again Password False');
          }
        }
      }
    });
  }

  ShowForm newPassword() {
    return ShowForm(
      label: 'Password :',
      iconData: Icons.lock_outline,
      obcu: true,
      changeFunction: (String string) {
        password = string.trim();
      },
    );
  }

  ShowForm newUser() {
    return ShowForm(
      label: 'User :',
      iconData: Icons.perm_identity,
      changeFunction: (String string) {
        user = string.trim();
      },
    );
  }

  Container newAppName() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: ShowText(
        label: 'TVOP check',
        textStyle: MyConstant().h1Style(),
      ),
    );
  }

  SizedBox newImage() {
    return const SizedBox(
      width: 180,
      child: ShowImage(),
    );
  }
}
