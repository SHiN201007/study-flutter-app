


import 'package:image_picker/image_picker.dart';

enum ImageSourceType { gallery, camera }

class PickedImage {
  const PickedImage(this.path);
  final String path;
}

abstract interface class ImagePickerService {
  Future<PickedImage?> pickImage({
    ImageSourceType sourceType = ImageSourceType.gallery,
  });
}

class ImagePickerServiceImpl implements ImagePickerService {

  ImagePickerServiceImpl([ImagePicker? imagePicker]) : _imagePicker = imagePicker ?? ImagePicker();
  final ImagePicker _imagePicker;

  @override
  Future<PickedImage?> pickImage({
    ImageSourceType sourceType = ImageSourceType.gallery,
  }) async {
    final file = await _imagePicker.pickImage(
      source: switch (sourceType) {
        ImageSourceType.gallery => ImageSource.gallery,
        ImageSourceType.camera => ImageSource.camera,
      },
      imageQuality: 80,
    );
    if (file == null) return null;
    return PickedImage(file.path);
  }

  
}