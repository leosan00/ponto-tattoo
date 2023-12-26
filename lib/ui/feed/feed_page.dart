import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/message/message_list_page.dart';
import 'package:ponto_tattoo/ui/search/search_page.dart';
import 'package:ponto_tattoo/ui/utils/widgets_list_images.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<bool> listImageTypeSelected = [true, false];
  List<ImageModel> listImagesWithTattooArtists = List();
  List<ImageModel> listImagesForInspirations = List();

  @override
  void initState() {
    super.initState();
    print("initState() isSelected: ${listImageTypeSelected.toString()}");
    _initializingListImages();
  }

  @override
  Widget build(BuildContext context) {
    print("build() isSelected: ${listImageTypeSelected.toString()}");
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //(MediaQuery.of(context).size.width) / 100) * 28
                    Expanded(child: Container()),
                    Expanded(
                      child: Container(
                        height: 72.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/pontologobranco.png")),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: FloatingActionButton(
                          heroTag: "mensagens",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MessageListPage()),
                            );
                          },
                          tooltip: "Mensagens",
                          child: Icon(Icons.message,
                              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                          backgroundColor:
                              AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
                          mini: true,
                        ),
                      ),
                    ),
                  ],
                ),
                //SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ToggleButtons(
                      onPressed: (int index) {
                        if (index == 0 && listImageTypeSelected[0] != true) {
                          setState(() {
                            listImageTypeSelected[0] = true;
                            listImageTypeSelected[1] = false;
                          });
                        } else if (index == 1 &&
                            listImageTypeSelected[1] != true) {
                          setState(() {
                            listImageTypeSelected[0] = false;
                            listImageTypeSelected[1] = true;
                          });
                        }
                      },
                      color: AppPontoStyle.COLOR_THEME_SUB_MENU_BUTTONS,
                      selectedColor: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
                      borderRadius: BorderRadius.circular(18),
                      isSelected: listImageTypeSelected,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 16.0,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  "Tatuadores",
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.lightbulb_outline,
                                  size: 16.0,
                                  color: Colors.yellow[800],
                                ),
                                SizedBox(width: 4.0),
                                Text("Inspirações",
                                    style: TextStyle(color: Colors.yellow[800]))
                              ],
                            )),
                      ],
                    ),
                    FloatingActionButton(
                      heroTag: "pesquisar",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },
                      tooltip: "Pesquisar",
                      child: Icon(Icons.search,
                          color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                      backgroundColor:
                          AppPontoStyle.COLOR_THEME_CONTAINER_CONTRAST,
                      mini: true,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                _getWidgetListImagesWithTattooArtists(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getWidgetListImagesWithTattooArtists() {
    if (listImageTypeSelected[1] == true) {
      return WidgetListImageOne(context, listImagesForInspirations)
          .getGridViewListImage();
    } else {
      return WidgetListImageOne(context, listImagesWithTattooArtists)
          .getGridViewListImage();
    }
  }

  void _initializingListImages() {
    listImagesWithTattooArtists.add(ImageModel(1,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT11H3TNWYLmlXntH5ROWbET5zlzlBhi4XCrA&usqp=CAU"));
    listImagesWithTattooArtists.add(ImageModel(2,
        "https://i.pinimg.com/564x/11/22/86/112286ca85338aac35983bdab967a077.jpg"));
    listImagesWithTattooArtists.add(ImageModel(
        3, "https://latatoueuse.com/pt/images/j12/tatuagem-relogio-61.jpg"));
    listImagesWithTattooArtists.add(ImageModel(4,
        "https://i.pinimg.com/originals/47/3c/7d/473c7d6e5ea12d92b6b9ce62aa4897c1.jpg"));
    listImagesWithTattooArtists.add(ImageModel(5,
        "https://www.prettydesigns.com/wp-content/uploads/2018/11/40-beautiful-tattoos-for-girls-latest-hottest-tattoo-designs.jpg"));
    listImagesWithTattooArtists.add(ImageModel(6,
        "https://cdn.sortra.com/wp-content/uploads/2015/03/colorful-tattoo09.jpg"));
    listImagesWithTattooArtists.add(ImageModel(7,
        "https://images.bewakoof.com/utter/content/3624/content_bicep_tattoo_2.jpg"));

    listImagesForInspirations.add(ImageModel(50,
        "https://www.tattoomenow.com/tattoo-designs/wp-content/uploads/2019/11/Small-Tattoos-for-men-forearm-10.jpg"));
    listImagesForInspirations.add(ImageModel(51,
        "https://lh6.googleusercontent.com/NfDUOp1sdyXpH_8ZOEE6xKeP8iWz-w-D03UvSG7DLN_HCrw0SeigbZbsh3HoT7SakAGganvE1MPU3nqsu3Qs7Ls7BeBKIfZ1tLpGocQI3lLl8LE1Mzl8cc-RH1THmxrHS-oHMmJE"));
    listImagesForInspirations.add(ImageModel(53,
        "https://mymodernmet.com/wp/wp-content/uploads/2017/03/mike-boyd-cubist-tattoos-13.jpg"));
    listImagesForInspirations.add(ImageModel(54,
        "https://i.pinimg.com/originals/2f/f1/3a/2ff13a19b044f1a9adf3348856e7f150.jpg"));
    listImagesForInspirations.add(ImageModel(55,
        "https://www.theblackhattattoo.com/wp-content/uploads/2018/10/Rainbow-Pride-color-Tattoo-The-Black-Hat-Tattoo-Dublin-2018.jpg"));
    listImagesForInspirations.add(ImageModel(56,
        "https://tattooton.com/wp-content/uploads/2013/12/Lower-Back-Tattoos-for-Girls.jpg"));
  }
}

/*class TattooArtist {
  int idTattooArtist;
  String name;
  String city;
  String urlProfilePhoto;
  String biography;

  //for profile
  bool hasEvaluation;
  String evaluationValue;
  String evaluationsNumber;
  bool hasCertificate;
  String certificateQuantity;
  List<String> tattooArtistStyles;
  List<String> urlPhotosHighlights; //4
  List<String> urlPhotosProfileImages ; //2
  List<String> urlPhotosProfileVideos; //2
  List<String> urlPhotosProfileCollections; //2
}

class TattooPhoto {
  int idTattooPhoto;
  String urlPhoto;
  bool hasTattooArtist; //or inspiration
  String descriptionGroupPhoto;
  List<String> stylesGroupPhoto;
}*/

/*class TattooArtistStyle {
  int idTattooArtistStyle;
  int idTattooArtist;
  int idStyle;
}

class Style {
  int idStyle;
  String name;
}*/
