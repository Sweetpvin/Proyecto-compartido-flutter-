import 'package:flutter/material.dart';
import 'widgets/story_row.dart';
import 'widgets/post_card.dart';
import '../../shared/models/post_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = PostModel.generateDummyPosts(10);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Instagram',
          style: TextStyle(fontFamily: 'Billabong', fontSize: 32), // Asumiendo fuente personalizada o fallback
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.messenger_outline)),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length + 1, // +1 para las stories
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                const StoryRow(),
                Divider(color: Colors.grey[200], height: 1),
              ],
            );
          }
          return PostCard(post: posts[index - 1]);
        },
      ),
    );
  }
}