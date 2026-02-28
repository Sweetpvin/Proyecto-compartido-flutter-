import 'package:flutter/material.dart';
import '../../core/constants/asset_paths.dart';
import '../../data/mock_data.dart';
import '../widgets/story_bubble.dart';
import '../widgets/post_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomScrollView(
      slivers: [
        // AppBar Flotante
        SliverAppBar(
          floating: true,
          centerTitle: false,
          // AQUÍ USAMOS TU IMAGEN "InstagramLetra.png"
          title: Image.asset(
            AssetPaths.logoTexto,
            height: 40, // Altura estándar
            color: isDark ? Colors.white : Colors.black, // Tintado dinámico
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.message_outlined)),
          ],
        ),

        // Lista de Historias
        SliverToBoxAdapter(
          child: SizedBox(
            height: 105,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: MockData.usernames.length,
              itemBuilder: (context, index) {
                return StoryBubble(
                  imageUrl: MockData.profileImages[index],
                  username: MockData.usernames[index],
                  isMe: index == 0, // El primero soy yo
                );
              },
            ),
          ),
        ),

        // Lista de Posts
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              // Usamos módulo para repetir datos infinitamente
              final userIdx = index % MockData.usernames.length;
              final postIdx = index % MockData.postImages.length;
              return PostItem(
                userImage: MockData.profileImages[userIdx],
                username: MockData.usernames[userIdx],
                postImage: MockData.postImages[postIdx],
              );
            },
            childCount: 10, // Cantidad de posts simulados
          ),
        ),
      ],
    );
  }
}