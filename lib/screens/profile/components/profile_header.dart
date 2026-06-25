import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/core/services/image_picker/image_picker_provider.dart';
import 'package:study_app/features/user/user_provider.dart';
import 'package:study_app/ui/profile_avatar_image.dart';
import 'package:study_app/ui/snackbar.dart';

class ProfileHeader extends HookConsumerWidget {
  const ProfileHeader({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final imagePickerService = ref.read(imagePickerServiceProvider);
    final isUploading = useState(false);

    Future<void> onPressedChangeProfileImage() async {
      try {
        isUploading.value = true;
        final pickedImage = await imagePickerService.pickImage();
        if (pickedImage == null) return;
        await ref.read(currentUserProvider.notifier)
          .updateProfileImage(pickedImage.path);
        if (!context.mounted) return;
        context.showAppSnackbar('プロフィール画像を更新しました');
      }catch (e) {
        if (!context.mounted) return;
        context.showAppSnackbar('プロフィール画像の更新に失敗しました');
      } finally {
        if (context.mounted) isUploading.value = false;
      }
    }

    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: GestureDetector(
            onTap: isUploading.value ? null : onPressedChangeProfileImage,
            child: CircleAvatar(
              backgroundImage: profileAvatarImage(
                imageUrl: currentUser.imageUrl,
                localImagePath: currentUser.localImagePath,
              ),
            ),
          )
        ),
        const SizedBox(height: 8),
        Text('@${currentUser.handle}'),
      ],
    );
  }
}