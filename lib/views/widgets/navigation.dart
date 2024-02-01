import 'package:dine_in/core/utils/k_color_scheme.dart';
import 'package:dine_in/core/utils/responsive.dart';
import 'package:dine_in/views/screens/category/category.dart';
import 'package:dine_in/views/screens/dashboard.dart';
import 'package:dine_in/views/screens/items/items.dart';
import 'package:dine_in/views/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconsax/flutter_iconsax.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 4;
  bool _isExtended = true;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void toggleExtendedState() {
    setState(() {
      _isExtended = !_isExtended;
    });
  }

  @override
  void initState() {
    _isWebPage = [
      const DashBoardPage(),
      const DashBoardPage(),
      const DashBoardPage(),
      const ItemsPage(),
      const CategoryPage(),
      const ProfilePage(),
    ];

    super.initState();
  }

  List<Widget> _isWebPage = [];
  void changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
        key: scaffoldKey,
        body: Row(
          children: [
            Material(
              elevation: 8.0,
              child: NavigationRail(
                backgroundColor: Colors.white,
                leading: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: Utils.screenHeight(context) * 0.24,
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: Image.asset(
                    'assets/logo_with_name.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                extended: true,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                indicatorColor: CustomColors.primary,
                destinations: [
                  navigationItems(
                    context: context,
                    text: 'DashBoard',
                    initialIcon: const Icon(Iconsax.category),
                  ),
                  navigationItems(
                    context: context,
                    text: 'Orders',
                    initialIcon: const Icon(Iconsax.omega_circle),
                  ),
                  navigationItems(
                    context: context,
                    text: 'Tables',
                    initialIcon: const Icon(Iconsax.shop_remove),
                  ),
                  navigationItems(
                    context: context,
                    text: 'Items',
                    initialIcon: const Icon(Iconsax.forward_item4),
                  ),
                  navigationItems(
                    context: context,
                    text: 'Categories',
                    initialIcon: const Icon(Iconsax.category),
                  ),
                  navigationItems(
                    context: context,
                    text: 'Profile',
                    initialIcon: const Icon(Iconsax.profile_2user),
                  ),
                ],
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: _isWebPage.elementAt(_selectedIndex),
            ),
          ],
        ),
      );
    });
  }
}

NavigationRailDestination navigationItems({
  required BuildContext context,
  required String text,
  required Icon initialIcon,
}) {
  return NavigationRailDestination(
    icon: initialIcon,
    label: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.outline,
            ),
      ),
    ),
  );
}
