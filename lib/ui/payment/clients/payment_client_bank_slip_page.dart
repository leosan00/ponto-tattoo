import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/utils/widgets_dialog.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';

class PaymentClientBankSlipPage extends StatefulWidget {
  @override
  _PaymentClientBankSlipPageState createState() =>
      _PaymentClientBankSlipPageState();
}

class _PaymentClientBankSlipPageState extends State<PaymentClientBankSlipPage> {
  var _cpfEditingController = TextEditingController();
  var _emailEditingController = TextEditingController();
  bool feedbackMode = false;
  bool _resumeExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
          child: _getBodyBankSlipPage(),
        ),
      ),
    );
  }

  Widget _getBodyBankSlipPage() {
    if (feedbackMode) {
      return WidgetsGeneric.modelExpandedWithButtonBottom(
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Icon(Icons.check_circle_outline, color: Colors.green, size: 62),
              SizedBox(height: 3),
              Text(
                "Concluído!",
                style: TextStyle(
                    color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                    fontSize: 19.3,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              Text(
                "Assim que o pagamento for confirmado enviaremos mais informações por e-mail.",
                style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
              ),
              /*SizedBox(height: 16),
              Text(
                "Você e o tatuador devem receber uma notificação pelo aplicativo.",
                style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
              ),
              SizedBox(height: 38),
              ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.all(0),
                expansionCallback: (int index, bool isExpanded) {
                  if (_resumeExpanded) {
                    _resumeExpanded = false;
                    setState(() {});
                  } else {
                    _resumeExpanded = true;
                    setState(() {});
                  }
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                        color: AppPontoStyle.COLOR_THEME_APP_BAR,
                        child: ListTile(
                          title: Text('Resumo',
                              style: TextStyle(
                                  color: AppPontoStyle
                                      .COLOR_THEME_TEXT_HIGHLIGHT)),
                        ),
                      );
                    },
                    body: Container(
                      color: AppPontoStyle.COLOR_THEME_APP_BAR,
                      child: Column(
                        children: [
                          _getModelRowFlex("Pedido", "3kRdYPlkq37svfBvb3pDf2"),
                          _getModelRowFlex("Vencimento", "03/06/2020"),
                          _getModelRowFlex("Valor", "RS 300,00"),
                        ],
                      ),
                    ),
                    isExpanded: _resumeExpanded,
                  ),
                ],
              ),*/
              SizedBox(height: 38),
              Text(
                "Código de barras",
                style: TextStyle(
                    color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 6),
              Container(
                color: Colors.blueGrey,
                height: 52,
              ),
              SizedBox(height: 26),
              Text(
                "Linha digitável",
                style: TextStyle(
                    color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 6),
              Text(
                "1234567890 12345678901 12345678901 1 12340000005678",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
              ),
              SizedBox(height: 8),
              Text(
                "Copiar o código",
                style: TextStyle(color: Colors.blueAccent),
              ),
              SizedBox(height: 26),
              RaisedButton(
                color: AppPontoStyle.COLOR_BACKGROUND_CARD_AND_MESSAGE,
                textColor: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                onPressed: () {},
                child: Text("Visualizar Boleto"),
              ),
            ],
          ),
        ),
        () {},
        titleOptional: "CONCLUIR",
      );
    } else {
      return WidgetsGeneric.modelExpandedWithButtonBottom(
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 13),
            WidgetsGeneric.modelButtonOverlaid(Icons.chevron_left, () {
              Navigator.pop(context);
            }),
            SizedBox(height: 14),
            Text(
              "Boleto Bancário",
              style: TextStyle(
                  color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                  fontSize: 19.3,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 38),
            WidgetsGeneric.modelTextField(
                _cpfEditingController, "CPF*", TextInputType.number),
            SizedBox(height: 28),
            WidgetsGeneric.modelTextField(_emailEditingController,
                "Será enviado para o e-mail*", TextInputType.emailAddress),
          ],
        ),
        () {
          if ((_cpfEditingController.text != null &&
                  _cpfEditingController.text.trim() != "") &&
              (_emailEditingController != null &&
                  _emailEditingController.text.trim() != "")) {
            setState(() {
              feedbackMode = true;
            });
          } else {
            WidgetsSimpleDialogApp.modelSimpleDialog(context, "Informação",
                "Preencha todos os campos obrigatórios (*)");
          }
        },
      );
    }
  }

  Widget _getModelRowFlex(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 8),
              child: Text(
                label,
                style: TextStyle(
                    color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(value,
                style: TextStyle(
                    color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                    fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
