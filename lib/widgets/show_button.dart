// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tvopcheck/utility/my_constant.dart';

class ShowButton extends StatelessWidget {
  final String label;
  final Function() pressFunction;
  const ShowButton({
    Key? key,
    required this.label,
    required this.pressFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: 250,
      child: ElevatedButton(
        onPressed: pressFunction,
        child: Text(label),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: MyConstant.primary,
        ),
      ),
    );
  }
}
