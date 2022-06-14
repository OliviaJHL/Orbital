import 'dart:ffi';

import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: Color(0xFFC4C4C4), width: 1),
    ),
  );
}

Container backToPrevious(BuildContext context) {
  return Container(
    width: double.infinity,
    child: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        alignment: Alignment.centerLeft,
        icon: const Icon(Icons.arrow_back_ios),
        iconSize: 36.0,
        color: Color(0xFF8C8C8C),
        onPressed: () {
          Navigator.pop(context);
        }),
  );
}

Container UIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    margin: const EdgeInsets.fromLTRB(0, 12, 0, 12),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return Color(0xFFFCC25E);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.0),
      ),
    ),
  );
}

//reusableTextField will be discard
TextFormField reusableTextField(
    String text, bool isPasswordType, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: const TextStyle(color: Color(0xFF8C8C8C)),
    decoration: InputDecoration(
      hintText: text,
      labelStyle: const TextStyle(color: Color(0xFF8C8C8C)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        //borderSide: const BorderSide(width: 0, style: BorderStyle.none)
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
