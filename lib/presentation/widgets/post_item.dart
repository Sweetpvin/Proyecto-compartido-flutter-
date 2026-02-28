import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/asset_paths.dart'; // Importa tus assets

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
    final textColor = Theme.of(context).colorScheme.onBackground;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Header del Post
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
            radius: 16,
          ),
          title: Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.more_horiz, color: textColor),
        ),
        
        // 2. Imagen del Post
        CachedNetworkImage(
          imageUrl: postImage,
          width: double.infinity,
          height: 400,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(height: 400, color: Colors.grey[900]),
        ),

        // 3. Botones de Acción
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(Icons.favorite_border, size: 28, color: textColor),
              const SizedBox(width: 16),
              Icon(Icons.chat_bubble_outline, size: 28, color: textColor),
              const SizedBox(width: 16),
              Icon(Icons.send, size: 28, color: textColor),
              const Spacer(),
              Icon(Icons.bookmark_border, size: 28, color: textColor),
            ],
          ),
        ),

        // 4. Likes y Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Les gusta a carlo_dev y 4,320 personas más', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textColor)),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: textColor),
                  children: [
                    TextSpan(text: '$username ', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: 'Disfrutando del desarrollo con Flutter! 🚀 #Code #FlutterDev'),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text('Ver los 20 comentarios', style: TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}