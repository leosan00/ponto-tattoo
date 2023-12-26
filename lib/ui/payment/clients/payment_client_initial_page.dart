import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/payment/clients/payment_client_bank_slip_page.dart';
import 'package:ponto_tattoo/ui/payment/clients/payment_client_card_page.dart';
import 'package:ponto_tattoo/ui/utils/widgets_dialog.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';

class PaymentClientInitialPage extends StatefulWidget {
  final DocumentReference paymentReference;

  PaymentClientInitialPage(this.paymentReference);

  @override
  _PaymentClientInitialPageState createState() =>
      _PaymentClientInitialPageState();
}

class _PaymentClientInitialPageState extends State<PaymentClientInitialPage> {
  List<String> listMethodPaymentTypes = ["Cartão", "Boleto Bancário", "PicPay"];
  int _typePaymentSelected = 99;
  DocumentSnapshot payment;

  @override
  void initState() {
    super.initState();
    _getPaymentReference();
  }

  Future<void> _getPaymentReference() async {
    DocumentReference documentRef = await Firestore.instance
        .collection('payments')
        .document(widget.paymentReference.documentID);
    documentRef.get().then((value) {
      print("xxx:|${value.toString()}|");
      print("xxx:|${value["senderName"]}|");
      payment = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (payment != null) {
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
                  WidgetsGeneric.modelButtonOverlaid(Icons.chevron_left, () {
                    Navigator.pop(context);
                  }, title: "Pagamento"),
                  SizedBox(height: 42),
                  Text(
                    "Selecione a forma de pagamento",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 16),
                  _getContainerMethodPayment(),
                  SizedBox(height: 52),
                  Text("Resumo",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: 16),
                  _getModelRowFlex("Tatuador", payment["senderName"] ?? "-"),
                  _getModelRowFlex(
                      "Data",
                      WidgetsGeneric.formatterDateBr
                              .format(DateTime.parse(payment["dateSession"])) ??
                          "-"),
                  _getModelRowFlex(
                      "Valor", "R\$ ${payment["valueSession"]},00" ?? "-"),
                  _getModelRowFlex(
                      "Descrição", payment["descriptionArt"] ?? "-"),
                ],
              ),
            ),
            () {
              if (_typePaymentSelected == 0 ||
                  _typePaymentSelected == 1 ||
                  _typePaymentSelected == 2) {
                _redirect();
              } else {
                WidgetsSimpleDialogApp.modelSimpleDialog(
                    context, "Informação", "Selecione uma forma de pagamento");
              }
            },
          ),
        ),
      ));
    } else {
      return Scaffold(
        body: Container(
          color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
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
          if (_typePaymentSelected != index) {
            setState(() {
              _typePaymentSelected = index;
              print("clicado buttonSelected:$_typePaymentSelected");
            });
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
              Text(listMethodPaymentTypes[index],
                  style: TextStyle(
                      color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBorderColor(int index) {
    if (_typePaymentSelected == index) {
      return AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE;
    } else {
      return Colors.transparent;
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
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(right: 8),
              child: Text(
                label,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value,
                style: TextStyle(color: Colors.white, fontSize: 15)),
          ),
        ],
      ),
    );
  }

  void _redirect() {
    print("call");
    if (_typePaymentSelected == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentClientCardPage()),
      );
    } else if (_typePaymentSelected == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentClientBankSlipPage()),
      );
    } else {
      print("webview");
    }
  }
}
