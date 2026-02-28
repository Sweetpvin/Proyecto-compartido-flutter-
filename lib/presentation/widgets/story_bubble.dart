import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StoryBubble extends StatelessWidget {
  final String imageUrl;
  final String username;
  final bool isMe;

  const StoryBubble({Key? key, required this.imageUrl, required this.username, this.isMe = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Column(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isMe ? null : const LinearGradient(
                colors: [Color(0xFFf9ce34), Color(0xFFee2a7b), Color(0xFF6228d7)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            padding: const EdgeInsets.all(2.5), // Borde gradiente
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).scaffoldBackgroundColor, // Borde blanco/negro interno
              ),
              padding: const EdgeInsets.all(2.5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey[300]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(username, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}