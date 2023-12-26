import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ponto_tattoo/models/id_value_model.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/profile_menu/tattoo_artist/profile_menu_artist_collection_list_page.dart';
import 'package:ponto_tattoo/ui/profile_menu/tattoo_artist/profile_menu_artist_images_list_page.dart';
import 'package:ponto_tattoo/ui/utils/page_list_model.dart';
import 'package:ponto_tattoo/ui/utils/widgets_dialog.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';

class ProfileMenuArtistProfileEditPage extends StatefulWidget {
  @override
  _ProfileMenuArtistProfileEditPageState createState() =>
      _ProfileMenuArtistProfileEditPageState();
}

class _ProfileMenuArtistProfileEditPageState
    extends State<ProfileMenuArtistProfileEditPage> {
  var _nameEditingController = TextEditingController();
  var _bioEditingController = TextEditingController();
  List<IdValueModel> listStylesArtist = List();
  final List<String> listGenders = ['Feminino', 'Masculino', 'Outro'];
  DateTime selectedDate = DateTime.now();
  bool dialVisible = true;
  IdValueModel _city;
  String _gender;
  DateTime _selectedBDayDate;

  @override
  void initState() {
    super.initState();
    _nameEditingController.text = "Lukin";
    _bioEditingController.text = "São Paulo";
    listStylesArtist.add(IdValueModel(0, "Adicionar"));
    listStylesArtist.add(IdValueModel(1, "style 1"));
    listStylesArtist.add(IdValueModel(2, "style 2"));
    listStylesArtist.add(IdValueModel(3, "style 3"));
    listStylesArtist.add(IdValueModel(4, "style 4"));
    listStylesArtist.add(IdValueModel(5, "style 5"));
    listStylesArtist.add(IdValueModel(6, "style 6"));

    /*scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Container(
          /*padding: EdgeInsets.only(
              bottom: (MediaQuery.of(context).size.height / 100) * 8),*/
          child: buildSpeedDial()),
      body: SafeArea(
        child: Container(
          color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 13),
                      WidgetsGeneric.modelButtonOverlaid(Icons.chevron_left,
                          () {
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
                                    image: AssetImage(
                                        "images/tattoo_artist_m.png")),
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
                      SizedBox(height: 20),
                      WidgetsGeneric.modelSelectionBox("Cidade",
                          _city == null ? "Selecionar Cidade" : _city.value,
                          (details) {
                        _navigateFilter(context, ListTypesModel.LIST_TYPE_CITY);
                      }),
                      SizedBox(height: 16),
                      WidgetsGeneric.modelTextFieldMultiLine(
                          _bioEditingController,
                          "Biografia",
                          "Escreva sobre você, seus gostos, seu portifólio"),
                      SizedBox(height: 16),
                      WidgetsGeneric.modelSelectionBox(
                          "Data de Nascimento",
                          _selectedBDayDate == null
                              ? "Selecione"
                              : WidgetsGeneric.formatterDateBr
                                  .format(_selectedBDayDate)
                                  .toString(), (details) {
                        _selectDate(context);
                      }, icon: Icons.today),
                      SizedBox(height: 20),
                      WidgetsGeneric.modelSelectionBox(
                          "Gênero",
                          _gender ?? "Selecione",
                          (details) => _showModalBottomSheetGenders(context)),
                      SizedBox(height: 20),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Estilos",
                                  style: TextStyle(
                                      color: AppPontoStyle
                                          .COLOR_THEME_TEXT_DEFAULT,
                                      fontSize: 16)),
                            ],
                          ),
                          Container(
                            //padding: EdgeInsets.only(bottom: 18),
                            child: Wrap(
                              spacing: 8,
                              children: List<Widget>.generate(
                                  listStylesArtist.length, (int index) {
                                return GestureDetector(
                                  onTapDown: (TapDownDetails details) {
                                    print("clicadoo:index|$index|");
                                    if (index == 0) {
                                      _navigateFilter(context,
                                          ListTypesModel.LIST_TYPE_STYLE);
                                    } else {
                                      WidgetsSimpleDialogApp.modelQuestionDialog(
                                          context,
                                          "Remover estilo",
                                          "Deseja remover o estilo ${listStylesArtist[index].value} do seu perfil ?",
                                          () {
                                        listStylesArtist.removeAt(index);
                                        Navigator.pop(context);
                                        setState(() {});
                                      });
                                    }
                                  },
                                  child: Chip(
                                    padding: EdgeInsets.all(6),
                                    avatar: index == 0
                                        ? Icon(Icons.add,
                                            color: AppPontoStyle
                                                .COLOR_THEME_TEXT_HIGHLIGHT,
                                            size: 20)
                                        : null,
                                    label: Text(
                                      listStylesArtist[index].value,
                                      style: TextStyle(
                                          color: AppPontoStyle
                                              .COLOR_THEME_TEXT_HIGHLIGHT),
                                    ),
                                    backgroundColor: AppPontoStyle
                                        .COLOR_THEME_CONTAINER_CONTRAST,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      //SizedBox(height: 13),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
                      child: Text(
                        "SALVAR",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateFilter(BuildContext context, String pageListType) async {
    final IdValueModel result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageListModel(pageListType)),
    );
    setState(() {
      if (result != null) {
        if (pageListType == ListTypesModel.LIST_TYPE_CITY) {
          _city = result;
        } else if (pageListType == ListTypesModel.LIST_TYPE_STYLE) {
          listStylesArtist.add(result);
        }
      }
    });
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
        context, "Alterar imagem de perfil", tiles);
  }

  void _showModalBottomSheetGenders(context) {
    List<ListTile> tiles = [
      ListTile(
          title: Text("Feminino",
              style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
          onTap: () {
            _gender = "Feminino";
            Navigator.pop(context);
            setState(() {});
          }),
      ListTile(
        title: Text("Masculino",
            style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
        onTap: () {
          _gender = "Masculino";
          Navigator.pop(context);
          setState(() {});
        },
      ),
      ListTile(
        title: Text("Outro",
            style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
        onTap: () {
          _gender = "Outro";
          Navigator.pop(context);
          setState(() {});
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
    //todo
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedBDayDate) {
      setState(() {
        _selectedBDayDate = picked;
      });
    }
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  Widget buildBody() {
    return ListView.builder(
      //controller: scrollController,
      itemCount: 30,
      itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
    );
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0, color: Colors.indigo),
      tooltip: "Ações",
      child: Icon(Icons.add),
      /*onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),*/
      visible: dialVisible,
      backgroundColor: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
      foregroundColor: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
      overlayColor: Colors.black,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child:
              Icon(Icons.star, color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
          backgroundColor: AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
          onTap: () => print('THIRD CHILD'),
          label: 'Meus Destaques',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
          labelBackgroundColor: AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
        ),
        SpeedDialChild(
          child: Icon(Icons.photo_library,
              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
          backgroundColor: AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
          onTap: () {
            //print('SECOND CHILD');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileMenuArtistCollectionListPage(),
              ),
            );
          },
          label: 'Minhas Coleções',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
          labelBackgroundColor: AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
        ),
        SpeedDialChild(
          child:
              Icon(Icons.image, color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
          backgroundColor: AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
          onTap: () {
            //print('FIRST CHILD');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileMenuArtistImagesListPage(1),
              ),
            );
          },
          label: 'Minhas Imagens',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
          labelBackgroundColor: AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
        ),
      ],
    );
  }

/*void showPopupMenu(Offset offset) async {
    double rectX = offset.dx;
    double rectY = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(rectX, rectY, rectX, rectY),
      items: [
        PopupMenuItem<String>(
            child: GestureDetector(
                onTap: () {
                  print("item 1");
                  Navigator.of(context);
                },
                child: const Text('Item1'))),
        PopupMenuItem<String>(
            child: GestureDetector(
                onTap: () {
                  print("item 2");
                  Navigator.of(context);
                },
                child: const Text('Item2'))),
      ],
      elevation: 8.0,
    );
  }*/
}
