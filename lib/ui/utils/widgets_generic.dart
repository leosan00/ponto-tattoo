import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';

class WidgetsGeneric {
  static final DateFormat formatterDateBr = DateFormat('dd/MM/yyyy');
  static final DateFormat formatterDateHourBr =
      DateFormat('dd/MM/yyyy hh:mm:ss');

  static Widget modelExpandedWithButtonBottom(
      Widget contentBody, void Function() onPressed,
      {String titleOptional}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: contentBody,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 52),
                color: AppPontoStyle.COLOR_THEME_BOTTOM_BAR,
                child: RaisedButton(
                  color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
                  textColor: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                  onPressed: onPressed,
                  child: Text(titleOptional ?? "CONTINUAR",
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  static Widget modelRaisedButton(void Function() fun, {String titleButton}) {
    return Row(
      children: [
        Expanded(child: Container()),
        Expanded(
          flex: 2,
          child: Container(
            child: RaisedButton(
                onPressed: fun,
                color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
                child: Text(
                  titleButton ?? "CONTINUAR",
                  style: TextStyle(
                      color: Colors.indigo, fontWeight: FontWeight.bold),
                )),
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  static Widget modelOutlineButtonIcon(
      String nameActionButton, IconData icon, void Function() fun) {
    return OutlineButton(
        onPressed: fun,
        borderSide:
            BorderSide(color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE),
        child: Row(
          children: [
            Icon(icon, color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT, size: 16),
            SizedBox(width: 8),
            Text(
              nameActionButton,
              style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
            )
          ],
        ));
  }

  static Widget modelTextSectionDecoration(String titleSection) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
          width: 2,
          child: Text(""),
        ),
        Container(
          padding: EdgeInsets.only(left: 6),
          alignment: Alignment.centerLeft,
          child: Text(titleSection,
              style: TextStyle(
                  color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                  fontWeight: FontWeight.w300)),
        ),
      ],
    );
  }

  static Widget modelFABBackButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 11),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: (MediaQuery.of(context).size.width / 100) * 12,
          height: (MediaQuery.of(context).size.height / 100) * 6.2,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(50), //optional
          ),
          child: Icon(Icons.chevron_left, size: 32, color: Colors.white),
        ),
      ),
    );
  }

  static Widget modelButtonOverlaid(IconData icon, void Function() onPressed,
      {String title, double iconSize}) {
    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.4),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                icon,
                color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                size: iconSize == null ? 32 : iconSize,
              ),
              onPressed: onPressed,
            ),
          ),
          SizedBox(width: 32),
          Center(
              child: Text(title ?? "",
                  style: TextStyle(
                      color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                      fontSize: 19,
                      fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  static Widget modelPopupMenuButton(List<String> listChoices,
      void Function(String) onSelected, bool hasDecoration) {
    //bool Overlaid
    return Container(
      decoration: hasDecoration
          ? BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.4),
              borderRadius: BorderRadius.all(Radius.circular(50)))
          : BoxDecoration(),
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
        ),
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return listChoices.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ),
    );
  }

  static Widget modelTextField(TextEditingController _inputController,
      String labelText, TextInputType textInputType) {
    return TextField(
      controller: _inputController,
      autofocus: false,
      style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
      textInputAction: TextInputAction.done,
      keyboardType: textInputType,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 7),
        filled: true,
        fillColor: Colors.transparent,
        labelText: labelText,
        labelStyle: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
        enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
        border: UnderlineInputBorder(
            borderSide:
                BorderSide(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
      ),
    );
  }

  static Widget modelTextFieldMultiLine(
      TextEditingController _controller, String textLabel, String textHint) {
    return TextField(
      controller: _controller,
      autofocus: false,
      style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      maxLines: 3,
      maxLength: 500,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 7),
        filled: true,
        fillColor: Colors.transparent,
        labelText: textLabel ?? "",
        labelStyle: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
        hintText: textHint ?? "",
        hintStyle: TextStyle(
            color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
            fontWeight: FontWeight.w300),
        enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
        border: UnderlineInputBorder(
            borderSide:
                BorderSide(color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
        counterStyle:
            TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
      ),
    );
  }

  static Widget modelSelectionBox(String label, String value,
      void Function(TapDownDetails details) function,
      {IconData icon}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? "-",
          style: TextStyle(
              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT, fontSize: 16),
        ),
        SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)), //optional
          ),
          child: GestureDetector(
            onTapDown: function,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value ?? "-",
                  style: TextStyle(
                      color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                      fontSize: 15),
                ),
                SizedBox(width: 14),
                Icon(icon ?? Icons.expand_more,
                    color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static void callModalBottomSheet(
      BuildContext context, String title, List<ListTile> tiles) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        backgroundColor: Color.fromRGBO(0, 0, 0, 1),
        context: context,
        builder: (BuildContext internalContext) {
          return Container(
            child: Wrap(
              children: <Widget>[
                //SizedBox(height: 18),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal:
                          ((MediaQuery.of(context).size.width / 100) * 45)),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white60, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                Container(
                    alignment: Alignment.center,
                    child: Text(title ?? "-",
                        style: TextStyle(
                            fontSize: 15,
                            color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                            fontWeight: FontWeight.w300))),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tiles.length,
                    itemBuilder: (context, index) {
                      return tiles[index];
                    }),
              ],
            ),
          );
        });
  }
}
