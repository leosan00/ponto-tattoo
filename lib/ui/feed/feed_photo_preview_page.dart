import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/profile/tattoo_artist/profile_tattoo_artist_page.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';
import 'package:ponto_tattoo/ui/utils/widgets_list_images.dart';

class FeedPhotoPreviewPage extends StatefulWidget {
  final ImageModel image;

  FeedPhotoPreviewPage(this.image);

  @override
  _FeedPhotoPreviewPageState createState() => _FeedPhotoPreviewPageState();
}

class _FeedPhotoPreviewPageState extends State<FeedPhotoPreviewPage> {
  static const List<String> choices = <String>["Opção 1", "Opção 2", "Opção 3"];
  List<ImageModel> imagesTags = <ImageModel>[
    ImageModel(71,
        "https://i.pinimg.com/originals/e0/06/78/e006786ff6b55555063352458af26f34.png"),
    ImageModel(72,
        "https://i.pinimg.com/originals/4c/39/1a/4c391a7deb7c91ee1937f79b9e021bf8.jpg"),
    ImageModel(73,
        "http://www.flower-tattoos-designs.com/wp-content/gallery/black-rose-tattoo/thumbs/thumbs_black-rose-flower-tattoo-designs-77.jpg"),
    ImageModel(74,
        "https://www.tattooja.com.br/img/blog/tatuagem-de-raposa-t-1395968624.jpg"),
    ImageModel(75,
        "https://i.pinimg.com/originals/94/2b/eb/942beb22986aa8d2d841305184efcb05.png"),
    ImageModel(79,
        "https://s3-blog.tattoo2me.com/wp-content/uploads/2020/01/1*UsbnoTnaUwDlfBHpVHBUzw.jpeg"),
    ImageModel(76,
        "https://cdn4.menstattooideas.net/tattooimages/2017/12/awesome-tattoos-27.jpg"),
    ImageModel(77,
        "https://i.pinimg.com/originals/fd/42/94/fd4294c503b38824dab8f908b64cd19d.jpg"),
    ImageModel(78,
        "https://listamulher.com/wp-content/uploads/2020/04/tatuagens-para-homenagear-o-pai-e-a-mae-1.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: WidgetsGeneric.modelFABBackButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SafeArea(
        child: SingleChildScrollView(
          //scrollDirection: Axis.vertical,
          child: Container(
            color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
            //width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                          color: AppPontoStyle.COLOR_THEME_APP_BAR,
                          child: Center(child: _getWidgetImageItem())),
                      Container(
                        padding: EdgeInsets.all(11),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: Container()),
                            WidgetsGeneric.modelPopupMenuButton(choices,
                                (String choice) {
                              //print("escolhido: |$choice|");
                            }, true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 22), //SEPARATOR
                      _getSectionArtist(),
                      SizedBox(height: 22), //SEPARATOR
                      _getSectionImageDescriptions(),
                      SizedBox(height: 26), //SEPARATOR
                      _getSectionImagesRecommended(),
                      SizedBox(height: 8), //SEPARATOR
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSectionArtist() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        WidgetsGeneric.modelTextSectionDecoration("Artista"),
        SizedBox(height: 10), //SEPARATOR
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileTattooArtistPage()),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  //color: AppPontoStyle.COLOR_BACKGROUND_CARD_AND_MESSAGE,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  image: DecorationImage(
                      image: AssetImage("images/tattoo_artist_m.png")),
                ),
              ),
              SizedBox(width: 12), //SEPARATOR
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lucas Michel",
                    style: TextStyle(
                        color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 4), //SEPARATOR
                  Text(
                    "São Paulo, SP",
                    style: TextStyle(
                        color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getSectionImageDescriptions() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Esse traço deu um trabalho, foram longas 7 horas, mas trabalho concluído!",
            style: TextStyle(
                color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                fontWeight: FontWeight.w300),
          ),
        ),
        SizedBox(height: 14), //SEPARATOR
        Container(
          child: Text(
            "#fineline   #blackandwhite   #pontilhado   #lobo   #luar",
            style: TextStyle(
                color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                fontWeight: FontWeight.w200),
          ),
        ),
      ],
    );
  }

  Widget _getSectionImagesRecommended() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        WidgetsGeneric.modelTextSectionDecoration("Você pode gostar também"),
        SizedBox(height: 10),
        WidgetListImageTwo(context, imagesTags).getGridViewListImage(),
      ],
    );
  }

  Widget _getWidgetImageItem() {
    return Hero(
      tag: widget.image.idImageModel,
      child: Image.network(widget.image.urlImage),
    );
  }
}
