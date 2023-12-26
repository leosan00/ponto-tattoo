import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ponto_tattoo/models/PaymentModel.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';

class PaymentConfiguration {
  PaymentConfiguration();

  Future<DocumentReference> registerPayment(PaymentModel payment) async {
    Map<String, dynamic> data = {
      "senderUid": payment.senderId,
      "senderName": payment.senderName,
      "receiverUid": payment.receiverId,
      "receiverName": payment.receiverName,
      "maCreditCard": payment.maCreditCard,
      "maBankSlip": payment.maBankSlip,
      "maPicPay": payment.maPicPay,
      "dateSession": payment.dateSession,
      "valueSession": payment.valueSession,
      "descriptionArt": payment.descriptionArt,
      "status": payment.status,
      "dateGenerate": WidgetsGeneric.formatterDateHourBr.format(DateTime.now())
    };

    DocumentReference docRef =
        await Firestore.instance.collection('payments').add(data);
    //print("collRef:|${docRef.documentID}|");
    return docRef;
  }

  void registerPaymentInNotification(PaymentModel payment,
      {DocumentReference docRef}) async {
    Map<String, dynamic> data = {
      "senderUid": payment.senderId,
      "senderName": payment.senderName,
      "receiverUid": payment.receiverId,
      "receiverName": payment.receiverName,
      "status": payment.status,
      "type": "payment",
      "dateGenerate": WidgetsGeneric.formatterDateHourBr.format(DateTime.now())
    };

    if (docRef != null) data['paymentIdRef'] = docRef;

    Firestore.instance.collection('notifications').add(data);
  }
}
