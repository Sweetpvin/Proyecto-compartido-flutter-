import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 440,
                floating: false,
                pinned: true,
                title: const Text('flutter_dev'),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add_box_outlined)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Column(
                      children: [
                        // Profile Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5')),
                            _buildStat('54', 'Posts'),
                            _buildStat('15.2K', 'Followers'),
                            _buildStat('230', 'Following'),
                          ],
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Senior Flutter Dev', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Tech Enthusiast | Open Source'),
                                Text('linktr.ee/dev', style: TextStyle(color: Colors.blue)),
                              ],
                            ),
                          ),
                        ),
                        // Buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Expanded(child: OutlinedButton(child: const Text('Edit Profile'), onPressed: () {})),
                              const SizedBox(width: 10),
                              Expanded(child: OutlinedButton(child: const Text('Share Profile'), onPressed: () {})),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: const TabBar(
                  tabs: [Tab(icon: Icon(Icons.grid_on)), Tab(icon: Icon(Icons.person_pin_outlined))],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1, crossAxisSpacing: 1, mainAxisSpacing: 1),
                itemCount: 15,
                itemBuilder: (ctx, i) => Image.network('https://picsum.photos/400/400?random=${i + 300}', fit: BoxFit.cover),
              ),
              GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1, crossAxisSpacing: 1, mainAxisSpacing: 1),
                itemCount: 5,
                itemBuilder: (ctx, i) => Image.network('https://picsum.photos/400/400?random=${i + 400}', fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String count, String label) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}