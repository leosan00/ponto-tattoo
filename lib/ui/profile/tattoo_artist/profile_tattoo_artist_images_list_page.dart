import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/utils/widgets_list_images.dart';

class ProfileTattooArtistImagesListPage extends StatefulWidget {
  final int imagesListTypesPage;

  ProfileTattooArtistImagesListPage(this.imagesListTypesPage);

  @override
  _ProfileTattooArtistImagesListPageState createState() =>
      _ProfileTattooArtistImagesListPageState();
}

class _ProfileTattooArtistImagesListPageState
    extends State<ProfileTattooArtistImagesListPage> {
  String _titleAppBar;
  String _tempQtdImages;
  List<ImageModel> _listArtistProfileImages = List();

  @override
  void initState() {
    super.initState();
    _getLabels();
    _populateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_titleAppBar),
          backgroundColor: AppPontoStyle.COLOR_THEME_APP_BAR,
        ),
        body: SafeArea(
          child: Container(
            color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 16), //SEPARATOR
                    Text(
                      _tempQtdImages,
                      style: TextStyle(
                          color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    SizedBox(height: 8), //SEPARATOR
                    Text(
                      "atualizado em 12/12/2020",
                      style: TextStyle(
                          color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 20), //SEPARATOR
                    WidgetListImageTwo(context, _listArtistProfileImages)
                        .getGridViewListImage(),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _getLabels() {
    if (widget.imagesListTypesPage == 2) {
      _titleAppBar = "Vídeos de Lucas";
      _tempQtdImages = "17 vídeos";
    } else {
      _titleAppBar = "Imagens de Lucas";
      _tempQtdImages = "17 imagens";
    }
  }

  void _populateList() {
    _listArtistProfileImages.add(ImageModel(1,
        "https://tatuagensideias.com/wp-content/uploads/2019/08/86c4fef68d5376cddda0c1b54ec0336f.jpg"));
    _listArtistProfileImages.add(ImageModel(2,
        "https://www.dicasdemulher.com.br/wp-content/uploads/2018/05/IMG-58-LUCAS-MARTINELLI.jpg"));
    _listArtistProfileImages.add(ImageModel(3,
        "https://tudoespecial.com/wp-content/uploads/2019/09/tatuagem-de-lobo-no-braco-01.jpg"));
    _listArtistProfileImages.add(ImageModel(4,
        "https://tudoela.com/wp-content/uploads/2019/03/tatuagem-de-lobo-03-810x953.jpg"));
    _listArtistProfileImages.add(ImageModel(5,
        "https://www.tattootatuagem.com.br/wp-content/uploads/2019/05/tatuagem-de-lobo-braco4-300x300.jpg"));
    _listArtistProfileImages.add(ImageModel(6,
        "https://www.izip.com.br/wp-content/uploads/2019/04/Tatuagens-de-lobo.jpg"));
    _listArtistProfileImages.add(ImageModel(7,
        "https://tattoodo-mobile-app.imgix.net/images/news_uploads/legacy/0/91403.jpg?auto=format%2Ccompress"));
  }
}
