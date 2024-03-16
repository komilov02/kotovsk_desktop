import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Tokenni saqlash uchun funksiya
Future<void> saveEditId(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("edit_id", id);
}

// Tokenni olish uchun funksiya
Future<String?> getEditId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("edit_id");
}
