import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter_application_4/models/patient.dart';
import 'package:flutter_application_4/views/history.dart';
import 'package:flutter_application_4/views/main_view.dart';
import 'package:flutter_application_4/views/settings.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, this.patient});
  final Patient? patient;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _pageIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  // قائمة الصفحات المرتبطة بالأزرار
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      MainView(initialPatient: widget.patient),
      BookingRecordsPage(),
      SettingsPage(patient: widget.patient),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _pageIndex, children: _pages),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _pageIndex,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home, color: Colors.white),
            label: 'الرئيسية',
            labelStyle: TextStyle(fontFamily: 'almarai', color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.history, color: Colors.white),
            label: 'السجل',
            labelStyle: TextStyle(fontFamily: 'almarai', color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.settings, color: Colors.white),
            label: ' الإعدادات',
            labelStyle: TextStyle(fontFamily: 'almarai', color: Colors.white),
          ),
        ],
        color: Color(0xFF0F67FF),

        buttonBackgroundColor: Color(0xFF0F67FF),

        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}

class MyHoome extends StatelessWidget {
  const MyHoome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Smart Phone',
          style: TextStyle(fontFamily: 'almarai', fontWeight: FontWeight.bold),
        ),
        leading: Icon(Icons.menu),
        actions: [Icon(Icons.search)],
      ),
      body: Column(
        children: [
          Text(
            "Products",
            style: TextStyle(fontFamily: 'almarai', fontSize: 32),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12)],
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/1.png', width: 70),
                        SizedBox(height: 10),
                        Text('Apple', style: TextStyle(fontFamily: 'almarai')),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12)],
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/1.png', width: 70),
                        SizedBox(height: 10),
                        Text('Apple', style: TextStyle(fontFamily: 'almarai')),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12)],
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/1.png', width: 70),
                        SizedBox(height: 10),
                        Text('Apple', style: TextStyle(fontFamily: 'almarai')),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
