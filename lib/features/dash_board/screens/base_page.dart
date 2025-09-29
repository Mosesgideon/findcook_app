
import 'package:find_cook/common/widgets/custom_appbar.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../feeds/presentations/screens/app_feeds.dart';
import '../../home_screen/presentations/screens/home_screen.dart';
import '../../mybookings/presentations/screens/mybookings.dart';
import '../../settings/presentations/screens/settings.dart';



class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final controller = ScrollController();
  int selectedIndex=0;

  static List<StatefulWidget> pages =[
    HomeScreen(),
    Mybookings(),
    AppFeeds(),
    AppSettinggs(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(



      extendBody: true,
      body: IndexedStack(index: selectedIndex, children: pages),

      bottomNavigationBar: BottomNavigationBar(
        elevation: 3,

        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xfffaad65),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: (index)=>setState(() {
          selectedIndex=index;
        }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.my_library_books), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Feeds'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
