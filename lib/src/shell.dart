import 'package:flutter/material.dart';
import 'package:mymoney_app/src/home.dart';
import 'package:mymoney_app/src/model/account_model.dart';
import 'package:mymoney_app/src/repository/account.dart';
import 'package:mymoney_app/src/state_management/menu_state.dart';
import 'package:mymoney_app/src/widget/menu.dart';
import 'package:provider/provider.dart';

class ShellPage extends StatefulWidget {
  @override
  _ShellPageState createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> with TickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 200);

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  AnimationController _controller;
  AnimationController _menuiconcontroller;
  Animation<double> _scaleAnimation;
  BorderRadius _borderRadius;
  Animation<Offset> _slideAnimation;
  Animation<double> _menuScaleAnimation;
  final _pageController = PageController(
    initialPage: 0,
  );

  Accounts futureAccount;
  AccountList _accountList = AccountList();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _menuiconcontroller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _borderRadius = BorderRadius.circular(0);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    _accountList.fetchAccounts().then((accounts) {
      futureAccount = accounts;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return ChangeNotifierProvider(
      create: (context) => MenuState(),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: Stack(
          children: <Widget>[
            SideMenu(
              context,
              controller: _controller,
              slideAnimation: _slideAnimation,
              menuScaleAnimation: _menuScaleAnimation,
            ),
            AnimatedPositioned(
              duration: duration,
              top: 0,
              bottom: 0,
              left: isCollapsed ? 0 : 0.6 * screenWidth,
              right: isCollapsed ? 0 : -0.2 * screenWidth,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: GestureDetector(
                  onTap: () {
                    if (!isCollapsed) {
                      _controller.reverse();
                      _menuiconcontroller.forward();
                      setState(() {
                        _borderRadius = BorderRadius.circular(0);
                        isCollapsed = true;
                      });
                    }
                  },
                  child: Material(
                    animationDuration: duration,
                    borderRadius: _borderRadius,
                    elevation: 8,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 48),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  child: AnimatedIcon(
                                    icon: AnimatedIcons.menu_close,
                                    progress: _controller,
                                  ),
                                  onTap: () {
                                    if (isCollapsed) {
                                      _controller.forward();
                                      _menuiconcontroller.reverse();
                                    } else {
                                      _controller.reverse();
                                      _menuiconcontroller.forward();
                                    }
                                    setState(() {
                                      isCollapsed
                                          ? _borderRadius =
                                              BorderRadius.circular(20.0)
                                          : _borderRadius =
                                              BorderRadius.circular(0);

                                      isCollapsed = !isCollapsed;
                                    });
                                  },
                                ),
                                Text(
                                  "My Cards",
                                  style: TextStyle(fontSize: 24),
                                ),
                                Icon(Icons.settings),
                              ],
                            ),
                            SizedBox(height: 50),
                            Container(
                              height: screenHeight,
                              width: screenWidth,
                              child: PageView(
                                children: <Widget>[
                                  HomePage(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
