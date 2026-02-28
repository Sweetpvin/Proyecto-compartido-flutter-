import 'package:flutter/material.dart';
import 'native_network_image.dart';

class PostItem extends StatelessWidget {
  final String userImage;
  final String username;
  final String postImage;

  const PostItem({
    Key? key,
    required this.userImage,
    required this.username,
    required this.postImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              ClipOval(
                child: SizedBox(width: 32, height: 32, child: NativeNetworkImage(imageUrl: userImage)),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(username, style: const TextStyle(fontWeight: FontWeight.bold))),
              const Icon(Icons.more_horiz),
            ],
          ),
        ),
        // Image
        NativeNetworkImage(imageUrl: postImage, width: double.infinity, height: 400),
        // Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(Icons.favorite_border, size: 26, color: textColor),
              const SizedBox(width: 16),
              Icon(Icons.chat_bubble_outline, size: 26, color: textColor),
              const SizedBox(width: 16),
              Icon(Icons.send, size: 26, color: textColor),
              const Spacer(),
              Icon(Icons.bookmark_border, size: 26, color: textColor),
            ],
          ),
        ),
        // Likes & Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Les gusta a juan_dev y 402 personas más', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(text: '$username ', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: 'Clonando interfaces con Flutter nativo 🚀 #FlutterDev'),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text('Ver los 15 comentarios', style: TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}