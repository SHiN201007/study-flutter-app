import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/features/user/user_provider.dart';
import 'package:study_app/ui/snackbar.dart';

class ProfileEditForm extends HookConsumerWidget {
  const ProfileEditForm({
    super.key, 
    required this.userId
  });

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isSending = useState(false);

    final currentUser = ref.read(currentUserProvider);
    final nameController = useTextEditingController(
      text: currentUser.name,
    );
    final bioController = useTextEditingController(
      text: currentUser.bio,
    );
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);

    Future<void> onPressedSendButton() async {
      if (!formKey.currentState!.validate()) {
        context.showAppSnackbar('未入力項目があります');
        return;
      }
      FocusScope.of(context).unfocus();

      final inputName = nameController.text;
      final inputBio = bioController.text;

      try {
        isSending.value = true;
        await ref.read(currentUserProvider.notifier)
          .updateProfile(inputName, inputBio);
        if (!context.mounted) return;
        context.showAppSnackbar('更新を完了しました');
      }catch (e) {
        if (!context.mounted) return;
        context.showAppSnackbar('更新に失敗しました: $e');
      }finally {
        if (context.mounted) isSending.value = false;
      }
    }


    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '名前を入力してください';
              }
              return null;
            },
            onChanged: (value) => debugPrint('text changed: $value'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: bioController,
            decoration: const InputDecoration(
              labelText: 'bio',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: 3,
            validator: (value) {
              if (value != null && value.length >= 200) {
                return '200文字以内で入力してください';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: isSending.value ? null : onPressedSendButton, 
            child: Text(isSending.value ? '更新中...' : '更新する'),
          ),
        ],
      ),
    );
  }
}