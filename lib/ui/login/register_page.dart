import 'package:flutter/material.dart';
import 'package:ponto_tattoo/models/user_model.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/login/login_page.dart';
import 'package:ponto_tattoo/ui/login/register_step_two_page.dart';
import 'package:ponto_tattoo/ui/utils/widgets_dialog.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _emailEditingController = TextEditingController();
  var _passwordEditingController = TextEditingController();
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
              image: AssetImage("images/register_fundo.jpg"),
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
              SizedBox(height: (MediaQuery.of(context).size.height / 100) * 11),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CADASTRO",
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
                controller: _emailEditingController,
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
                  labelText: "E-mail",
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
                controller: _passwordEditingController,
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
              SizedBox(height: 28),
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
              SizedBox(height: 22),
              Text(
                  "Ao se cadastrar você concorda com nossos Termos e Política de Privacidade",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                    fontSize: 12,
                  )),
              SizedBox(height: 42),
              Container(
                width: (MediaQuery.of(context).size.width / 100) * 50,
                child: RaisedButton(
                  onPressed: () {
                    if (_emailEditingController.text.trim() != "") {
                      if (_passwordEditingController.text.trim() != "") {
                        UserModel user = UserModel.registerOne(
                            _emailEditingController.text.trim(),
                            _passwordEditingController.text.trim());

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterStepTwoPage(user)),
                        );
                      } else {
                        WidgetsSimpleDialogApp.modelSimpleDialog(
                            context, "Informação", "Informe uma senha");
                      }
                    } else {
                      WidgetsSimpleDialogApp.modelSimpleDialog(
                          context, "Informação", "Informe um e-mail");
                    }
                  },
                  color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
                  child: Text(
                    "Efetuar Cadastro",
                    style: TextStyle(
                      color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                      //AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
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
                  Text("Tem uma conta ?  ",
                      style: TextStyle(
                          color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text("Login",
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
