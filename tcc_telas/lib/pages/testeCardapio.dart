import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTabView extends StatefulWidget {
  @override
  _MyTabViewState createState() => _MyTabViewState();
}

class _MyTabViewState extends State<MyTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initializae the TabController with the length of the tabs
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tab View'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Monday'),
            Tab(text: 'Tuesday'),
            Tab(text: 'Wednesday'),
            Tab(text: 'Thursday'),
            Tab(text: 'Friday'),
            Tab(text: 'Saturday'),
            Tab(text: 'Sunday'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('Monday')),
          Center(child: Text('Tuesday')),
          Center(child: Text('Wednesday')),
          Center(child: Text('Thursday')),
          Center(child: Text('Friday')),
          Center(child: Text('Saturday')),
          Center(child: Text('Sunday')),
        ],
      ),
    );
  }
}
