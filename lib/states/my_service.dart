// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:tvopcheck/models/user_model.dart';
import 'package:tvopcheck/states/authen.dart';
import 'package:tvopcheck/utility/my_constant.dart';
import 'package:tvopcheck/utility/my_dialog.dart';
import 'package:tvopcheck/widgets/check_in_out.dart';
import 'package:tvopcheck/widgets/page.dart';
import 'package:tvopcheck/widgets/show_image.dart';
import 'package:tvopcheck/widgets/show_text.dart';
import 'package:tvopcheck/widgets/tool.dart';

class MyService extends StatefulWidget {
  final UserModel userModel;
  const MyService({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  UserModel? userModel;
  var widgets = <Widget>[];
  int indexWidget = 0;
  double? lat, lng;
  bool load = true;

  @override
  void initState() {
    super.initState();

    userModel = widget.userModel;
    widgets.add(const CheckInOut());
    widgets.add(const Tool());
    widgets.add(const MyPage());

    checkPermissionLocation();
  }

  Future<void> checkPermissionLocation() async {
    await Permission.location.serviceStatus.then((value) async {
      print('serviceStatus ==> $value');
      // ignore: unrelated_type_equality_checks
      if (value == Permission.location.serviceStatus.isDisabled) {
        MyDialog(context: context).normalDialog(
            title: 'Location Service Disable',
            message: 'Please Open Service',
            pressFunc: () {
              exit(0);
            });
      } else {
        await Permission.location.status.then((value) {
          print('statusPermission ==> $value');
          if (value == PermissionStatus.denied) {
            Permission.location.request();
          } else {
            processFindLocation();
          }
        });
      }
    });
  }

  Future<void> processFindLocation() async {
    print('processFindLocatiotWork');
    Position? position = await findPosition();
    lat = position!.latitude;
    lng = position.longitude;
    print('lat ==> $lat, lng ==> $lng');
    load = false;
    setState(() {});
  }

  Future<Position?> findPosition() async {
    Position? position;
    position = await Geolocator.getCurrentPosition();
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
      ),
      drawer: newDrawer(context),
      body: load ? Center(child: CircularProgressIndicator()) : widgets[indexWidget] ,
    );
  }

  Drawer newDrawer(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: const ShowImage(),
                decoration: MyConstant().normalBox(),
                accountName: ShowText(
                  label: userModel!.name,
                  textStyle: MyConstant().h2Style(),
                ),
                accountEmail: const ShowText(label: 'Developer'),
              ),
              menuDrawer(
                iconData: Icons.home_outlined,
                label: 'Check In Out',
                index: 0,
              ),
              menuDrawer(
                iconData: Icons.settings,
                label: 'Tool',
                index: 1,
              ),
              menuDrawer(
                iconData: Icons.pages,
                label: 'Page',
                index: 2,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Authen(),
                    ),
                    (route) => false),
                tileColor: MyConstant.light.withOpacity(0.5),
                leading: Icon(
                  Icons.exit_to_app,
                  size: 36,
                  color: MyConstant.dark,
                ),
                title: ShowText(
                  label: 'SignOut',
                  textStyle: MyConstant().h1Style(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ListTile menuDrawer({
    required IconData iconData,
    required String label,
    required int index,
  }) =>
      ListTile(
        leading: Icon(iconData),
        title: ShowText(label: label),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            indexWidget = index;
          });
        },
      );
}
