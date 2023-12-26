import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/search/search_result_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchController = TextEditingController();
  String _tempTextSearch = "";
  bool _hasUpdatedInput = false;
  var _listSelectedSuggestionOption = [true, false, false];
  List<String> _listActive = List<String>();
  final List<String> listFamousTattoos = <String>[
    'Lobo',
    'Dragão',
    'Tigre',
    'Asas',
    'Estrela',
    'Palhaço',
    'Mandala Tribal',
    'Leão',
    'Carpa',
    'Infinity',
    'Flor',
    'Indigena',
    'Nota musical',
    'Fada'
  ];
  final List<String> listTattoosStyles = <String>[
    'Fine Line',
    'Old School',
    'Pontilhado',
    'Preto e Cinza',
    'Trabalho em Escuro',
    'Geometrico',
    'Horror',
    'Letras',
    'Japonês',
    'Neo Tradicional',
    'Ornamental',
    'Realismo',
    'Tribal',
    'Aquarela',
    'Surrealismo'
  ];
  final List<String> listCity = <String>[
    'São Paulo, SP',
    'Rio de Janeiro, RJ',
    'Florianópolis, SC',
    'Búzios, RJ',
    'Salvador, BA',
    'Fortaleza, CE'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            //container geral para colocar a cor do background
            color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
            child: Column(
              //container para todos os conteudos
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                          size: 34,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      child: Container(
                        //container para o text field de pesquisar
                        height:
                            ((MediaQuery.of(context).size.height) / 100) * 8.5,
                        padding: EdgeInsets.only(top: 8, bottom: 8, right: 16),
                        child: TextField(
                          controller: _searchController,
                          autofocus: false,
                          style: TextStyle(
                              color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            _redirectForResultPage(value);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 7),
                            fillColor:
                                AppPontoStyle.COLOR_BACKGROUND_CARD_AND_MESSAGE,
                            enabledBorder: OutlineInputBorder(
                              //para visualização sem focus
                              borderSide: BorderSide(
                                color: AppPontoStyle
                                    .COLOR_BACKGROUND_CARD_AND_MESSAGE,
                              ),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(12.0),
                              ),
                            ),
                            border: OutlineInputBorder(
                              //para visualização com focus
                              borderSide: BorderSide(
                                color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                              ),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(12.0),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                            ),
                            labelText: "Pesquisar",
                            labelStyle: TextStyle(
                                color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                            suffixIcon: _hasUpdatedInput
                                ? IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      _searchController.clear();
                                      setState(() {
                                        _tempTextSearch = "";
                                        _hasUpdatedInput = false;
                                      });
                                    },
                                  )
                                : Icon(null),
                          ),
                          onChanged: (text) {
                            setState(() {
                              _tempTextSearch = text;
                              if (_tempTextSearch == "") {
                                _hasUpdatedInput = false;
                              } else {
                                _hasUpdatedInput = true;
                              }
                            });
                            //print("_inputAlterado: $_inputAlterado");
                            //print("_tempTextoPesquisa: $_tempTextoPesquisa");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _hasUpdatedInput
                        ? _showFeedbackForSearch()
                        : _showSuggestionListOptions(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _showFeedbackForSearch() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(top: 16),
        child: Text(
          "Pesquisar por \"$_tempTextSearch\"",
          style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
        ),
      ),
      onTap: () {
        _redirectForResultPage(_tempTextSearch);
      },
    );
  }

  Widget _showSuggestionListOptions() {
    return Column(
      //container de sugestão, deve ser hide quando tiver algo no input
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          //container dos ToggleButtons com 3 opções (cada uma em um container)
          height: 45,
          child: ToggleButtons(
            //fillColor: Colors.amberAccent, //cor bg selecionado
            children: <Widget>[
              _getModelSuggestionButtons("ESTILOS", 0),
              _getModelSuggestionButtons("TATUAGENS", 1),
              _getModelSuggestionButtons("CIDADES", 2),
            ],
            onPressed: (int index) {
              setState(() {
                for (int bsIndex = 0;
                    bsIndex < _listSelectedSuggestionOption.length;
                    bsIndex++) {
                  if (bsIndex == index) {
                    _listSelectedSuggestionOption[bsIndex] = true;
                  } else {
                    _listSelectedSuggestionOption[bsIndex] = false;
                  }
                }
              });
            },
            color: AppPontoStyle.COLOR_THEME_SUB_MENU_BUTTONS,
            selectedColor: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
            borderRadius: BorderRadius.circular(20),
            isSelected: _listSelectedSuggestionOption,
          ),
        ),
        SizedBox(height: 22),
        Expanded(
          child: Container(
            //container para o titulo da(s) sugestões e lista
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //container para o titulo da(s) sugestões
                _getSuggestionListHeader(),
                SizedBox(height: 6),
                Expanded(
                  child: Container(
                    //container para a lista
                    child: _getListSuggestionBody(),
                  ),
                ),
              ],
            ),
          ),
        ),
        /**/
      ],
    );
  }

  Widget _getSuggestionListHeader() {
    String titleSuggestionListHeader = "";
    Widget widgetLocalization = Container();

    if (_listSelectedSuggestionOption[0]) {
      titleSuggestionListHeader = "Estilos de Tattoos";
    } else if (_listSelectedSuggestionOption[1]) {
      titleSuggestionListHeader = "Tatuagens Famosas";
    } else {
      titleSuggestionListHeader = "Principais Cidades";
      widgetLocalization = Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              //print("nas proximidades clicado");
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.map, color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                Text(
                  "  Artistas próximos a você",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(height: 22),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widgetLocalization,
        Text(
          titleSuggestionListHeader,
          style: TextStyle(
              fontSize: 16,
              color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _getListSuggestionBody() {
    _listActive = null;
    if (_listSelectedSuggestionOption[0]) {
      _listActive = listTattoosStyles;
    } else if (_listSelectedSuggestionOption[1]) {
      _listActive = listFamousTattoos;
    } else {
      _listActive = listCity;
    }

    return ListView.builder(
        itemCount: _listActive.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print("_getListSuggestionBody() index:" + _listActive[index]);
              _redirectForResultPage(_listActive[index]);
            },
            child: Container(
              height: 28,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _listActive[index],
                  style:
                      TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                ),
              ),
            ),
          );
        });
  }

  Widget _getModelSuggestionButtons(String title, int index) {
    return Container(
        width: ((MediaQuery.of(context).size.width) / 100) * 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(color: _updateColorSuggestionButtons(index)),
            )
          ],
        ));
  }

  Color _updateColorSuggestionButtons(int index) {
    return _listSelectedSuggestionOption[index]
        ? AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE
        : AppPontoStyle.COLOR_THEME_TEXT_DEFAULT;
  }

  void _redirectForResultPage(String word) {
    if (word.trim() != null && word.trim() != "") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchResultPage(word.trim())),
      );
    }
  }
}
