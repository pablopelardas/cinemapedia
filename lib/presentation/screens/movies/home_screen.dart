import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  static const String name = 'home-screen';
  final Widget childView;
  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: const CustomButtomNavigationBar(),
    );
  }
}
