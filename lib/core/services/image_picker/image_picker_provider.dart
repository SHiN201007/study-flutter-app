import 'package:study_app/core/services/image_picker/image_picker_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_picker_provider.g.dart';

@riverpod
ImagePickerService imagePickerService(Ref ref) => ImagePickerServiceImpl();