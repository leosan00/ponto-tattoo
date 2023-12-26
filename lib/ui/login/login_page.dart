import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/login/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Color.fromRGBO(0, 0, 0, 0.4), BlendMode.luminosity),
              image: AssetImage("images/login_fundo.jpg"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width / 100) * 40,
                height: (MediaQuery.of(context).size.height / 100) * 10,
                //color: Colors.pink,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/pontologobranco.png")),
                ),
              ),
              SizedBox(height: (MediaQuery.of(context).size.height / 100) * 13),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "LOGIN",
                    style: TextStyle(
                        color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3),
                  ),
                ],
              ),
              SizedBox(height: 24),
              TextField(
                autofocus: false,
                style:
                    TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 7),
                  filled: true,
                  fillColor: Colors.transparent,
                  labelText: "Login",
                  labelStyle:
                      TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
                ),
              ),
              SizedBox(height: 18),
              TextField(
                autofocus: false,
                style:
                    TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
                textInputAction: TextInputAction.done,
                obscureText: _showPassword ? false : true,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 7),
                  filled: true,
                  fillColor: Colors.transparent,
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (_showPassword) {
                        _showPassword = false;
                      } else {
                        _showPassword = true;
                      }
                      setState(() {});
                    },
                    icon: Icon(Icons.remove_red_eye,
                        color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                  ),
                  labelText: "Senha",
                  labelStyle:
                      TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
                ),
              ),
              SizedBox(height: 32),
              Text(
                "OU",
                style: TextStyle(
                    color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 3),
              ),
              SizedBox(height: 24),
              Container(
                height: (MediaQuery.of(context).size.height / 100) * 7,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                //color: Colors.pink,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(6),
                        color: Color.fromRGBO(219, 68, 55, 0.7),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("images/logo_google.png"),
                            SizedBox(width: 6),
                            Text("Google",
                                style: TextStyle(
                                    color: AppPontoStyle
                                        .COLOR_THEME_TEXT_HIGHLIGHT,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(6),
                        color: Color.fromRGBO(66, 103, 178, 0.7),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("images/logo_facebook.png"),
                            SizedBox(width: 6),
                            Text("Facebook",
                                style: TextStyle(
                                    color: AppPontoStyle
                                        .COLOR_THEME_TEXT_HIGHLIGHT,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 42),
              Container(
                width: (MediaQuery.of(context).size.width / 100) * 50,
                child: RaisedButton(
                  onPressed: () {},
                  color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
                  child: Text(
                    "Efetuar Login",
                    style: TextStyle(
                      color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 42),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Esqueceu sua senha ?  ",
                      style: TextStyle(
                          color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
                  Text("Recuperar Senha",
                      style: TextStyle(
                          color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 14),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Não tem uma conta ?  ",
                      style: TextStyle(
                          color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text("Desejo me Cadastrar",
                        style: TextStyle(
                            color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
