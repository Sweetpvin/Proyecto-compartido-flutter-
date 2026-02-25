import 'package:flutter/material.dart';
import '../../../shared/models/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(post.userImage),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(post.username, style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
            ],
          ),
        ),
        // Image
        AspectRatio(
          aspectRatio: 1,
          child: Image.network(post.postImage, fit: BoxFit.cover),
        ),
        // Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border, size: 28)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline, size: 26)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.send_outlined, size: 26)),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border, size: 26)),
            ],
          ),
        ),
        // Info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${post.likes} likes', style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(text: post.username, style: const TextStyle(fontWeight: FontWeight.w600)),
                    TextSpan(text: ' ${post.caption}'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text('View all comments', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              const SizedBox(height: 4),
              Text('2 hours ago', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}