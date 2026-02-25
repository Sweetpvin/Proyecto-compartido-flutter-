import 'package:flutter/material.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Reels', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.send, color: Colors.white)),
        ],
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.network('https://picsum.photos/500/900?random=${index + 50}', fit: BoxFit.cover),
              // Gradient overlay
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                    ),
                  ),
                ),
              ),
              // Content
              Positioned(
                bottom: 30,
                left: 15,
                right: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3')),
                        const SizedBox(width: 10),
                        const Text('reels_creator', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(4)),
                          child: const Text('Follow', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text('This is a sample reel description #flutter #ui', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 10),
                    const Row(children: [
                      Icon(Icons.music_note, color: Colors.white, size: 12),
                      SizedBox(width: 5),
                      Text('Original Audio', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ]),
                  ],
                ),
              ),
              // Sidebar actions
              Positioned(
                bottom: 30,
                right: 15,
                child: Column(
                  children: [
                    _reelAction(Icons.favorite_border, '2.4M'),
                    _reelAction(Icons.chat_bubble_outline, '14K'),
                    _reelAction(Icons.send, ''),
                    const Icon(Icons.more_horiz, color: Colors.white),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _reelAction(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          if (label.isNotEmpty) Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}