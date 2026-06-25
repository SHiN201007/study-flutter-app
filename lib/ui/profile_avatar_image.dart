import 'dart:io';
import 'package:flutter/material.dart';

ImageProvider profileAvatarImage({
  String? imageUrl,
  String? localImagePath,
  String? placeholderImageAssetPath,
}) {
  if (imageUrl != null) {
    return NetworkImage(imageUrl);
  }
  if (localImagePath != null) {
    return FileImage(File(localImagePath));
  }
  final defaultImageAssetPath = placeholderImageAssetPath ?? 'assets/images/default_profile.png';
  return AssetImage(defaultImageAssetPath);
}