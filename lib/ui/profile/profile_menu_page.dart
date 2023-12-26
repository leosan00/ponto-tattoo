import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/profile_menu/clients/profile_menu_client_profile_edit_page.dart';
import 'package:ponto_tattoo/ui/profile_menu/tattoo_artist/profile_menu_artist_profile_edit_page.dart';
import 'package:ponto_tattoo/ui/utils/widgets_generic.dart';

class ProfileMenuPage extends StatefulWidget {
  @override
  _ProfileMenuPageState createState() => _ProfileMenuPageState();
}

class _ProfileMenuPageState extends State<ProfileMenuPage> {
  bool _isTattooArtist = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 32),
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("images/tattoo_artist_m.png")),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Lucas Michel",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          "São Paulo, SP",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                        ),
                      ),
                      SizedBox(height: 26),
                      WidgetsGeneric.modelTextSectionDecoration("Estatísticas"),
                      SizedBox(height: 10),
                      _getModelTwoColumns(
                          "14 fotos postadas", "1 vídeo postado"),
                      _getModelTwoColumns("127 seguidores", "8 seguindo"),
                      _getModelTwoColumns("3 avaliações", "1 certificado"),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: AppPontoStyle.COLOR_THEME_SUB_MENU_BUTTONS,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Divider(color: Colors.transparent),
                  _getButtonProfileOption("Editar perfil", Icons.person_add,
                      onTapMenu: () {
                    if (_isTattooArtist) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileMenuArtistProfileEditPage()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileMenuClientProfileEditPage()),
                      );
                    }
                  }),
                  //Divider(color: Colors.blueGrey),
                  //_getButtonProfileOption("Minha Agenda", Icons.date_range),
                  Divider(color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP),
                  _getButtonProfileOption(
                      "Configurações de conta", Icons.account_box),
                  Divider(color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP),
                  _getButtonProfileOption("Configurações", Icons.settings),
                  Divider(color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP),
                  _getButtonProfileOption("Obter Ajuda", Icons.help),
                  Divider(color: Colors.transparent),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getButtonProfileOption(String nameMenuOption, IconData iconMenuOption,
      {void Function() onTapMenu}) {
    return GestureDetector(
      onTap: onTapMenu,
      child: Container(
        height: ((MediaQuery.of(context).size.height) / 100) * 5.4,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(iconMenuOption,
                  color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
            ),
            Expanded(
              child: Text(
                nameMenuOption,
                style: TextStyle(
                    fontSize: 17,
                    color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.chevron_right,
                color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
          ],
        ),
      ),
    );
  }

  Widget _getModelTwoColumns(textColumn1, textColumn2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              textColumn1 ?? "-",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
            ),
          ),
          Expanded(
            child: Text(
              textColumn2 ?? "-",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
            ),
          ),
        ],
      ),
    );
  }
}
