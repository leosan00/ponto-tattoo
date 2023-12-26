import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/profile/tattoo_artist/profile_tattoo_artist_collection_list_page.dart';
import 'package:ponto_tattoo/ui/profile_menu/tattoo_artist/profile_menu_artist_register_image_page.dart';
import 'package:ponto_tattoo/ui/utils/widgets_dialog.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';
import 'package:ponto_tattoo/ui/utils/widgets_list_images.dart';

class ProfileMenuArtistCollectionListPage extends StatefulWidget {
  @override
  _ProfileMenuArtistCollectionListPageState createState() =>
      _ProfileMenuArtistCollectionListPageState();
}

class _ProfileMenuArtistCollectionListPageState
    extends State<ProfileMenuArtistCollectionListPage> {
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
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 24), //SEPARATOR
                  //SizedBox(height: 8), //SEPARATOR
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: Container(
                        child: Text(
                          "${artistCollectionsList.length} coleções",
                          style: TextStyle(
                              color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                      )),
                      WidgetsGeneric.modelOutlineButtonIcon(
                          "Adicionar coleção", Icons.add_to_photos, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileMenuArtistRegisterImagePage(3)),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 24), //SEPARATOR
                  Expanded(
                    child: ListView.builder(
                        //padding: const EdgeInsets.all(0),
                        itemCount: artistCollectionsList.length,
                        itemBuilder: (context, index) {
                          return _getArtistCollectionCard(context, index);
                        }),
                  ),
                ],
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
          GestureDetector(
            onTap: () {
              WidgetsSimpleDialogApp.modelQuestionInputDialog(
                  context, "Informação", "Alterar nome da coleção", (newName) {
                print("newName:$newName");
                artistCollectionsList[index].name = newName;
                Navigator.pop(context);
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                Icon(Icons.edit,
                    color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
                    size: 16),
              ],
            ),
          ),
          SizedBox(height: 4),
          WidgetListImageThree(context, tempListImages, (image) {
            /*print("image:$image");
            tempListImages.remove(image);
            print("tempListImages:${tempListImages.toString()}");*/
            //lembrar que a lista de cadas coleção é a mesma iniciada na build, teria que requisitar  page interia de novo
            Navigator.pop(context);
            //setState(() {});
          }, (id) {})
              .getGridViewListImage(),
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
