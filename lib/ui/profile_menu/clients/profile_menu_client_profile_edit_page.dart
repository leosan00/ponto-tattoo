import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/utils/page_list_model.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';

class ProfileMenuClientProfileEditPage extends StatefulWidget {
  @override
  _ProfileMenuClientProfileEditPageState createState() =>
      _ProfileMenuClientProfileEditPageState();
}

class _ProfileMenuClientProfileEditPageState
    extends State<ProfileMenuClientProfileEditPage> {
  var _nameEditingController = TextEditingController();
  List<String> listStylesArtist = List();
  final List<String> listGenders = ['Feminino', 'Masculino', 'Outro'];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _nameEditingController.text = "Lukin";
    listStylesArtist.add("Adicionar");
    listStylesArtist.add("style 1");
    listStylesArtist.add("style 2");
    listStylesArtist.add("style 3");
    listStylesArtist.add("style 4");
    listStylesArtist.add("style 5");
    listStylesArtist.add("style 6");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
          //padding: EdgeInsets.symmetric(horizontal: 16),
          child: WidgetsGeneric.modelExpandedWithButtonBottom(
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 13),
                    WidgetsGeneric.modelButtonOverlaid(Icons.chevron_left, () {
                      Navigator.pop(context);
                    }, title: "Editar Perfil"),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _showModalBottomSheetProfilePhoto(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image:
                                      AssetImage("images/tattoo_artist_m.png")),
                            ),
                          ),
                          Icon(Icons.edit,
                              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                              size: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    WidgetsGeneric.modelTextField(
                        _nameEditingController, "Nome", TextInputType.name),
                    SizedBox(height: 32),
                    WidgetsGeneric.modelSelectionBox("Cidade", "São Paulo",
                        (details) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PageListModel(ListTypesModel.LIST_TYPE_CITY)),
                      );
                    }),
                    SizedBox(height: 32),
                    WidgetsGeneric.modelSelectionBox(
                        "Data de Nascimento", "Selecione", (details) {
                      _selectDate(context);
                    }, icon: Icons.today),
                    SizedBox(height: 32),
                    WidgetsGeneric.modelSelectionBox("Gênero", "Selecione",
                        (details) => _showModalBottomSheetGenders(context)),
                  ],
                ),
              ),
              () {},
              titleOptional: "SALVAR"),
        ),
      ),
    );
  }

  void _showModalBottomSheetProfilePhoto(context) {
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
        context, "Alterar imagem de perfil da ...", tiles);
  }

  void _showModalBottomSheetGenders(context) {
    List<ListTile> tiles = [
      ListTile(
          title: Text("Feminino",
              style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
          onTap: () {
            Navigator.pop(context);
          }),
      ListTile(
        title: Text("Masculino",
            style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        title: Text("Outro",
            style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
        onTap: () {
          Navigator.pop(context);
        },
      )
    ];
    WidgetsGeneric.callModalBottomSheet(
        context, "Qual gênero você se identifica?", tiles);
  }

  Future _getImage(bool isCamera) async {
    final pickedFile = await ImagePicker()
        .getImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    /*setState(() {
      if (pickedFile != null) {
        _listImage.add(File(pickedFile.path));
      }
    });*/
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
