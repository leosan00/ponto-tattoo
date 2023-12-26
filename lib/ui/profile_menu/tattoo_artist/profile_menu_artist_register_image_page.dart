import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ponto_tattoo/models/id_value_model.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/utils/page_list_model.dart';
import 'package:ponto_tattoo/ui/utils/widgets_dialog.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';

class ProfileMenuArtistRegisterImagePage extends StatefulWidget {
  final int registerPageType;

  ProfileMenuArtistRegisterImagePage(this.registerPageType);

  @override
  _ProfileMenuArtistRegisterImagePageState createState() =>
      _ProfileMenuArtistRegisterImagePageState();
}

class _ProfileMenuArtistRegisterImagePageState
    extends State<ProfileMenuArtistRegisterImagePage> {
  List<File> _listImage = List();
  var nameCollectionEditingController = TextEditingController();
  var descriptionImageEditingController = TextEditingController();
  IdValueModel valueStyle;

  @override
  void initState() {
    super.initState();
    _listImage.add(File("path"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
        child: WidgetsGeneric.modelExpandedWithButtonBottom(
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                WidgetsGeneric.modelButtonOverlaid(Icons.close, () {
                  Navigator.pop(context);
                }, title: _getTitlePage(), iconSize: 28),
                SizedBox(height: 32),
                Row(
                  children: [
                    _listImage.length > 1
                        ? Text(
                            "${_listImage.length - 1} fotos selecionada",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                                fontSize: 14),
                          )
                        : Text(
                            "Selecione uma imagem",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                                fontSize: 14),
                          ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  height: (MediaQuery.of(context).size.height / 100) * 15,
                  child: _listImage.length > 0
                      ? ListView.builder(
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
                          })
                      : Container(),
                ),
                SizedBox(height: 12),
                widget.registerPageType == 3
                    ? Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: WidgetsGeneric.modelTextField(
                            nameCollectionEditingController,
                            "Nome da coleção",
                            TextInputType.text),
                      )
                    : Container(),
                WidgetsGeneric.modelTextFieldMultiLine(
                    descriptionImageEditingController,
                    "Descrição da imagem",
                    ""),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _navigateFilter(context);
                  },
                  child: Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey.shade600,
                      child: Icon(Icons.add,
                          color: AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST),
                    ),
                    backgroundColor:
                        AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
                    label: Text(
                      valueStyle == null
                          ? "Adicionar Estilo"
                          : valueStyle.value,
                      style: TextStyle(
                          color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                    ),
                  ),
                )
              ],
            ), () {
          if (_listImage.length < 2) {
            WidgetsSimpleDialogApp.modelSimpleDialog(
                context, "Informação", "Selecione alguma imagem");
          } else if (widget.registerPageType == 3 &&
              (nameCollectionEditingController == null ||
                  nameCollectionEditingController.text.trim() == "")) {
            WidgetsSimpleDialogApp.modelSimpleDialog(
                context, "Informação", "Informe um nome para a coleção");
          } else if (descriptionImageEditingController == null ||
              descriptionImageEditingController.text.trim() == "") {
            WidgetsSimpleDialogApp.modelSimpleDialog(
                context, "Informação", "Informe alguma descrição da imagem");
          } else if (valueStyle == null) {
            WidgetsSimpleDialogApp.modelSimpleDialog(
                context, "Informação", "Informe algum estilo para a imagem");
          } else {
            print("ok");
          }
        }, titleOptional: "CADASTRAR"),
      )),
    );
  }

  void _navigateFilter(BuildContext context) async {
    final IdValueModel result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PageListModel(ListTypesModel.LIST_TYPE_STYLE)),
    );
    setState(() {
      if (result != null) {
        valueStyle = result;
      }
    });
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

  String _getTitlePage() {
    if (widget.registerPageType == 1) {
      return "Adicionar Imagem";
    } else if (widget.registerPageType == 3) {
      return "Adicionar Coleção";
    } else {
      return "Adicionar Vídeo";
    }
  }
}
