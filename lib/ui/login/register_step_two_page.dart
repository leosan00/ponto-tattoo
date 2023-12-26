import 'package:flutter/material.dart';
import 'package:ponto_tattoo/bottom_navigation_bar_menu.dart';
import 'package:ponto_tattoo/models/user_model.dart';
import 'package:ponto_tattoo/repositories/user_repository.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';

class RegisterStepTwoPage extends StatefulWidget {
  final UserModel tempUser;

  RegisterStepTwoPage(this.tempUser);

  @override
  _RegisterStepTwoPageState createState() => _RegisterStepTwoPageState();
}

class _RegisterStepTwoPageState extends State<RegisterStepTwoPage> {
  UserRepository repository = UserRepository();
  int currentStep = 0;
  bool complete = false;
  final StepperType stepperType = StepperType.vertical;
  List<Step> steps = List();
  bool _isTattooArtist;
  var _nameEditingController = TextEditingController();
  var _cityEditingController = TextEditingController();
  int _typePlanSelected = 1;

  @override
  Widget build(BuildContext context) {
    steps = [
      Step(
        title: const Text('Tipo de Perfil',
            style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)),
        subtitle: Text(_getPerfilSubtitle(),
            style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
        isActive: _getItemActive(0),
        state: _getStepState(0),
        content: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_isTattooArtist != false) {
                        _isTattooArtist = false;
                        setState(() {});
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: _getBorderColor(false), width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Não sou Tatuador",
                        style: TextStyle(
                            color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 22),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_isTattooArtist != true) {
                        _isTattooArtist = true;
                        setState(() {});
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: _getBorderColor(true), width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("Sou Tatuador",
                          style: TextStyle(
                              color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Step(
        isActive: _getItemActive(1),
        state: _getStepState(1),
        title: const Text('Informações',
            style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)),
        content: Column(
          children: <Widget>[
            WidgetsGeneric.modelTextField(
                _nameEditingController, "Nome", TextInputType.text),
            WidgetsGeneric.modelTextField(
                _cityEditingController, "Cidade", TextInputType.text),
          ],
        ),
      ),
      Step(
        isActive: _getItemActive(2),
        state: _getStepState(2),
        title: const Text('Plano',
            style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)),
        content: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_typePlanSelected != 1) {
                        _typePlanSelected = 1;
                        setState(() {});
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: _getBorderColor2(1), width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text("BÁSICO",
                              style: TextStyle(
                                  color:
                                      AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                                  fontSize: 14)),
                          SizedBox(height: 10),
                          Text("FREE",
                              style: TextStyle(
                                  color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_typePlanSelected != 2) {
                        _typePlanSelected = 2;
                        setState(() {});
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: _getBorderColor2(2), width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text("MÉDIO",
                              style: TextStyle(
                                  color:
                                      AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                                  fontSize: 14)),
                          SizedBox(height: 10),
                          Text("R\$ 19,99",
                              style: TextStyle(
                                  color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_typePlanSelected != 3) {
                        _typePlanSelected = 3;
                        setState(() {});
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: _getBorderColor2(3), width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text("PREMIUM",
                              style: TextStyle(
                                  color:
                                      AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                                  fontSize: 14)),
                          SizedBox(height: 10),
                          Text("R\$ 39,99",
                              style: TextStyle(
                                  color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];

    print("currentStep:|$currentStep|");

    return Scaffold(
      body: Builder(
        builder: (builderContext) => SafeArea(
          child: Container(
            color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Cadastro",
                    style: TextStyle(
                        color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                        fontSize: 19,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Theme(
                    data: ThemeData(
                        primaryColor:
                            AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE),
                    child: Stepper(
                      steps: steps,
                      type: stepperType,
                      currentStep: currentStep,
                      onStepContinue: () {
                        String messageTemp = _next();
                        if (messageTemp != null) {
                          SnackBar snackBar = _modelSnack(messageTemp);
                          Scaffold.of(builderContext).showSnackBar(snackBar);
                        }
                      },
                      onStepTapped: (step) => _goTo(step),
                      onStepCancel: _cancel,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 52),
                        color: AppPontoStyle.COLOR_THEME_BOTTOM_BAR,
                        child: RaisedButton(
                          color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
                          textColor: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                          onPressed: () {
                            String messageTemp = _next();
                            if (messageTemp != null) {
                              SnackBar snackBar = _modelSnack(messageTemp);
                              Scaffold.of(builderContext)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Text("CADASTRAR-ME",
                              style: TextStyle(
                                  color:
                                      AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                                  //Colors.indigo,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _next() {
    if (currentStep == 0) {
      if (_isTattooArtist != null) {
        currentStep + 1 != steps.length
            ? _goTo(currentStep + 1)
            : setState(() => complete = true);
        return null;
      } else {
        return "Selecione algum perfil";
      }
    } else if (currentStep == 1) {
      if (_nameEditingController.text.trim() == "") {
        return "Informe seu nome";
      } else {
        currentStep + 1 != steps.length
            ? _goTo(currentStep + 1)
            : setState(() => complete = true);
        return null;
      }
    } else {
      //salva
      _saveUser().then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarMenu()),
        );
      });
      /*currentStep + 1 != steps.length
          ? _goTo(currentStep + 1)
          : setState(() => complete = true);*/
      return null;
    }
  }

  Future<void> _saveUser() async {
    int tempTypeProfile;
    if (_isTattooArtist) {
      tempTypeProfile = 1;
    } else {
      tempTypeProfile = 2;
    }

    try {
      await repository.deleteAllUser();
    } catch (e) {
      print("Error deletar users e:$e");
    }

    UserModel _user = UserModel(
        1,
        123,
        widget.tempUser.login,
        tempTypeProfile,
        _nameEditingController.text,
        _cityEditingController.text,
        _typePlanSelected,
        1);

    await repository.saveUser(_user);
  }

  StepState _getStepState(int index) {
    //StepState.error
    if (index == currentStep) {
      return StepState.editing;
    } else if (index < currentStep) {
      return StepState.complete;
    } else {
      return StepState.disabled;
    }
  }

  bool _getItemActive(int index) {
    if (index == currentStep) {
      return true;
    } else {
      return false;
    }
  }

  _cancel() {
    if (currentStep > 0) {
      _goTo(currentStep - 1);
    }
  }

  _goTo(int step) {
    setState(() => currentStep = step);
  }

  String _getPerfilSubtitle() {
    if (_isTattooArtist != null) {
      if (_isTattooArtist) {
        return "Artista";
      } else {
        return "Cliente";
      }
    } else {
      return "";
    }
  }

  SnackBar _modelSnack(String messageSnack) {
    return SnackBar(
      content: Text(messageSnack),
    );
  }

  Color _getBorderColor(bool internalIsTattooArtist) {
    if (_isTattooArtist == null) {
      return Color.fromRGBO(255, 255, 255, 0.2);
    } else if (_isTattooArtist && internalIsTattooArtist) {
      return AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE;
    } else if (!_isTattooArtist && !internalIsTattooArtist) {
      return AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE;
    } else {
      return Color.fromRGBO(255, 255, 255, 0.2);
    }
  }

  Color _getBorderColor2(int typePlan) {
    if (typePlan == _typePlanSelected) {
      return AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE;
    } else {
      return Color.fromRGBO(255, 255, 255, 0.2);
    }
  }
}
