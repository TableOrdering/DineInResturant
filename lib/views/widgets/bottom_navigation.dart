import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:dine_in_resturant/core/utils/k_color_scheme.dart';
import 'package:dine_in_resturant/views/screens/category/category.dart';
import 'package:dine_in_resturant/views/screens/dashboard.dart';
import 'package:dine_in_resturant/views/screens/items/items.dart';
import 'package:dine_in_resturant/views/screens/profile/profile.dart';
import 'package:dine_in_resturant/views/screens/table/tables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconsax/flutter_iconsax.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  late PageController _pageController;
  late NotchBottomBarController _controller;
  int maxCount = 5;
  int intialIndex = 2;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: intialIndex);
    _controller = NotchBottomBarController(index: intialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          DashBoardPage(),
          TablesPage(),
          ItemsPage(),
          CategoryPage(),
          ProfilePage(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.white,
        showLabel: false,
        shadowElevation: 5,
        kBottomRadius: 28.0,
        notchColor: CustomColors.primary,
        removeMargins: false,
        bottomBarWidth: 500,
        durationInMilliSeconds: 300,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_filled,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Colors.blueAccent,
            ),
            itemLabel: 'DashBoard',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Iconsax.menu_board,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Iconsax.menu_board4,
              color: Colors.white,
            ),
            itemLabel: 'Tables',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.fastfood_rounded,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.fastfood_rounded,
              color: Colors.white,
            ),
            itemLabel: 'Items',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Iconsax.category,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Iconsax.category,
              color: Colors.white,
            ),
            itemLabel: 'Categogies',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.person,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.person,
              color: Colors.yellow,
            ),
            itemLabel: 'Profile',
          ),
        ],
        onTap: (index) {
          // Update the page index when bottom navigation bar item is tapped
          _pageController.jumpToPage(index);
        },
        kIconSize: 24.0,
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow, child: const Center(child: Text('Page 1')));
  }
}

class Page2 extends StatelessWidget {
  const Page2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page 2'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the callback function to change the index to 0
              },
              child: Text('Go to Page 1'),
            ),
          ],
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red, child: const Center(child: Text('Page 3')));
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue, child: const Center(child: Text('Page 4')));
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreenAccent,
        child: const Center(child: Text('Page 5')));
  }
}
