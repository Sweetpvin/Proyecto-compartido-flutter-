import 'package:flutter/material.dart';
import 'home_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Pantallas placeholder para el ejemplo
  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Icon(Icons.search, size: 60)), // Buscador
    const Center(child: Icon(Icons.add_box_outlined, size: 60)), // Agregar
    const Center(child: Icon(Icons.movie_creation_outlined, size: 60)), // Reels
    const Center(child: Icon(Icons.person_outline, size: 60)), // Perfil (Aquí iría el otro logo)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack( // Mantiene el estado de las pantallas
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Crucial para 5 items
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.movie_creation_outlined), label: 'Reels'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}