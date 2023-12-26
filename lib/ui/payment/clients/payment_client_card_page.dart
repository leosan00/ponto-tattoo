import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/utils/widgets_dialog.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';

class PaymentClientCardPage extends StatefulWidget {
  @override
  _PaymentClientCardPageState createState() => _PaymentClientCardPageState();
}

class _PaymentClientCardPageState extends State<PaymentClientCardPage> {
  var _cardNumberEditingController = TextEditingController();
  var _expirationDateEditingController = TextEditingController();
  var _cvvEditingController = TextEditingController();
  var _nameEditingController = TextEditingController();
  var _cpfcnpjEditingController = TextEditingController();
  bool _termsUse = false;
  bool _parcel = false;
  int _quantityParcel = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
          child: WidgetsGeneric.modelExpandedWithButtonBottom(
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 13),
                  WidgetsGeneric.modelButtonOverlaid(Icons.chevron_left, () {
                    Navigator.pop(context);
                  }, title: "Cartão de Crédito/Débito"),
                  /*SizedBox(height: 14),
                  Text(
                    "Cartão de Crédito/Débito",
                    style: TextStyle(
                        color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                        fontSize: 19.3,
                        fontWeight: FontWeight.bold),
                  ),*/
                  SizedBox(height: 16),
                  Container(
                    height: 24,
                    color: Colors.transparent, //Colors.red,
                  ),
                  SizedBox(height: 38),
                  //WidgetsGeneric.modelTextField(null, "CPF", TextInputAction.next),
                  WidgetsGeneric.modelTextField(_cardNumberEditingController,
                      "Número do Cartão*", TextInputType.number),
                  SizedBox(height: 28),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: WidgetsGeneric.modelTextField(
                            _expirationDateEditingController,
                            "Data de validade*",
                            TextInputType.datetime),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: WidgetsGeneric.modelTextField(
                            _cvvEditingController,
                            "CVV*",
                            TextInputType.number),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        alignment: Alignment.bottomCenter,
                        icon: Icon(Icons.help_outline,
                            color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                        onPressed: () {
                          WidgetsSimpleDialogApp.modelSimpleDialog(
                              context,
                              "Informação",
                              "Ele é o código de segurança presente em todos os cartões de crédito.\n\nO número do CVV fica atrás do seu cartão de crédito e é composto por três ou quatro dígitos.");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 28),
                  WidgetsGeneric.modelTextField(_nameEditingController,
                      "Nome do titular*", TextInputType.name),
                  SizedBox(height: 28),
                  WidgetsGeneric.modelTextField(_cpfcnpjEditingController,
                      "CPF/CNPJ*", TextInputType.number),
                  SizedBox(height: 28),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Deseja parcelar?",
                          style: TextStyle(
                              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor:
                              AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                        ),
                        child: Checkbox(
                          value: _parcel,
                          onChanged: (value) {
                            setState(() {
                              _parcel = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  _parcel
                      ? Container(
                          padding: EdgeInsets.only(top: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Quantidade de parcelas",
                                  style: TextStyle(
                                      color: AppPontoStyle
                                          .COLOR_THEME_TEXT_DEFAULT)),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () =>
                                    _changeQuantidadeParcelamento(false),
                                child: Container(
                                    color: Colors.black38,
                                    child: Icon(Icons.remove,
                                        color: AppPontoStyle
                                            .COLOR_THEME_TEXT_DEFAULT)),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 9),
                                child: Text(_quantityParcel.toString(),
                                    style: TextStyle(
                                        color: AppPontoStyle
                                            .COLOR_THEME_TEXT_DEFAULT)),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    _changeQuantidadeParcelamento(true),
                                child: Container(
                                    color: Colors.black38,
                                    child: Icon(Icons.add,
                                        color: AppPontoStyle
                                            .COLOR_THEME_TEXT_DEFAULT)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(height: 76),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Consulte as condições de uso para cartões",
                          style: TextStyle(
                              color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)),
                      IconButton(
                        icon: Icon(Icons.help_outline,
                            color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor:
                              AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                        ),
                        child: Checkbox(
                          value: _termsUse,
                          onChanged: (value) {
                            setState(() {
                              _termsUse = value;
                            });
                          },
                        ),
                      ),
                      Text("Li e concordo com as condições de uso",
                          style: TextStyle(
                              color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)),
                    ],
                  ),
                ],
              ),
            ),
            () {
              if (_validateInputs()) {
                if (!_termsUse) {
                  WidgetsSimpleDialogApp.modelSimpleDialog(
                      context,
                      "Informação",
                      "Para continuar você deve concordar com as condições de uso");
                } else {}
              } else {
                WidgetsSimpleDialogApp.modelSimpleDialog(context, "Informação",
                    "Preencha todos os campos obrigatórios (*)");
              }
            },
          ),
        ),
      ),
    );
  }

  void _changeQuantidadeParcelamento(bool isAdd) {
    if (isAdd && _quantityParcel < 12) {
      _quantityParcel++;
    } else if (!isAdd && _quantityParcel > 0) {
      _quantityParcel--;
    }
    setState(() {});
  }

  bool _validateInputs() {
    if ((_cardNumberEditingController.text != null &&
            _cardNumberEditingController.text.trim() != "") &&
        (_expirationDateEditingController.text != null &&
            _expirationDateEditingController.text.trim() != "") &&
        (_cvvEditingController.text != null &&
            _cvvEditingController.text.trim() != "") &&
        (_nameEditingController.text != null &&
            _nameEditingController.text.trim() != "") &&
        (_cpfcnpjEditingController != null &&
            _cpfcnpjEditingController.text.trim() != "")) {
      return true;
    } else {
      return false;
    }
  }
}
