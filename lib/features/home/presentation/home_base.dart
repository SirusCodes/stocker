import 'package:flutter/material.dart';

import '../../transaction/widgets/cart_fab.dart';
import '../widgets/category_list_section.dart';
import '../widgets/more_section.dart';
import '../widgets/search_section.dart';
import '../widgets/statistics_section.dart';

class HomeBase extends StatefulWidget {
  const HomeBase({Key? key}) : super(key: key);

  static const path = "/home";

  @override
  State<HomeBase> createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {
  int _currentPage = 0;
  final PageStorageBucket _storageBucket = PageStorageBucket();

  static const List<Widget> _homeScreens = [
    CategoryListSection(),
    SearchSection(),
    StatisticsSection(),
    MoreSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _storageBucket,
        child: _homeScreens[_currentPage],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPage,
        onDestinationSelected: (int index) {
          setState(() => _currentPage = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list_rounded),
            label: "Categories",
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_rounded),
            label: "Statistics",
          ),
          NavigationDestination(
            icon: Icon(Icons.more_vert),
            label: "More",
          ),
        ],
      ),
      floatingActionButton: const CartFAB(),
    );
  }
}
