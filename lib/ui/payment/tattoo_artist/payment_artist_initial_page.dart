import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ponto_tattoo/models/PaymentModel.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/schedule/schedule_page.dart';
import 'package:ponto_tattoo/ui/utils/widgets_dialog.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentArtistInitialPage extends StatefulWidget {
  @override
  _PaymentPaymentArtistInitialPageState createState() =>
      _PaymentPaymentArtistInitialPageState();
}

class _PaymentPaymentArtistInitialPageState
    extends State<PaymentArtistInitialPage> {
  final List<String> _listMethodPaymentTypes = [
    "Cartão",
    "Boleto Bancário",
    "PicPay"
  ];

  SharedPreferences prefs;
  final List<bool> _listMethodPaymentClicked = [false, false, false];
  var _valueEditingController = TextEditingController();
  var _descriptionEditingController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(Duration(days: 7));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  WidgetsGeneric.modelButtonOverlaid(Icons.close, () {
                    WidgetsSimpleDialogApp.modelQuestionDialog(
                        context,
                        "Cancelar",
                        "Deseja mesmo cancelar o cadastro de pagamento?", () {
                      print("aaaaaaaaavvv");
                      Navigator.pop(context);
                      Navigator.pop(context, null);
                    });
                  }, title: "Cadastrar Pagamento", iconSize: 25),
                  SizedBox(height: 42),
                  Text(
                    "Por onde você quer receber?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 16),
                  _getContainerMethodPayment(),
                  SizedBox(height: 52),
                  Text("Informações da Sessão",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: 18),
                  WidgetsGeneric.modelSelectionBox(
                      "Data da Sessão",
                      WidgetsGeneric.formatterDateBr
                          .format(_selectedDate)
                          .toString(), (details) {
                    _selectDate(context);
                  }, icon: Icons.today),
                  SizedBox(height: 15),
                  WidgetsGeneric.modelTextField(_valueEditingController,
                      "Valor a ser cobrado (R\$)", TextInputType.number),
                  SizedBox(height: 15),
                  WidgetsGeneric.modelTextFieldMultiLine(
                      _descriptionEditingController,
                      "Alguma descrição da arte",
                      "Escreva sobre imagem, estilo, cor, tamanho e/ou parte do corpo"),
                ],
              ),
            ),
            _validForm,
            titleOptional: "GERAR PAGAMENTO"),
      ),
    ));
  }

  Widget _getContainerMethodPayment() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: Container(
          child: Row(
            children: [
              _getButtonTypePayment(0, "images/credit-card.png"),
              SizedBox(width: 4),
              _getButtonTypePayment(1, "images/barcode.png"),
              SizedBox(width: 4),
              _getButtonTypePayment(2, "images/picpay-mini-icon.png"),
            ],
          ),
        )),
      ],
    );
  }

  Widget _getButtonTypePayment(int index, String assetImage) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_listMethodPaymentClicked[index]) {
            _listMethodPaymentClicked[index] = false;
            setState(() {});
          } else {
            _listMethodPaymentClicked[index] = true;
            setState(() {});
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppPontoStyle.COLOR_BACKGROUND_CARD_AND_MESSAGE,
            border: Border.all(color: _getBorderColor(index), width: 2),
            borderRadius: BorderRadius.circular(4), //optional
          ),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(assetImage)),
              Text(_listMethodPaymentTypes[index],
                  style: TextStyle(
                      color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBorderColor(int index) {
    if (_listMethodPaymentClicked[index]) {
      return AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE;
    } else {
      return Colors.transparent;
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _validForm() {
    if (_listMethodPaymentClicked[0] == false &&
        _listMethodPaymentClicked[1] == false &&
        _listMethodPaymentClicked[2] == false) {
      WidgetsSimpleDialogApp.modelSimpleDialog(
          context, "Informação", "Selecione alguma forma de pagamento");
    } else if (_valueEditingController.text.trim().toString() == "") {
      WidgetsSimpleDialogApp.modelSimpleDialog(
          context, "Informação", "Selecione o valor a ser cobrado");
    } else if (_descriptionEditingController.text.trim().toString() == "") {
      WidgetsSimpleDialogApp.modelSimpleDialog(
          context, "Informação", "Selecione alguma descrição");
    } else {
      WidgetsSimpleDialogApp.modelQuestionDialog(context, "Confirmação",
          "Gerar Pagamento:\nData: ${WidgetsGeneric.formatterDateBr.format(_selectedDate)} \nValor: ${_valueEditingController.text}",
          () {
        PaymentModel _payment = PaymentModel(
            123,
            "Lucas Michel",
            321,
            "Carol",
            _listMethodPaymentClicked[0],
            _listMethodPaymentClicked[1],
            _listMethodPaymentClicked[2],
            _selectedDate.toString(),
            _valueEditingController.text,
            _descriptionEditingController.text,
            false);


        Map<String, dynamic> data = {
          "id": 24312,
          "senderId": 123,
          "event":_descriptionEditingController.text,
          "date":(_selectedDate.toString())
        };

        // Firestore.instance.collection('events').getDocuments().then((snapshot) {
        //   for (DocumentSnapshot ds in snapshot.documents) {
        //     ds.reference.delete();
        //   }
        // });

        Firestore.instance.collection('events').document().setData(data);

        Navigator.pop(context);
        Navigator.pop(context, _payment);
      });
    }
  }
}
