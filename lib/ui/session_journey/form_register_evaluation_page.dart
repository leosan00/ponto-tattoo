import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/utils/widgets_dialog.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';

class FormRegisterEvaluationPage extends StatefulWidget {
  @override
  _FormRegisterEvaluationPageState createState() =>
      _FormRegisterEvaluationPageState();
}

class _FormRegisterEvaluationPageState
    extends State<FormRegisterEvaluationPage> {
  var _descriptionEditingController = TextEditingController();
  List<File> _listImage = List();
  int _valueEvaluation = 0;

  @override
  void initState() {
    super.initState();
    _listImage.add(File("path"));
  }

  @override
  Widget build(BuildContext context) {
    print("build() _listImage.length:|${_listImage.length}|");
    print("build() _listImage.toString():|${_listImage.toString()}|");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
          child: WidgetsGeneric.modelExpandedWithButtonBottom(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    WidgetsGeneric.modelButtonOverlaid(
                        Icons.close, () => Navigator.pop(context),
                        title: "Avaliar", iconSize: 28),
                    SizedBox(height: 38),
                    Text(
                      "Avalie sua sessão realizada em 14/09/2020 por Lucas",
                      style: TextStyle(
                          color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 42),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dê uma nota de 0 a 5",
                          style: TextStyle(
                              color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
                        ),
                        SizedBox(height: 6),
                        _getStarsEvaluation(_valueEvaluation),
                      ],
                    ),
                    SizedBox(height: 20),
                    WidgetsGeneric.modelTextFieldMultiLine(
                        _descriptionEditingController,
                        "Descreva sobre a sessão realizada(opcional)",
                        "Descreva o que achou da sessão realizada, higiêne, cuidado com sua pele, arte final"),
                    SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _listImage.length > 1
                            ? Text(
                                "${_listImage.length - 1} fotos selecionada",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppPontoStyle
                                        .COLOR_THEME_TEXT_HIGHLIGHT,
                                    fontSize: 14),
                              )
                            : Text(
                                "Selecione uma imagem",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppPontoStyle
                                        .COLOR_THEME_TEXT_HIGHLIGHT,
                                    fontSize: 14),
                              ),
                      ],
                    ),
                    //SizedBox(height: 6),
                    SizedBox(height: 16),
                    Container(
                      height: (MediaQuery.of(context).size.height / 100) * 15,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _listImage.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Container(
                                  padding: EdgeInsets.only(right: 8),
                                  child: _getContainerAddPhoto(index));
                            } else {
                              return Container(
                                  padding: EdgeInsets.only(right: 8),
                                  child: _getContainerImage(index));
                            }
                          }),
                    ),
                  ],
                ),
              ), () {
            if (_valueEvaluation > 0) {
            } else {
              WidgetsSimpleDialogApp.modelSimpleDialog(
                  context, "Informação", "Selecione uma avaliação maior que 0");
            }
          }, titleOptional: "AVALIAR"),
        ),
      ),
    );
  }

  Widget _getContainerImage(int index) {
    return GestureDetector(
      onTap: () {
        WidgetsSimpleDialogApp.modelQuestionDialog(
            context, "Confirme", "Deseja mesmo excluir a foto?", () {
          _listImage.removeAt(index);
          Navigator.of(context).pop();
          setState(() {});
        });
      },
      child: Container(
        padding: EdgeInsets.only(right: 5),
        width: ((MediaQuery.of(context).size.width / 100) * 29),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
              image: FileImage(_listImage[index]), fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _getContainerAddPhoto(int index) {
    return GestureDetector(
      onTap: () => _showModalBottomSheetSendPhoto(context),
      child: Container(
        padding: EdgeInsets.only(right: 5),
        width: ((MediaQuery.of(context).size.width / 100) * 29),
        decoration: BoxDecoration(
          color: AppPontoStyle.COLOR_BACKGROUND_CARD_AND_MESSAGE,
          borderRadius: BorderRadius.circular(6), //optional
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Adicionar foto",
                style: TextStyle(
                    color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
            Icon(Icons.add_photo_alternate,
                color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
          ],
        ),
      ),
    );
  }

  Widget _getStarsEvaluation(int evaluation) {
    List<int> tempList = List(5);
    int tempIndex = 0;
    int tempEvaluation = evaluation;
    do {
      tempEvaluation--;
      if (tempEvaluation >= 0) {
        tempList[tempIndex] = 1;
      } else {
        tempList[tempIndex] = 0;
      }
      //print("doo tempIndex:|tempIndex| tempList[tempIndex]:|${tempList[tempIndex]}|");
      tempIndex++;
    } while (tempIndex < 5);

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
              onTap: () {
                _valueEvaluation = 1;
                setState(() {});
              },
              child: _getIconStar(tempList[0])),
          SizedBox(width: 4),
          GestureDetector(
              onTap: () {
                _valueEvaluation = 2;
                setState(() {});
              },
              child: _getIconStar(tempList[1])),
          SizedBox(width: 4),
          GestureDetector(
              onTap: () {
                _valueEvaluation = 3;
                setState(() {});
              },
              child: _getIconStar(tempList[2])),
          SizedBox(width: 4),
          GestureDetector(
              onTap: () {
                _valueEvaluation = 4;
                setState(() {});
              },
              child: _getIconStar(tempList[3])),
          SizedBox(width: 4),
          GestureDetector(
              onTap: () {
                _valueEvaluation = 5;
                setState(() {});
              },
              child: _getIconStar(tempList[4])),
          Container(
            margin: EdgeInsets.only(left: 16),
            /*decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: AppPontoStyle.COLOR_THEME_STAR))),*/
            child: Text(
              "(${evaluation.toString()})",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  color: AppPontoStyle.COLOR_THEME_STAR,
                  letterSpacing: 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIconStar(int typeIcon) {
    if (typeIcon == 1) {
      return Container(
        width: 31,
        height: 31,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/staramaralerainteira.png"),
              fit: BoxFit.cover),
        ),
      );
      /*return Icon(
        Icons.star,
        color: AppPontoStyle.COLOR_THEME_STAR,
        size: 30,
      );*/
    } else {
      return Container(
        width: 31,
        height: 31,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/starlinhaamarela.png"),
              fit: BoxFit.cover),
        ),
      );
      /*return Icon(
        Icons.star_border,
        color: AppPontoStyle.COLOR_THEME_STAR,
        size: 30,
      );*/
    }
  }

  void _showModalBottomSheetSendPhoto(BuildContext context) {
    List<ListTile> tiles = [
      ListTile(
          leading: Icon(Icons.photo_library,
              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
          title: Text("Galeria",
              style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
          onTap: () {
            _getImage(false);
            Navigator.pop(context);
          }),
      ListTile(
        leading: Icon(Icons.camera_alt,
            color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
        title: Text("Câmera",
            style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
        onTap: () {
          _getImage(true);
          Navigator.pop(context);
        },
      )
    ];
    WidgetsGeneric.callModalBottomSheet(
        context, "Selecionar imagem da ...", tiles);
  }

  Future _getImage(bool isCamera) async {
    final pickedFile = await ImagePicker()
        .getImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _listImage.add(File(pickedFile.path));
      }
    });
  }
}
