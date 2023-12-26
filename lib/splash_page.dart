import 'package:flutter/material.dart';
import 'package:ponto_tattoo/bottom_navigation_bar_menu.dart';
import 'package:ponto_tattoo/models/user_model.dart';
import 'package:ponto_tattoo/repositories/user_repository.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/login/login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _validUser());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: (MediaQuery.of(context).size.width / 100) * 60,
                  child: Image.asset("images/pontologobranco.png")),
            ],
          ),
          SizedBox(height: (MediaQuery.of(context).size.height / 100) * 26),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _validUser() {
    try {
      _getUser().then((value) {
        UserModel user = value;
        print("...//~//---SplashPage _validUser() value:|$value|");
        if (user != null) {
          //print("...//~//---SplashPage _validUser() user:|$user|");
          _isUserLoggedIn = true;
        }
        _redirect();
      });
    } catch (e) {
      print("...//~//---Error SplashPage _validUser() e:|$e|");
      _redirect();
    }
  }

  Future<UserModel> _getUser() async {
    UserRepository repository = UserRepository();
    return await repository.getUser();
  }

  void _redirect() {
    //print("...//~//---SplashPage _redirect() _isUserLoggedIn:|_isUserLoggedIn|");
    if (_isUserLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigationBarMenu()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
}
