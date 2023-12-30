// ignore_for_file: unused_import, avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart'; // Import for ImageSource

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? _file = await imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}
