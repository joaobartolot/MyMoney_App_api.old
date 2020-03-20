import 'package:flutter/material.dart';
import 'package:mymoney_app/src/model/account_model.dart';
import 'package:mymoney_app/src/repository/account.dart';
import 'package:mymoney_app/src/widget/menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 200);
  AnimationController _controller;
  AnimationController _menuiconcontroller;
  Animation<double> _scaleAnimation;
  BorderRadius _borderRadius;
  Animation<Offset> _slideAnimation;
  Animation<double> _menuScaleAnimation;

  Account futureAccount;
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

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Stack(
        children: <Widget>[
          SideMenu(
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
                  setState(() {
                    if (!isCollapsed) {
                      _controller.reverse();
                      _menuiconcontroller.forward();
                      _borderRadius = BorderRadius.circular(0);
                    }
                    isCollapsed = true;
                  });
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
                                  setState(() {
                                    if (isCollapsed) {
                                      _controller.forward();
                                      _menuiconcontroller.reverse();
                                      _borderRadius =
                                          BorderRadius.circular(20.0);
                                    } else {
                                      _controller.reverse();
                                      _menuiconcontroller.forward();
                                      _borderRadius = BorderRadius.circular(0);
                                    }

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
                            height: 145,
                            child: PageView(
                              onPageChanged: (a) {
                                print(a);
                              },
                              controller: PageController(viewportFraction: 0.8),
                              scrollDirection: Axis.horizontal,
                              pageSnapping: true,
                              children: <Widget>[
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/images/Nubank.png'),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/images/Santander.png'),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/images/Ticket.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Transactions",
                            style: TextStyle(fontSize: 20),
                          ),
                          ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("Macbook"),
                                  subtitle: Text("Apple"),
                                  trailing: Text("-2900"),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(height: 16);
                              },
                              itemCount: 10)
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
    );
  }
}
