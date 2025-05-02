import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomButtomNavigationBar extends StatelessWidget {
  const CustomButtomNavigationBar({super.key});

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location == '/') {
      return 0;
    } else if (location == '/categories') {
      return 1;
    } else if (location == '/favorites') {
      return 2;
    }
    return 0; // Default to home if no match found
  }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        // Handle categories tap
        context.go('/');
        break;
      case 2:
        // Handle favorites tap
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          label: 'Favorites',
        ),
      ],
      currentIndex: getCurrentIndex(context),
      onTap: (int index) => onItemTapped(context, index),
    );
  }
}
