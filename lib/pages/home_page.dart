import 'package:bezzie_app/pages/ai_chat_page.dart';
import 'package:bezzie_app/pages/chat_page.dart';
import 'package:bezzie_app/pages/display_users_page.dart';
import 'package:bezzie_app/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 2;
  static final List<Widget> _bodyView = <Widget>[
    ProfilePage(),
    AiChatPage(),
    ChatPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  Widget _tabItem(Widget child, String label, {bool isSelected = false}) {
    return AnimatedContainer(
      margin: EdgeInsets.all(8),
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 500),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.black,
            ),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }

  final List<String> _labels = ['Home', 'maps', 'camera'];

  @override
  Widget build(BuildContext context) {
    List<Widget> _icons = [
      Icon(
        Icons.person_outline,
        size: 24.sp,
      ),
      Icon(
        Icons.abc_outlined,
        size: 24.sp,
      ),
      Icon(
        Icons.chat_bubble_outline,
        size: 24.sp,
      )
    ];

    return Scaffold(
      body: Center(
        child: _bodyView.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Container(
            color: Colors.teal.withOpacity(0.25),
            child: TabBar(
              onTap: (x) {
                setState(() {
                  _selectedIndex = x;
                });
              },
              labelColor: Colors.white,
              unselectedLabelColor: Colors.blueGrey,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide.none,
              ),
              tabs: [
                for (int i = 0; i < _icons.length; i++)
                  _tabItem(
                    _icons[i],
                    _labels[i],
                    isSelected: i == _selectedIndex,
                  ),
              ],
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }
}
