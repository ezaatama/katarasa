import 'package:flutter/material.dart';
import 'package:katarasa/tabs/favorite_screen.dart';
import 'package:katarasa/tabs/home_screen.dart';
import 'package:katarasa/tabs/location_screen.dart';
import 'package:katarasa/tabs/profile_screen.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/bottom_nav.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 1;
  late PageController _pageController;

  @override
  void initState() {
    _setPage();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> _screens() {
    return [LocationScreen(), HomeScreen(), FavoriteScreen(), ProfileScreen()];
  }

  void _setPage() {
    int initialPage = 1;
    _pageController = PageController(initialPage: initialPage);
    if (initialPage > 1) {
      setState(() {
        _currentIndex = initialPage;
      });
    }
  }

  void _onPageChanged({required int page, int? historyTab}) {
    if (_pageController.hasClients) {
      _pageController.jumpToPage(page);
    }
    setState(() {
      _currentIndex = page;
      if (page == 1 && historyTab != null) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUI.WHITE,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _screens(),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 8.0,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
            height: 75,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: bottomButton("Locations", "Pin", () {
                    _onPageChanged(page: 0);
                  }, _currentIndex == 0),
                ),
                Container(
                  child: bottomButton("Home", "Home", () {
                    _onPageChanged(page: 1);
                  }, _currentIndex == 1),
                ),
                Container(
                  child: bottomButton("Favorite", "Favorite", () {
                    _onPageChanged(page: 2);
                  }, _currentIndex == 2),
                ),
                Container(
                  child: bottomButton("Account", "User", () {
                    _onPageChanged(page: 3);
                  }, _currentIndex == 3),
                ),
              ],
            )),
      ),
    );
  }
}
