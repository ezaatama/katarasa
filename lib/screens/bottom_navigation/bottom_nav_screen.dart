import 'package:flutter/material.dart';
import 'package:katarasa/tabs/all_order_screen.dart';
import 'package:katarasa/tabs/favorite_screen.dart';
import 'package:katarasa/tabs/home_screen.dart';
import 'package:katarasa/tabs/profile_screen.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/bottom_nav.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;
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
    return [const HomeScreen(), const AllOrderScreen(), const ProfileScreen()];
  }

  void _setPage() {
    int initialPage = 0;
    _pageController = PageController(initialPage: initialPage);
    if (initialPage > 0) {
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
        color: ColorUI.PRIMARY_GREEN,
        elevation: 8.0,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
            height: 75,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: bottomButton("Home", "ic_home", () {
                    _onPageChanged(page: 0);
                  }, _currentIndex == 0, context),
                ),
                Container(
                  child: bottomButton("Order", "ic_order", () {
                    _onPageChanged(page: 1);
                  }, _currentIndex == 1, context),
                ),
                Container(
                  child: bottomButton("Account", "ic_profile", () {
                    _onPageChanged(page: 2);
                  }, _currentIndex == 2, context),
                ),
              ],
            )),
      ),
    );
  }
}
