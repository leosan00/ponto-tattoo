import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ponto_tattoo/configuration/payment_configuration.dart';
import 'package:ponto_tattoo/models/PaymentModel.dart';
import 'package:ponto_tattoo/models/user_model.dart';
import 'package:ponto_tattoo/repositories/user_repository.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/payment/clients/payment_client_initial_page.dart';
import 'package:ponto_tattoo/ui/payment/tattoo_artist/payment_artist_initial_page.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';

class MessageDetailPage extends StatefulWidget {

  final nome;

  MessageDetailPage({this.nome});

  @override
  _MessageDetailPageState createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  static const List<String> choices = <String>[
    "Excluir conversa",
    "Denunciar usuário",
    "Bloquear usuário"
  ];
  bool _isArtist;
  UserModel _user;
  TextEditingController _chatTextController = TextEditingController();
  bool _hasUpdatedInput = false;
  String tempDate;
  bool hasDateTopic = false;
  bool _imageIsLoading = false;
  PaymentModel _paymentGenerated;

  @override
  void initState() {
    super.initState();
    _getUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    if (_isArtist == null) {
      return Scaffold(
        body: Container(
          color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppPontoStyle.COLOR_THEME_APP_BAR,
          title: Text(widget.nome != null ? widget.nome : "Renata Souza" ),
          actions: <Widget>[
            WidgetsGeneric.modelPopupMenuButton(
                choices, (String choice) {}, false),
          ],
        ),
        body: SafeArea(
          child: Container(
            color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('messages')
                        .orderBy('dateReceived')
                        .snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          //case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          if (snapshot.data == null) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            List<DocumentSnapshot> documents =
                                snapshot.data.documents.reversed.toList();
                            return ListView.builder(
                                itemCount: documents.length,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return _getTypeMessage(documents[index]);
                                });
                          }
                      }
                    },
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _showModalBottomSheetSendMedia(context),
                        child: Container(
                          padding: EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(Icons.add,
                              color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                              size: 24),
                        ),
                      ),
                      _imageIsLoading ? LinearProgressIndicator() : Container(),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                            controller: _chatTextController,
                            maxLines: 2,
                            autofocus: false,
                            style: TextStyle(
                                color:
                                    AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
                            textInputAction: TextInputAction.send,
                            onSubmitted: (s) {
                              if (_hasUpdatedInput &&
                                  _chatTextController.text.trim().toString() !=
                                      "") {
                                _sendMessage(text: _chatTextController.text);
                                _chatTextController.clear();
                                setState(() {});
                              }
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              // ignore: deprecated_member_use
                              hasFloatingPlaceholder: false,
                              filled: true,
                              fillColor:
                                  AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
                              enabledBorder: OutlineInputBorder(
                                //para visualização sem focus
                                borderSide: BorderSide(
                                  color: AppPontoStyle
                                      .COLOR_BACKGROUND_CARD_AND_MESSAGE,
                                ),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(26.0),
                                ),
                              ),
                              border: OutlineInputBorder(
                                //para visualização com focus
                                borderSide: BorderSide(
                                  color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                                ),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(26.0),
                                ),
                              ),
                              labelText: "Escreva algo...",
                              labelStyle: TextStyle(
                                  color:
                                      AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                            ),
                            onChanged: (text) {
                              setState(() {
                                if (_chatTextController.text.trim() == "") {
                                  _hasUpdatedInput = false;
                                } else {
                                  _hasUpdatedInput = true;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_hasUpdatedInput &&
                              _chatTextController.text.trim().toString() !=
                                  "") {
                            _sendMessage(text: _chatTextController.text);
                            _chatTextController.clear();
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: _hasUpdatedInput
                                ? AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE
                                : AppPontoStyle
                                    .COLOR_BACKGROUND_CARD_AND_MESSAGE,
                            borderRadius: BorderRadius.circular(50),
                            //border: Border.all(width: 2, color: Colors.white)
                          ),
                          child: Icon(Icons.send,
                              color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                              size: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void _sendMessage(
      {String text,
      File imgFile,
      String textPayment,
      DocumentReference docRef}) async {
    //todo
    Map<String, dynamic> data = {
      "senderUid": "123",
      "senderName": "Lucas Michel",
      "receiverUid": "321",
      "receiverName": "Carol",
      "dateReceived": WidgetsGeneric.formatterDateHourBr.format(DateTime.now())
    };

    if (imgFile != null) {
      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(imgFile);
      setState(() {
        _imageIsLoading = true;
      });
      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = url;
      _imageIsLoading = false;
    }

    if (text != null) data['text'] = text;

    if (textPayment != null) data['textPayment'] = textPayment;

    if (docRef != null) data['paymentIdRef'] = docRef;

    Firestore.instance.collection('messages').add(data);
  }

  Widget _getTypeMessage(DocumentSnapshot document) {
    if (document.data['text'] != null) {
      return _getContainerMessage(document.data['senderUid'],
          document.data['text'], document.data['dateReceived']);
    } else if (document.data['textPayment'] != null) {
      return _getContainerMessage(document.data['senderUid'],
          document.data['textPayment'], document.data['dateReceived'],
          documentPayIdReference: document.data['paymentIdRef']);
    } else if (document.data['imgUrl'] != null) {
      return Flexible(
        child: Container(
          //color: Colors.yellow,
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50), //optional
                  ),
                  child: Image.network(document.data['imgUrl'], height: 200))
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void _showModalBottomSheetSendMedia(context) {
    List<ListTile> tiles = [
      ListTile(
          leading: Icon(Icons.photo_library,
              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
          title: Text("Foto da Galeria",
              style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
          onTap: () async {
            final pickedFile =
                await ImagePicker().getImage(source: ImageSource.gallery);
            Navigator.pop(context);
            _sendMessage(imgFile: File(pickedFile.path));
          }),
      ListTile(
        leading: Icon(Icons.camera_alt,
            color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
        title: Text("Foto da Câmera",
            style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
        onTap: () async {
          final pickedFile =
              await ImagePicker().getImage(source: ImageSource.camera);
          Navigator.pop(context);
          _sendMessage(imgFile: File(pickedFile.path));
        },
      ),
      _getPersonalizedListTile(context),
    ];
    WidgetsGeneric.callModalBottomSheet(context, "Enviar...", tiles);
  }

  ListTile _getPersonalizedListTile(BuildContext context) {
    if (_isArtist) {
      return ListTile(
        leading: Icon(Icons.attach_money,
            color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
        title: Text("Gerar Pagamento",
            style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
        onTap: () => _navigateGeneratedPayment(context),
      );
    } else {
      return ListTile(
        leading:
            Icon(Icons.favorite, color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
        title: Text("Tattoo Salva",
            style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
        onTap: () {
          Navigator.pop(context);
        },
      );
    }
  }

  Widget _getContainerMessage(
      String senderUid, String message, String dateAndHour,
      {DocumentReference documentPayIdReference}) {
    bool mine;
    if (senderUid == "123") {
      mine = true;
    } else {
      mine = false;
    }

    return Container(
      padding: EdgeInsets.only(top: 6),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:
            mine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          mine ? Expanded(child: Container()) : Container(),
          Flexible(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: mine
                        ? AppPontoStyle.COLOR_THEME_BACKGROUND_APP
                        : AppPontoStyle.COLOR_BACKGROUND_CARD_AND_MESSAGE,
                    borderRadius: BorderRadius.circular(10),
                    border: mine
                        ? Border.all(
                            color:
                                AppPontoStyle.COLOR_BACKGROUND_CARD_AND_MESSAGE,
                            width: 0.7)
                        : null),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:
                      mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    _getTextMessage(message, documentPayIdReference),
                    SizedBox(height: 4),
                    Text(
                      dateAndHour ?? "-", //dateAndHour
                      style: TextStyle(
                          color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              )),
          mine ? Container() : Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _getTextMessage(
      String message, DocumentReference documentPayIdReference) {
    if (documentPayIdReference != null) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PaymentClientInitialPage(documentPayIdReference)),
          );
        },
        child: Text(
          message ?? "-",
          style: TextStyle(
              color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE, height: 1.3),
        ),
      );
    } else {
      return Text(
        message ?? "-",
        style: TextStyle(
            color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT, height: 1.3),
      );
    }
  }

  void _getUserInformation() async {
    UserRepository repo = UserRepository();
    repo.getUser().then((user) {
      _user = user;
      if (_user.typeProfile == 1) {
        _isArtist = true;
      } else {
        _isArtist = false;
      }
      setState(() {});
    });
  }

  void _navigateGeneratedPayment(BuildContext context) async {
    Navigator.pop(context);
    final PaymentModel result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentArtistInitialPage()),
    );

    if (result != null) {
      _paymentGenerated = result;
      print("_paymentGenerated:|${_paymentGenerated.toString()}|");
      try {
        PaymentConfiguration()
            .registerPayment(_paymentGenerated)
            .then((idPayment) {
          PaymentConfiguration().registerPaymentInNotification(
              _paymentGenerated,
              docRef: idPayment);
          _sendMessage(textPayment: "PAGAMENTO GERADO", docRef: idPayment);
        });
        setState(() {});
      } catch (error) {
        print("Erro ao cadastrar pagamento: |$error|");
      }
    }
  }
}
