
import 'package:flutter/material.dart';
import 'package:get/get.dart';





class HomeViwController extends GetxController {

  int _navigatorValue = 0;
  String _currentPage = 'Page1';
    late var _navigatorKey;

  List<String> _pageKeys = ['Page1', 'Page2', 'Page3', 'Page4', 'Page5'];

  get navigatorValue => _navigatorValue;

  get currentPage => _currentPage;

  get navigatorKey => _navigatorKey;

  get navigatorKeys => _navigatorKeys;

  get pageKeys => _pageKeys;
  static final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    'Page1': GlobalKey<NavigatorState>(),
    'Page2': GlobalKey<NavigatorState>(),
    'Page3': GlobalKey<NavigatorState>(),
    'Page4': GlobalKey<NavigatorState>(),
    'Page5': GlobalKey<NavigatorState>(),
  };

  Widget currentScreen=Container();

  @override
  void onInit() {
    super.onInit();
    currentScreen = PageToView(
      naigatorKey: _navigatorKeys[_pageKeys[0]]! ,
      tabItem: _pageKeys[0],
    ); //=HomeView();
  }

  changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    _currentPage = _pageKeys[selectedValue];
    _navigatorKey = _navigatorKeys[_currentPage];

    currentScreen = PageToView(
      naigatorKey: _navigatorKey,
      tabItem: _currentPage,
    );

    update();
  }

  Widget buildoffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: PageToView(
        naigatorKey: _navigatorKeys[tabItem]! ,
        tabItem: tabItem,
      ),
    );
  }

  gotomun() {
    // Get.to(() => MenuView());
  }
}

class PageToView extends StatelessWidget {
  late GlobalKey<NavigatorState> naigatorKey;
  late String tabItem;

    PageToView({  required this.naigatorKey,   required this.tabItem});

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = Container();

    switch (tabItem) {
      case 'Page1':
        {
          currentScreen = Container();

          break;
        }
      case 'Page2':
        {
          currentScreen = Container();

          break;
        }
      case 'Page3':
        {
          currentScreen = Container();
          break;
        }
      case 'Page4':
        {

          currentScreen = Container();
          break;
        }
      case 'Page5':
        {





          currentScreen =  Container();
          break;
        }
    }

    return Navigator(
      key: naigatorKey,
      onGenerateRoute: (routeStings) {
        return MaterialPageRoute(builder: (context) => currentScreen);
      },
    );
  }
}
//
// Widget build(BuildContext context) {
//   Size size = MediaQuery.of(context).size;
//   return WillPopScope(
//       onWillPop: () async {
//         final isFirstRouteInCurrentTab = !await controller
//             .navigatorKeys[controller.currentPage].currentState
//             .maybePop();
//         //   print(isFirstRouteInCurrentTab);
//         if (isFirstRouteInCurrentTab) {
//           if (controller.currentPage != "Page1") {
//             controller.changeSelectedValue(0);
//
//             return false;
//           }
//         }
//         print(isFirstRouteInCurrentTab);
//         // let system handle back button if we're on the first route
//         return isFirstRouteInCurrentTab;
//       },
//       child: SafeArea(
//           child: Scaffold(
//           body: GetBuilder<HomeViwController>(builder: (logic) {
//   return logic.currentScreen;
//   }),