import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> new _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.pageCurrent, 
      onTap: (index){
        navigationModel.pageCurrent=index;
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), title: Text("Para ti")),
        BottomNavigationBarItem(
            icon: Icon(Icons.public), title: Text("Encabezados"))
      ]);
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      //physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2Page()
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _pageCurrent = 0;
  PageController _pageController = new PageController();

  int get pageCurrent => this._pageCurrent;

  set pageCurrent(int value) {
    this._pageCurrent = value;

    _pageController.animateToPage(value, duration: Duration(microseconds: 250), curve: Curves.easeOut);

    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
