import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';
/*
class WidgetCustomDialogApp extends StatefulWidget {
  @override
  _WidgetCustomDialogAppState createState() => _WidgetCustomDialogAppState();
}

class _WidgetCustomDialogAppState extends State<WidgetCustomDialogApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Future<void> modelCustomDialog(
      BuildContext context, String title, Widget content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(title,
              style:
                  TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)),
          content: content,
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}*/

class WidgetsSimpleDialogApp {
  static Future<void> modelSimpleDialog(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(title,
              style:
                  TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message,
                    style: TextStyle(
                        color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> modelQuestionDialog(BuildContext context, String title,
      String message, void Function() onPressedConfirm) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(title,
              style:
                  TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message,
                    style: TextStyle(
                        color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Confirmar"),
              onPressed: onPressedConfirm,
            ),
          ],
        );
      },
    );
  }

  static Future<void> modelQuestionInputDialog(
      BuildContext context,
      String title,
      String message,
      void Function(String newName) onPressedConfirm) async {
    var tempTEC = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(title,
              style:
                  TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message,
                    style: TextStyle(
                        color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                        fontWeight: FontWeight.w300)),
                WidgetsGeneric.modelTextField(
                    tempTEC, null, TextInputType.text),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Confirmar"),
              onPressed: () => onPressedConfirm(tempTEC.text),
            ),
          ],
        );
      },
    );
  }

/*static Future<void> modelSimpleDialogList(
      BuildContext context, List<String> listOptions) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 250,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: listOptions.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Text(listOptions[index] ?? "-"),
                  );
                }),
          ),
        );
      },
    );
  }*/
}
