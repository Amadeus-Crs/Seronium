import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:seronium_flutter/viewmodels/post.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => context.go('/post/${post.id}'),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 18, backgroundColor: Colors.blue),
                  const SizedBox(width: 12),
                  Text(post.title, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 12),
              MarkdownBody(
                data: post.content.length > 120
                    ? "${post.content.substring(0, 120)}..."
                    : post.content,
                styleSheet: MarkdownStyleSheet(p: const TextStyle(fontSize: 15)),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${post.viewCount} 浏览', style: Theme.of(context).textTheme.bodySmall),
                  Text(post.type == 'question' ? '问题' : '文章'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}