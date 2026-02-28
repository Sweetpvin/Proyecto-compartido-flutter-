import 'package:flutter/material.dart';
import '../../core/constants/asset_paths.dart';
import '../../data/mock_data.dart';
import '../widgets/native_network_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverList(
            delegate: SliverChildListDelegate([
              _buildHeader(context),
              _buildBio(context),
              _buildButtons(context),
              _buildHighlights(context),
            ]),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
               TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(icon: Icon(Icons.grid_on)),
                  Tab(icon: Icon(Icons.person_pin_outlined)),
                ],
              ),
              Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
        body: TabBarView(
          children: [
            _buildGrid(),
            const Center(child: Text("Sin etiquetas")),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[200],
            backgroundImage: const AssetImage(AssetPaths.logoIcono),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _stat("102", "Posts"),
                _stat("5.2k", "Seguidores"),
                _stat("230", "Seguidos"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) => Column(
    children: [
      Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      Text(label, style: const TextStyle(fontSize: 13)),
    ],
  );

  Widget _buildBio(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ingeniero Multimedia", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Desarrollando clones de alto nivel 📱\nFlutter Nativo 100%"),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[200];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(child: _btn("Editar Perfil", color)),
          const SizedBox(width: 8),
          Expanded(child: _btn("Compartir", color)),
        ],
      ),
    );
  }

  Widget _btn(String text, Color? color) => Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
    alignment: Alignment.center,
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );

  Widget _buildHighlights(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: 4,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.add, color: Colors.black),
              ),
              const SizedBox(height: 4),
              const Text("Nuevo", style: TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2,
      ),
      itemCount: 21,
      itemBuilder: (_, i) => NativeNetworkImage(
        imageUrl: MockData.postImages[i % MockData.postImages.length],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  final Color _bgColor;
  _SliverAppBarDelegate(this._tabBar, this._bgColor);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: _bgColor, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}