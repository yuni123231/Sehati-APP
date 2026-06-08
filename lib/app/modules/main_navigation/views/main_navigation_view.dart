import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../progres/views/progres_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {

  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeView(),
    const ProgresView(),
    const ProfileView(),
  ];

  static const Color primary = Color(0xFF4ADE80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// ================= BODY =================
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      /// ================= BOTTOM NAV =================
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),

        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,

            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },

            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,

            selectedItemColor: primary,
            unselectedItemColor: Colors.grey.shade400,

            selectedFontSize: 12,
            unselectedFontSize: 11,

            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
            ),

            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),

            items: [

              /// HOME
              BottomNavigationBarItem(
                label: "Home",
                icon: AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: currentIndex == 0 ? 1.15 : 1,
                  child: Icon(
                    Icons.home_rounded,
                    size: 27,
                  ),
                ),
              ),

              /// PROGRESS
              BottomNavigationBarItem(
                label: "Laporan",
                icon: AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: currentIndex == 1 ? 1.15 : 1,
                  child: Icon(
                    Icons.insights_rounded,
                    size: 27,
                  ),
                ),
              ),

              /// PROFILE
              BottomNavigationBarItem(
                label: "Profil",
                icon: AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: currentIndex == 2 ? 1.15 : 1,
                  child: Icon(
                    Icons.person_rounded,
                    size: 27,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}