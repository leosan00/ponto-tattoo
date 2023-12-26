import 'package:flutter/material.dart';
import 'package:ponto_tattoo/models/id_value_model.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';

class PageListModel extends StatefulWidget {
  final String type;

  PageListModel(this.type);

  @override
  _PageListModelState createState() => _PageListModelState();
}

class _PageListModelState extends State<PageListModel> {
  List<IdValueModel> _listPageTemp;
  List<IdValueModel> _listCitys = [
    IdValueModel(1, 'City 1'),
    IdValueModel(2, 'City 2'),
    IdValueModel(3, 'City 3'),
    IdValueModel(4, 'City 4'),
    IdValueModel(5, 'City 5')
  ];
  List<IdValueModel> _listStyles = [
    IdValueModel(1, 'Style 1'),
    IdValueModel(2, 'Style 2'),
    IdValueModel(3, 'Style 3'),
    IdValueModel(4, 'Style 4'),
    IdValueModel(5, 'Style 5')
  ];

  @override
  void initState() {
    super.initState();
    if (widget.type == ListTypesModel.LIST_TYPE_CITY) {
      _listPageTemp = _listCitys;
    } else if (widget.type == ListTypesModel.LIST_TYPE_STYLE) {
      _listPageTemp = _listStyles;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${widget.type}s" ?? ""),
        backgroundColor: AppPontoStyle.COLOR_THEME_APP_BAR,
      ),
      body: Container(
        color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: Text(_tempTitle(),
                  style: TextStyle(
                      color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                      fontSize: 18)),
            ),
            SizedBox(height: 6),
            Expanded(
              child: ListView.builder(
                  itemCount: _listPageTemp.length,
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors
                                        .white24)) //Border.all(color: Colors.pink), //optional
                            ),
                        child: ListTile(
                          title: Text(
                            _listPageTemp[index].value,
                            style: TextStyle(
                                color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                          ),
                          onTap: () {
                            print(
                                "clicadooo: _listPageTemp[index]:|${_listPageTemp[index]}|");
                            Navigator.pop(context, _listPageTemp[index]);
                          },
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  String _tempTitle() {
    if (widget.type == ListTypesModel.LIST_TYPE_CITY) {
      return "Selecione sua ${widget.type.toLowerCase()}";
    } else {
      return "Selecione seu ${widget.type.toLowerCase()}";
    }
  }
}

class ListTypesModel {
  // ignore: non_constant_identifier_names
  static final String LIST_TYPE_STYLE =
      "Estilo"; // ignore: non_constant_identifier_names
  // ignore: non_constant_identifier_names
  static final String LIST_TYPE_CITY =
      "Cidade"; // ignore: non_constant_identifier_names
}
