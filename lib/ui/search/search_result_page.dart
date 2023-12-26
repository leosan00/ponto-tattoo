import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/utils/widgets_list_images.dart';

class SearchResultPage extends StatefulWidget {
  final String wordSearched;

  SearchResultPage(this.wordSearched);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  var _searchController = TextEditingController();
  String _tempTextSearch = "";
  bool _hasUpdatedInputAndFocus = false;
  //bool _hasResult = false;
  List<ImageModel> _listResultSearchImages = List();

  @override
  void initState() {
    super.initState();
    if (widget.wordSearched != null && widget.wordSearched != "") {
      _tempTextSearch = widget.wordSearched;
      _searchController.text = _tempTextSearch;
    }
    _populateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
          //padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                        //como esse botão de voltar é manual, pesquisar se é necessario dar um .remove() igual no android (activity)
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
                          suffixIcon: _hasUpdatedInputAndFocus
                              ? IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      _tempTextSearch = "";
                                      _hasUpdatedInputAndFocus = false;
                                    });
                                  },
                                )
                              : Icon(null),
                        ),
                        onChanged: (text) {
                          setState(() {
                            _tempTextSearch = text;
                            if (_tempTextSearch == "") {
                              _hasUpdatedInputAndFocus = false;
                            } else {
                              _hasUpdatedInputAndFocus = true;
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
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _hasUpdatedInputAndFocus
                        ? _showFeedbackModeSearch()
                        : _showImagesListForResult(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showFeedbackModeSearch() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(top: 16),
        child: Text(
          "Pesquisar por \"$_tempTextSearch\"",
          style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
        ),
      ),
      onTap: () {},
    );
  }

  /*Widget _showFeedbackNoResult() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(top: 16),
        child: Text(
          "Nenhum resultado para \"$_tempTextSearch\"", //todo mudar aqui
          style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
        ),
      ),
      onTap: () {},
    );
  }*/

  Widget _showImagesListForResult() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          //color: Colors.red,
          child: Text(
            "Resultados para $_tempTextSearch",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 20),
        WidgetListImageTwo(context, _listResultSearchImages)
            .getGridViewListImage(),
        SizedBox(height: 8),
      ],
    );
  }

  void _populateList() {
    _listResultSearchImages.add(ImageModel(1,
        "https://tatuagensideias.com/wp-content/uploads/2019/08/86c4fef68d5376cddda0c1b54ec0336f.jpg"));
    _listResultSearchImages.add(ImageModel(2,
        "https://www.dicasdemulher.com.br/wp-content/uploads/2018/05/IMG-58-LUCAS-MARTINELLI.jpg"));
    _listResultSearchImages.add(ImageModel(3,
        "https://tudoespecial.com/wp-content/uploads/2019/09/tatuagem-de-lobo-no-braco-01.jpg"));
    _listResultSearchImages.add(ImageModel(4,
        "https://tudoela.com/wp-content/uploads/2019/03/tatuagem-de-lobo-03-810x953.jpg"));
    _listResultSearchImages.add(ImageModel(5,
        "https://www.tattootatuagem.com.br/wp-content/uploads/2019/05/tatuagem-de-lobo-braco4-300x300.jpg"));
    _listResultSearchImages.add(ImageModel(6,
        "https://www.izip.com.br/wp-content/uploads/2019/04/Tatuagens-de-lobo.jpg"));
    _listResultSearchImages.add(ImageModel(7,
        "https://tattoodo-mobile-app.imgix.net/images/news_uploads/legacy/0/91403.jpg?auto=format%2Ccompress"));
  }
}
