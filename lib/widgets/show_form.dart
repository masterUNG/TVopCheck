// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tvopcheck/utility/my_constant.dart';
import 'package:tvopcheck/widgets/show_text.dart';

class ShowForm extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool? obcu;
  final Function(String) changeFunction;
  const ShowForm({
    Key? key,
    required this.label,
    required this.iconData,
    this.obcu,
    required this.changeFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      height: 40,
      child: TextFormField(
        onChanged: changeFunction,
        obscureText: obcu ?? false,
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.75),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          prefixIcon: Icon(
            iconData,
            color: MyConstant.dark,
          ),
          label: ShowText(label: label),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyConstant.dark),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyConstant.primary)),
        ),
      ),
    );
  }
}
