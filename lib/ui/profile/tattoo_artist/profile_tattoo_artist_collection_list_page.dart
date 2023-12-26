import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/utils/widgets_list_images.dart';

class ProfileTattooArtistCollectionListPage extends StatefulWidget {
  @override
  _ProfileTattooArtistCollectionListPageState createState() =>
      _ProfileTattooArtistCollectionListPageState();
}

class _ProfileTattooArtistCollectionListPageState
    extends State<ProfileTattooArtistCollectionListPage> {
  List<ArtistCollections> artistCollectionsList =
      _populateArtistCollectionsList();
  List<ImageCollectionModel> artistImagesCollectionsList =
      _populateArtistImagesCollectionsList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Coleções de Lucas"),
          backgroundColor: AppPontoStyle.COLOR_THEME_APP_BAR,
        ),
        body: SafeArea(
          child: Container(
            color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(//antigo sem
              scrollDirection: Axis.vertical, //antigo sem
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 24), //SEPARATOR
                    Text(
                      "3 coleções",
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
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 24), //SEPARATOR
                    Container(
                      //antigo -> Expanded()
                      child: ListView.builder(
                          shrinkWrap: true,
                          //antigo sem
                          physics: const NeverScrollableScrollPhysics(),
                          //antigo sem
                          itemCount: artistCollectionsList.length,
                          itemBuilder: (context, index) {
                            return _getArtistCollectionCard(context, index);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _getArtistCollectionCard(BuildContext context, int index) {
    List<ImageModel> tempListImages = List();
    for (int i = 0; i < artistImagesCollectionsList.length; i++) {
      if (artistImagesCollectionsList[i].idCollectionModel ==
          artistCollectionsList[index].idCollection) {
        tempListImages.add(ImageModel(
            artistImagesCollectionsList[i].idImageCollectionModel,
            artistImagesCollectionsList[i].urlImageCollectionModel));
      }
    }

    if (tempListImages.length > 0) {
      return Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
                          width: 0.8)),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                  artistCollectionsList[index].name,
                  style: TextStyle(
                      color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
                          width: 0.8)),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          WidgetListImageTwo(context, tempListImages).getGridViewListImage(),
          SizedBox(height: 15),
        ],
      ));
    } else {
      return Container(
          child: Text(
        "Nenhuma coleção",
        style: TextStyle(
            fontSize: 18, color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
      ));
    }
  }

  static List<ArtistCollections> _populateArtistCollectionsList() {
    List<ArtistCollections> tempList = List<ArtistCollections>();

    tempList.add(ArtistCollections(1, "Fine Line", 3, "www"));
    tempList.add(ArtistCollections(2, "Old School", 5, "www"));
    tempList.add(ArtistCollections(3, "Pontilhado", 2, "www"));

    return tempList;
  }

  static List<ImageCollectionModel> _populateArtistImagesCollectionsList() {
    List<ImageCollectionModel> tempList = List<ImageCollectionModel>();

    tempList.add(ImageCollectionModel(1, 1,
        "https://s2.glbimg.com/2XWDrsUNUWY5AO7WM27018e4Tnc=/940x523/e.glbimg.com/og/ed/f/original/2019/04/11/anubistattoorj.jpg"));
    tempList.add(ImageCollectionModel(
        2, 1, "https://img.ibxk.com.br/2019/05/03/03195231658170.jpg?w=1040"));
    tempList.add(ImageCollectionModel(
        3, 1, "https://img.ibxk.com.br/2019/05/03/03192939833167.jpg?w=1040"));
    tempList.add(ImageCollectionModel(3, 2,
        "https://i.insider.com/5ec6a5772618b94ebe726e95?width=1100&format=jpeg&auto=webp"));
    tempList.add(ImageCollectionModel(3, 2,
        "https://www.hypeness.com.br/wp-content/uploads/2018/12/367lyfzcwi221-1.jpg"));
    tempList.add(ImageCollectionModel(3, 2,
        "https://s3-blog.tattoo2me.com/wp-content/uploads/2020/01/1%2A85Tduhqc7XQCmB1CU3kEqw.jpeg"));
    tempList.add(ImageCollectionModel(3, 2,
        "https://areademulher.r7.com/wp-content/uploads/2019/08/de-80-fotos-de-tatuagens-de-rosas-para-voce-se-inspirar-83.jpg"));
    tempList.add(ImageCollectionModel(3, 2,
        "https://www.tattooja.com.br/img/blog/tattoo-lsd-veja-a-viagem-por-tras-dessas-tatuagens-t-10320734.jpg"));
    tempList.add(ImageCollectionModel(3, 3,
        "https://i.pinimg.com/originals/f0/19/5b/f0195bb2354821df24d20eb3aa46b569.jpg"));
    tempList.add(ImageCollectionModel(
        3, 3, "https://img.ibxk.com.br/2019/05/03/03195231658170.jpg?w=1040"));

    return tempList;
  }
}

class ArtistCollections {
  int idCollection;
  String name;
  int countImages;
  String urlImage;

  ArtistCollections(
      this.idCollection, this.name, this.countImages, this.urlImage);
}

class ImageCollectionModel {
  final int idImageCollectionModel;
  final int idCollectionModel;
  final String urlImageCollectionModel;
  String imageDescription;

  ImageCollectionModel(this.idImageCollectionModel, this.idCollectionModel,
      this.urlImageCollectionModel,
      {this.imageDescription});

  @override
  String toString() {
    return 'ImageCollectionModel{idImageCollectionModel: $idImageCollectionModel, idCollectionModel: $idCollectionModel, urlImageCollectionModel: $urlImageCollectionModel, imageDescription: $imageDescription}';
  }
}
