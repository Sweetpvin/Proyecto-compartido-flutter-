class PostModel {
  final String username;
  final String userImage;
  final String postImage;
  final String caption;
  final int likes;
  final bool isLiked;

  PostModel({
    required this.username,
    required this.userImage,
    required this.postImage,
    required this.caption,
    required this.likes,
    this.isLiked = false,
  });

  // Generador de datos de prueba
  static List<PostModel> generateDummyPosts(int count) {
    return List.generate(count, (index) {
      return PostModel(
        username: 'user_${index + 1}',
        userImage: 'https://i.pravatar.cc/150?img=${(index % 70) + 1}',
        postImage: 'https://picsum.photos/600/600?random=${index + 100}',
        caption: 'Exploring the world with Flutter! 🌍 #coding #flutterdev',
        likes: 100 + (index * 15),
      );
    });
  }
}