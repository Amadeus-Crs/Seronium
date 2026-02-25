import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seronium_flutter/api/image.dart';


import 'package:seronium_flutter/api/post.dart';
import 'package:seronium_flutter/utils/ToastUtils.dart';class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String type = 'question';
  File? imageFile;
  String? imageUrl;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => imageFile = File(picked.path));
      imageUrl = await UploadImage(picked.path);
      _contentController.text += '\n\n![图片]($imageUrl)\n\n';
    }
  }

  Future<void> _publish() async {
    await CreatePost({
        "title": _titleController.text,
      "content": _contentController.text,
      "type": type,
      "image": imageUrl
      }
    );
    ToastUtils.showToast(context ,"发布成功");
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('发布内容'), actions: [
        TextButton(onPressed: _publish, child: const Text('发布', style: TextStyle(fontSize: 18))),
      ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: '标题', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ChoiceChip(label: const Text('问题'), selected: type == 'question', onSelected: (_) => setState(() => type = 'question')),
                const SizedBox(width: 12),
                ChoiceChip(label: const Text('文章'), selected: type == 'article', onSelected: (_) => setState(() => type = 'article')),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _contentController,
              maxLines: 15,
              decoration: const InputDecoration(
                labelText: '正文 (Markdown 支持)',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text('插入图片'),
            ),
            if (imageUrl != null) Image.network(imageUrl!, height: 200),
          ],
        ),
      ),
    );
  }
}