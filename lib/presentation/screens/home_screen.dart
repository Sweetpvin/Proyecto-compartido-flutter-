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
        SliverAppBar(
          floating: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Image.asset(
            AssetPaths.logoTexto,
            height: 35,
            color: isDark ? Colors.white : Colors.black,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline)),
          ],
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: MockData.usernames.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return StoryBubble(
                  imageUrl: MockData.profileImages[index],
                  username: MockData.usernames[index],
                  isMe: index == 0,
                );
              },
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final userIdx = index % MockData.usernames.length;
              final postIdx = index % MockData.postImages.length;
              return PostItem(
                userImage: MockData.profileImages[userIdx],
                username: MockData.usernames[userIdx],
                postImage: MockData.postImages[postIdx],
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }
}