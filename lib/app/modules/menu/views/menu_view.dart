import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView>
    with SingleTickerProviderStateMixin {
  static const Color green = Color(0xFF1E8E6E);

  String selectedGoal = 'Gain Weight';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('Menu'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            /// GOAL DROPDOWN
            DropdownButtonFormField<String>(
              value: selectedGoal,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconEnabledColor: Colors.white,
              
              items: const [
                DropdownMenuItem(
                  value: 'Gain Weight',
                  child: Text('Gain Weight'),
                ),
                DropdownMenuItem(
                  value: 'Lose Weight',
                  child: Text('Lose Weight'),
                ),
                DropdownMenuItem(
                  value: 'Maintain',
                  child: Text('Maintain'),
                ),
              ],
              
              selectedItemBuilder: (context) {
                return ['Gain Weight', 'Lose Weight', 'Maintain']
                    .map(
                      (item) => Text(
                        item,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                    .toList();
              },

              onChanged: (value) {
                setState(() {
                  selectedGoal = value!;
                });
              },

              dropdownColor: Colors.white,

              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),

              decoration: InputDecoration(
                filled: true,
                fillColor: green,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// TAB BAR
            TabBar(
              controller: _tabController,
              labelColor: green,
              unselectedLabelColor: Colors.grey,
              indicatorColor: green,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'Breakfast'),
                Tab(text: 'Dinner'),
                Tab(text: 'Snack'),
              ],
            ),

            const SizedBox(height: 10),

            /// TAB CONTENT
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _menuList(),
                  _menuList(),
                  _menuList(),
                ],
              ),
            ),
          ],
        ),
      ),

      /// BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) Get.toNamed('/home');
          if (index == 1) Get.toNamed('/fooddetection');
          if (index == 2) Get.toNamed('/profile');
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            label: 'Food Detection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  /// MENU LIST
  Widget _menuList() {
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: const [
        _MenuItem(
          title: 'Chicken Porridge, Boiled Egg',
          kcal: '480 kcal',
        ),
        _MenuItem(
          title: 'Rib Soup, Rice',
          kcal: '620 kcal',
        ),
        _MenuItem(
          title: 'Avocado Milk Juice',
          kcal: '320 kcal',
        ),
        _MenuItem(
          title: 'Green Bean Porridge without Coconut Milk',
          kcal: '140 kcal',
        ),
      ],
    );
  }
}

/// MENU ITEM CARD
class _MenuItem extends StatelessWidget {
  final String title;
  final String kcal;

  const _MenuItem({
    required this.title,
    required this.kcal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// IMAGE
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.image, color: Colors.grey),
          ),

          const SizedBox(width: 14),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  kcal,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
