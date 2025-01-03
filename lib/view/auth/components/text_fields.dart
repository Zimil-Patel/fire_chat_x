import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../utils/constants.dart';

buildEmailTextField() {
  return TextField(
    controller: authController.emailCtrl,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      hintText: 'Enter your email',
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      prefixIcon: const Icon(
        Icons.email,
        color: Color(0xFF3977F0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

buildPasswordTextField() {
  return Obx(
    () => TextField(
      controller: authController.passCtrl,
      obscureText: authController.hidePass.value,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'Enter your password',
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        suffixIcon: CupertinoButton(
          padding: const EdgeInsets.only(right: defPadding),
          onPressed: () {
            authController.hidePass.value = !authController.hidePass.value;
          },
          child: Icon(
            authController.hidePass.value
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
            color: const Color(0xFF3977F0),
          ),
        ),
        prefixIcon: const Icon(
          Icons.lock,
          color: Color(0xFF3977F0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
