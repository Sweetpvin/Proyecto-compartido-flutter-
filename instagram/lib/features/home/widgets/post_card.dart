import 'dart:typed_data'; // CORRECCIÓN: Import añadido
import 'package:flutter/material.dart';
import '../../../shared/models/post_model.dart';
import '../../../shared/widgets/shimmer_loading.dart';

class PostCard extends StatefulWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with SingleTickerProviderStateMixin {
  bool isLiked = false;
  bool isSaved = false;
  
  late AnimationController _heartController;
  late Animation<double> _heartScale;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    
    _heartScale = Tween<double>(begin: 0.0, end: 1.2).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.elasticOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _heartController.reverse();
        }
      });
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  void _onDoubleTap() {
    if (!isLiked) {
      setState(() {
        isLiked = true;
      });
    }
    _heartController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.pink, Colors.orange, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(widget.post.userImage),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      widget.post.username,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    const SizedBox(width: 5),
                    if (widget.post.username == 'user_1')
                      const Icon(Icons.verified, color: Colors.blue, size: 16),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
            ],
          ),
        ),

        // Imagen con Double Tap
        GestureDetector(
          onDoubleTap: _onDoubleTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget.post.postImage,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (c, o, s) => Container(color: Colors.grey[300], child: const Icon(Icons.error)),
                  placeholderErrorBuilder: (c, o, s) => ShimmerLoading(
                    child: Container(color: Colors.grey[300]),
                  ),
                ),
              ),
              // Corrección: AnimatedBuilder
              AnimatedBuilder(
                animation: _heartController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _heartScale.value,
                    child: Opacity(
                      opacity: _heartController.status == AnimationStatus.dismissed ? 0.0 : 1.0,
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 100,
                        shadows: [Shadow(color: Colors.black45, blurRadius: 15)],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        // Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
          child: Row(
            children: [
              _AnimatedIconButton(
                isActive: isLiked,
                activeIcon: Icons.favorite,
                inactiveIcon: Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.black,
                onPressed: _toggleLike,
              ),
              const SizedBox(width: 4),
              IconButton(onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline, size: 26)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.send_outlined, size: 26)),
              const Spacer(),
              _AnimatedIconButton(
                isActive: isSaved,
                activeIcon: Icons.bookmark,
                inactiveIcon: Icons.bookmark_border,
                onPressed: () => setState(() => isSaved = !isSaved),
              ),
            ],
          ),
        ),

        // Info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.post.likes + (isLiked ? 1 : 0)} likes',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: widget.post.username, style: const TextStyle(fontWeight: FontWeight.w600)),
                    const TextSpan(text: "  "),
                    TextSpan(text: widget.post.caption),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'View all comments',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                '2 hours ago',
                style: TextStyle(color: Colors.grey[500], fontSize: 11),
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnimatedIconButton extends StatelessWidget {
  final bool isActive;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final VoidCallback onPressed;
  final Color color;

  const _AnimatedIconButton({
    required this.isActive,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.onPressed,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 20,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Icon(
          isActive ? activeIcon : inactiveIcon,
          key: ValueKey<bool>(isActive),
          color: color,
          size: 26,
        ),
      ),
    );
  }
}

// Definición correcta de la imagen transparente con import dart:typed_data
final Uint8List kTransparentImage = Uint8List.fromList([
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82
]);