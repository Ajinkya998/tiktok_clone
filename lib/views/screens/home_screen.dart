import 'package:flutter/material.dart';
import 'package:tiktok_clone/constant.dart';
import 'package:tiktok_clone/views/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int pageIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: pageIndex,
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 30), label: 'Search'),
            BottomNavigationBarItem(icon: CustomIcon(), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.message, size: 30), label: 'Message'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30), label: 'Profile'),
          ]),
      body: pages[pageIndex],
    );
  }
}
