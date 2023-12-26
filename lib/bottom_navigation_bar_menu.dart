import 'package:flutter/material.dart';
import 'package:ponto_tattoo/models/user_model.dart';
import 'package:ponto_tattoo/repositories/user_repository.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/feed/feed_page.dart';
import 'package:ponto_tattoo/ui/notification/notification_list_page.dart';
import 'package:ponto_tattoo/ui/profile/profile_menu_page.dart';
import 'package:ponto_tattoo/ui/schedule/schedule_page.dart';

class BottomNavigationBarMenu extends StatefulWidget {
  @override
  _BottomNavigationBarMenuState createState() =>
      _BottomNavigationBarMenuState();
}

class _BottomNavigationBarMenuState extends State<BottomNavigationBarMenu> {
  UserModel _user;
  double _tamIconLogoMenuBottom = 27;
  int _currentIndexMenu = 0;
  bool _isProfileTattooArtist;

  final List<Widget> _classMenuOptions = [
    FeedPage(),
    NotificationListPage(),
    SchedulePage(),
    ProfileMenuPage(),
  ];

  @override
  void initState() {
    super.initState();
    print("BOTTOM NAV BAR");
    _getUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Scaffold(
          body: Container(color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP));
    } else {
      return Scaffold(
        body: Center(
          child: _classMenuOptions.elementAt(_currentIndexMenu),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset("images/pontoiconebranco.png",
                  width: _tamIconLogoMenuBottom,
                  height: _tamIconLogoMenuBottom),
              activeIcon: Image.asset("images/pontoiconelaranja.png",
                  width: _tamIconLogoMenuBottom,
                  height: _tamIconLogoMenuBottom),
              title: const Text("Feed"),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications),
              title: const Text("Notificações"),
            ),
            _getMenuAgendaOrSalvos(),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Perfil"),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndexMenu,
          selectedItemColor: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
          unselectedItemColor: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
          backgroundColor: AppPontoStyle.COLOR_THEME_BOTTOM_BAR,
          onTap: _onItemTapped,
        ),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndexMenu = index;
    });
  }

  void _getUserInformation() async {
    UserRepository repo = UserRepository();
    repo.getUser().then((user) {
      _user = user;
      if (_user.typeProfile == 1) {
        _isProfileTattooArtist = true;
      } else {
        _isProfileTattooArtist = false;
      }
      setState(() {});
    });
  }

  BottomNavigationBarItem _getMenuAgendaOrSalvos() {
    if (_isProfileTattooArtist) {
      return BottomNavigationBarItem(
        icon: Icon(Icons.insert_invitation),
        title: const Text("Agenda"),
      );
    } else {
      return BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        title: const Text("Salvos"),
      );
    }
  }
}
