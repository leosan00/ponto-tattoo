import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/feed/feed_photo_preview_page.dart';
import 'package:ponto_tattoo/ui/utils/widget_image_unique.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';

class WidgetListImageOne {
  final BuildContext context;
  List<ImageModel> images;

  WidgetListImageOne(this.context, this.images);

  Widget getGridViewListImage() {
    return Expanded(
      child: Container(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(2),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: images.map((ImageModel image) {
            return GridTile(child: _getModelImageItem(image));
          }).toList(),
        ),
      ),
    );
  }

  Widget _getModelImageItem(ImageModel image) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeedPhotoPreviewPage(image)),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Hero(
            tag: image.idImageModel,
            child: Image.network(image.urlImage, fit: BoxFit.cover)),
      ),
    );
  }
}

class WidgetListImageTwo {
  final BuildContext context;
  List<ImageModel> images;

  WidgetListImageTwo(this.context, this.images);

  Widget getGridViewListImage() {
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(2),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: images.map((ImageModel image) {
          return GridTile(child: _getModelImageItem(image));
        }).toList(),
      ),
    );
  }

  Widget _getModelImageItem(ImageModel image) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeedPhotoPreviewPage(image)),
        );
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(image.urlImage, fit: BoxFit.cover)),
    );
  }
}

class WidgetListImageThree {
  final BuildContext context;
  void Function(ImageModel image) funDeleteImage;
  void Function(ImageModel image) funAlterDescription;
  List<ImageModel> images;

  WidgetListImageThree(
      this.context, this.images, this.funDeleteImage, this.funAlterDescription);

  Widget getGridViewListImage() {
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(2),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: images.map((ImageModel image) {
          return GridTile(
            child: _getModelImageItem(image),
            header: GestureDetector(
              onTap: () {
                print("frt43543");

                //WidgetsSimpleDialogApp.modelSimpleDialogList(context, listtemp);
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => _showModalBottomSheetGenders(context, image),
                    child: Container(
                        color: Colors.black87,
                        child: Icon(Icons.more_vert, color: Colors.white70)),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _getModelImageItem(ImageModel image) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WidgetImageUnique(image.urlImage)),
        );
      },
      child: Image.network(image.urlImage, fit: BoxFit.cover),
    );
  }

  void _showModalBottomSheetGenders(context, ImageModel image) {
    List<ListTile> tiles = [
      ListTile(
          title: Text("Excluir Imagem",
              style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
          onTap: () => funDeleteImage(image)),
      ListTile(
        title: Text("Alterar Descrição",
            style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
        onTap: () => funAlterDescription(image),
      ),
    ];
    WidgetsGeneric.callModalBottomSheet(context, "Ações", tiles);
  }
}

class ImageModel {
  final int idImageModel;
  final String urlImage;
  String imageDescription;

  ImageModel(this.idImageModel, this.urlImage, {this.imageDescription});

  @override
  String toString() {
    return 'ImageModel{idImageModel: $idImageModel, urlImage: $urlImage, imageDescription: $imageDescription}';
  }
}
