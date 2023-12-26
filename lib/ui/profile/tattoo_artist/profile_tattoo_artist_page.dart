import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/message/message_detail_page.dart';
import 'package:ponto_tattoo/ui/message/message_list_page.dart';
import 'package:ponto_tattoo/ui/profile/tattoo_artist/profile_tattoo_artist_collection_list_page.dart';
import 'package:ponto_tattoo/ui/profile/tattoo_artist/profile_tattoo_artist_evaluation_page.dart';
import 'package:ponto_tattoo/ui/profile/tattoo_artist/profile_tattoo_artist_images_list_page.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';

class ProfileTattooArtistPage extends StatefulWidget {
  @override
  _ProfileTattooArtistPageState createState() =>
      _ProfileTattooArtistPageState();
}

class _ProfileTattooArtistPageState extends State<ProfileTattooArtistPage> {
  double larguraWidth = 0;
  double alturaHeight = 0;
  List<String> listTattooArtistStyles = [
    'Old School',
    'Realism',
    'Pontilhado',
    'Aquarela',
    'Tribal'
  ];

  @override
  Widget build(BuildContext context) {
    _getMediaQueryValues(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    //container top (capa, foto e classificação) e retangulo COLOR_CONTRAST
                    //color: AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
                    width: larguraWidth * 100,
                    height: alturaHeight * 20,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://i.pinimg.com/originals/7e/d5/b3/7ed5b3cb326c9247b9f3f59b23567ce4.png"),
                            fit: BoxFit.cover)),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          //botão de voltar
                          padding: EdgeInsets.all(14),
                          child: WidgetsGeneric.modelButtonOverlaid(
                              Icons.chevron_left, () {
                            Navigator.pop(context);
                          }),
                        ),
                        Container(
                          //retangulo bottom COLOR_BACKGROUND
                          color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
                          height: alturaHeight * 5.5,
                        ),
                        Container(
                          //circulo bottom COLOR_BACKGROUND
                          height: alturaHeight * 14.4,
                          width: larguraWidth * 27,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
                          ),
                        ),
                        Padding(
                          //circulo bottom COLOR_CONTRAST
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Container(
                            height: alturaHeight * 13,
                            width: larguraWidth * 24,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppPontoStyle
                                      .COLOR_THEME_HIGHLIGHT_ORANGE,
                                  width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              image: DecorationImage(
                                  image:
                                      AssetImage("images/tattoo_artist_m.png")),
                              //color: AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
                            ),
                          ),
                        ),
                        Padding(
                          //estrela com a classificação
                          padding: EdgeInsets.only(left: larguraWidth * 30),
                          child: _getIconStar(27, "4,8", 10),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Lucas Michel",
                              style: TextStyle(
                                  color:
                                      AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "São Paulo, SP",
                              style: TextStyle(
                                  color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(height: 14), //SEPARATOR
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: 36,
                                padding: EdgeInsets.all(4),
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MessageDetailPage(nome:"Lucas Michel")),
                                    );

                                  },
                                  color: AppPontoStyle
                                      .COLOR_THEME_HIGHLIGHT_ORANGE,
                                  textColor:
                                      AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
                                  padding: EdgeInsets.all(0),
                                  child: const Text("Contatar"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 36,
                                padding: EdgeInsets.all(4),
                                child: OutlineButton(
                                  onPressed: () {},
                                  textColor: AppPontoStyle
                                      .COLOR_THEME_HIGHLIGHT_ORANGE,
                                  borderSide: BorderSide(
                                      width: 1.0,
                                      color: AppPontoStyle
                                          .COLOR_THEME_HIGHLIGHT_ORANGE),
                                  padding: EdgeInsets.all(0),
                                  child: const Text("Seguir"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14), //SEPARATOR
                        Container(
                          child: Text(
                            "Sou tatuador desde 2012, tatuar é a minha grande paixão. Trabalho no Rio e em São Paulo.",
                            style: TextStyle(
                                color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                          ),
                        ),
                        SizedBox(height: 14), //SEPARATOR
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            _getIconBadge(Icons.lens, 34, "2", 12),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: const Text(
                                  "Certificados",
                                  style: TextStyle(
                                      color: AppPontoStyle
                                          .COLOR_THEME_TEXT_HIGHLIGHT,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12), //SEPARATOR
                        _getSpotlightContent(),
                        SizedBox(height: 16), //SEPARATOR
                        _getContainerTitleLinkAndTwoImages(
                            "Imagens", "Ver tudo", true, 1),
                        SizedBox(height: 16), //SEPARATOR
                        _getContainerTitleLinkAndTwoImages(
                            "Vídeos", "Ver tudo", true, 2),
                        SizedBox(height: 16), //SEPARATOR
                        _getContainerTitleLinkAndTwoImages(
                            "Coleções", "Ver tudo", false, 3),
                        SizedBox(height: 22), //SEPARATOR
                        _getContainerTitleAndDescription(
                            "Biografia",
                            "Sou tatuador desde 2012, tatuar é a minha grande paixão. Trabalho no Rio e em São Paulo.",
                            false),
                        SizedBox(height: 22), //SEPARATOR
                        _getContainerTitleAndDescription("Estilos", "", true),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileTattooArtistEvaluationPage()),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              _getIconStar(46, "4,8", 15),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "2 avaliações",
                                      style: TextStyle(
                                          color: AppPontoStyle
                                              .COLOR_THEME_TEXT_HIGHLIGHT,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 3),
                                    Text("Ver detalhes",
                                        style: TextStyle(
                                            color: AppPontoStyle
                                                .COLOR_THEME_TEXT_DEFAULT,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6), //SEPARATOR
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getIconBadge(
      IconData icon, double iconSize, String valueText, double valueTextSize) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: iconSize,
            color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
          ),
          Text(
            valueText,
            style: TextStyle(
                color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
                fontSize: valueTextSize,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _getIconStar(double iconSize, String valueText, double valueTextSize) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/staramaralerainteira.png"),
                  fit: BoxFit.cover),
            ),
          ),
          Text(
            valueText,
            style: TextStyle(
                color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
                fontSize: valueTextSize,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _getSpotlightContent() {
    //DESTAQUE
    //List<Widget> widgetlist = List();
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _getPageContainerSpotlight(""),
        _getPageContainerSpotlight(""),
        _getPageContainerSpotlight(""),
        _getPageContainerSpotlight(""),
      ],
    );
  }

  Container _getContainerTitleLinkAndTwoImages(
      String title, String linkGalleryPage, bool hasImage, int typePage) {
    Widget contentImageOrCollection;
    if (hasImage) {
      contentImageOrCollection = Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            image: DecorationImage(
                image: NetworkImage("https://placeimg.com/500/500/any"),
                fit: BoxFit.cover)),
      );
    } else {
      contentImageOrCollection = Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          image: DecorationImage(
              image: NetworkImage("https://placeimg.com/500/500/any"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Color.fromRGBO(0, 0, 0, 0.7), BlendMode.luminosity)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "My Designs Realist",
              style: TextStyle(
                  color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12),
            Text("10 imagens",
                style: TextStyle(
                    color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                    fontWeight: FontWeight.w300)),
          ],
        ),
      );
    }

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            //container titulo e link ver tudo
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  redirectPageOnSeeAllClicked(typePage);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(linkGalleryPage,
                        style: TextStyle(
                            color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                            fontSize: 14,
                            fontWeight: FontWeight.w300)),
                    Icon(
                      Icons.chevron_right,
                      color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            //container 2 imagens ou 2 coleções
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _getPageContainerImageOrCollection(contentImageOrCollection),
              SizedBox(width: 14),
              _getPageContainerImageOrCollection(contentImageOrCollection),
            ],
          ),
        ],
      ),
    );
  }

  void redirectPageOnSeeAllClicked(int typePageClicked) {
    //print("clicado em ver tudo");
    if (typePageClicked == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileTattooArtistCollectionListPage(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProfileTattooArtistImagesListPage(typePageClicked),
        ),
      );
    }
  }

  Container _getContainerTitleAndDescription(
      String title, String description, bool hasChip) {
    var widgetDescription;

    if (hasChip) {
      widgetDescription = Container(
        padding: EdgeInsets.only(bottom: 18),
        child: Wrap(
          spacing: 8,
          children:
              List<Widget>.generate(listTattooArtistStyles.length, (int index) {
            return Chip(
              padding: EdgeInsets.all(10),
              label: Text(
                listTattooArtistStyles[index],
                style:
                    TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
              ),
              backgroundColor: AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
            );
          }),
        ),
      );
    } else {
      widgetDescription = Text(
        description,
        style: TextStyle(
            color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT, fontSize: 14),
      );
    }

    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          widgetDescription,
        ],
      ),
    );
  }

  Container _getPageContainerSpotlight(String tempTitle) {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
      ),
      child: Text(tempTitle),
    );
  }

  Expanded _getPageContainerImageOrCollection(Widget content) {
    return Expanded(
      child: Container(
        height: alturaHeight * 15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
        ),
        child: content,
      ),
    );
  }

  void _getMediaQueryValues(BuildContext context) {
    larguraWidth = MediaQuery.of(context).size.width;
    larguraWidth = larguraWidth / 100;
    alturaHeight = MediaQuery.of(context).size.height;
    alturaHeight = alturaHeight / 100;
  }
}
