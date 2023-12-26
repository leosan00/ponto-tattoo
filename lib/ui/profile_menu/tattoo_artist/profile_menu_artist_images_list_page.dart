import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/profile_menu/tattoo_artist/profile_menu_artist_register_image_page.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';
import 'package:ponto_tattoo/ui/utils/widgets_list_images.dart';

class ProfileMenuArtistImagesListPage extends StatefulWidget {
  final int imagesListTypesPage;

  ProfileMenuArtistImagesListPage(this.imagesListTypesPage);

  @override
  _ProfileMenuArtistImagesListPageState createState() =>
      _ProfileMenuArtistImagesListPageState();
}

class _ProfileMenuArtistImagesListPageState
    extends State<ProfileMenuArtistImagesListPage> {
  String _titleAppBar;
  String _tempQtdImages;
  List<ImageModel> _listArtistProfileImages = List();

  @override
  void initState() {
    super.initState();
    _populateList();
  }

  @override
  Widget build(BuildContext context) {
    _getTextLabels();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 16), //SEPARATOR
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: Container(
                          child: Text(
                            _tempQtdImages,
                            style: TextStyle(
                                color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        )),
                        WidgetsGeneric.modelOutlineButtonIcon(
                            "Adicionar imagem", Icons.add_a_photo, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfileMenuArtistRegisterImagePage(1)),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 20), //SEPARATOR
                    WidgetListImageThree(context, _listArtistProfileImages,
                            (image) {
                      _listArtistProfileImages.remove(image);
                      Navigator.pop(context);
                      setState(() {});
                    }, (id) {})
                        .getGridViewListImage(),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _getTextLabels() {
    if (widget.imagesListTypesPage == 2) {
      _titleAppBar = "Meus Vídeos";
      _tempQtdImages = "${_listArtistProfileImages.length} vídeos";
    } else {
      _titleAppBar = "Minhas Imagens";
      _tempQtdImages = "${_listArtistProfileImages.length} imagens";
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
