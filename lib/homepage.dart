import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  
  int _selectedIndex = 0;
  late AnimationController _animationController;
  final List<String> _photoList = [
    'assets/photo_barcelona.jpg',
    'assets/photo_kotor.jpg',
    'assets/photo_netherlands.jpg',
    'assets/photo_slovenia.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Photobook'), centerTitle: true, backgroundColor: Colors.blueAccent,),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Image.asset(
            _photoList[_selectedIndex],
            key: ValueKey<int>(_selectedIndex),
            height: 400,
            width: 400,
          ),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[100],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_4),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}