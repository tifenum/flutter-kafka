// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class MyLoginTextField extends StatefulWidget {
  final String text;
  final IconData? icon;
  final bool? isNum;
  final void Function()? onTap;
  final bool isPassword;
  TextEditingController myController = TextEditingController();
  final bool? isalert;

  MyLoginTextField({
    super.key,
    required this.isPassword,
    required this.text,
    this.icon,
    required this.myController,
    this.onTap,
    this.isNum,
    this.isalert,
  });

  @override
  State<MyLoginTextField> createState() => _MyLoginTextFieldState();
}

class _MyLoginTextFieldState extends State<MyLoginTextField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        setState(() {
          isFocused = true;
        });
      },
      controller: widget.myController,
      obscureText: widget.isPassword,
      keyboardType:
          widget.isNum != null ? TextInputType.number : TextInputType.text,
      cursorColor: Colors.black87,
      decoration: InputDecoration(
        labelText: widget.text,
        labelStyle: const TextStyle(color: Colors.black87),
        hintText: isFocused ? '' : widget.text,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        suffix: widget.onTap != null
            ? InkWell(
                onTap: widget.onTap,
                child: Icon(
                  widget.isPassword ? widget.icon : Icons.visibility_outlined,
                  color: Colors.black38,
                ),
              )
            : Icon(
                widget.icon,
                color: Colors.black38,
              ),
        contentPadding: widget.isalert == null
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 18)
            : const EdgeInsets.only(top: 10, left: 10),
      ),
    );
  }
}
