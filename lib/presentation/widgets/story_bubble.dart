import 'package:flutter/material.dart';
import 'native_network_image.dart';

class StoryBubble extends StatelessWidget {
  final String imageUrl;
  final String username;
  final bool isMe;

  const StoryBubble({Key? key, required this.imageUrl, required this.username, this.isMe = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isMe ? null : const LinearGradient(
                colors: [Color(0xFFf9ce34), Color(0xFFee2a7b), Color(0xFF6228d7)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? Colors.black : Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: NativeNetworkImage(imageUrl: imageUrl),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(username, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}