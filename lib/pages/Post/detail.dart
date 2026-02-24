import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:seronium_flutter/api/post.dart';

class PostDetailScreen extends StatelessWidget {
  final String postId;

  const PostDetailScreen({required this.postId, super.key});

  @override
  Widget build(BuildContext context) {
    // 这里后续可以从 API 拉取真实数据，暂时用假数据演示
    final post = GetPost(postId);
    // Post(
    //   id: int.parse(postId),
    //   userId: 1,
    //   title: "Flutter 和 Go 如何通信？",
    //   content: "# 这是一篇 Markdown 文章\n\n支持**加粗**、*斜体*、图片等",
    //   type: "question",
    //   status: "published",
    //   viewCount: 128,
    //   createdAt: DateTime.now(),
    // );

    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MarkdownBody(data: post.content, styleSheet: MarkdownStyleSheet(p: const TextStyle(fontSize: 17))),
            const SizedBox(height: 40),
            const Text("评论区", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            // 这里后续添加评论列表
          ],
        ),
      ),
    );
  }
}