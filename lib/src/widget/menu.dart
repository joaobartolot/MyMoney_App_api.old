import 'package:flutter/material.dart';
import 'package:mymoney_app/app_const.dart';
import 'package:mymoney_app/src/state_management/menu_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatelessWidget {
  final BuildContext context;
  final AnimationController controller;
  final Animation<Offset> slideAnimation;
  final Animation<double> menuScaleAnimation;

  const SideMenu(this.context,
      {this.controller, this.slideAnimation, this.menuScaleAnimation});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MenuState>(context);
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: menuScaleAnimation,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MenuButton(
                        icon: Icons.dashboard,
                        text: 'Dasboard',
                        onPressed: () => state.currentPage = 0,
                      ),
                      MenuButton(
                        icon: Icons.message,
                        text: 'Message',
                        onPressed: () => state.currentPage = 1,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  child: MenuButton(
                    icon: Icons.exit_to_app,
                    text: 'Logout',
                    onPressed: () => _logout(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _logout() {
    var prefs = SharedPreferences.getInstance().then((pref) {
      pref.setString(token_key, null);
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (Route<dynamic> route) => false,
      );
    });
  }
}

class MenuButton extends StatelessWidget {
  final int index;
  final IconData icon;
  final String text;
  final Function onPressed;

  const MenuButton(
      {this.index, this.icon, this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
