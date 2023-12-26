import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';

class NotificationListPage extends StatefulWidget {
  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  var notificacoes = _populaListaNotificacoes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 26),
              Text(
                "Notificações",
                style: TextStyle(
                    fontSize: 22,
                    color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
              ),
              SizedBox(height: 20),
              Expanded(
                child: _bodyNotificationsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyNotificationsList() {
    int countNotificationsList = 0;
    try {
      countNotificationsList = notificacoes.length;
    } catch (e) {
      print("Erro notificacoes: $e");
    }

    if (countNotificationsList > 0) {
      return ListView.builder(
          //padding: const EdgeInsets.all(0),
          itemCount: notificacoes.length,
          itemBuilder: (context, index) {
            return _getModelNotificationCard(context, index);
          });
    } else {
      return Center(
          child: Text(
        "Você ainda não possui notificações!",
        style: TextStyle(
            fontSize: 18, color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
      ));
    }
  }

  Widget _getModelNotificationCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        color: AppPontoStyle.COLOR_BACKGROUND_CARD_AND_MESSAGE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 3),
                child: _getIcon(notificacoes[index].tipo),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        notificacoes[index].title ?? "-",
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 6),
                      Text(
                        notificacoes[index].descricao ?? "-",
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 6),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          notificacoes[index].dataHorario ?? "-",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Teste()),
        );*/
      },
    );
  }

  Icon _getIcon(int type) {
    IconData icon;
    switch (type) {
      case 1:
        icon = Icons.favorite;
        break;
      case 2:
        icon = Icons.language;
        break;
      case 3:
        icon = Icons.attach_money;
        break;
      default:
        icon = Icons.drafts;
        break;
    }
    return Icon(
      icon,
      color: Colors.pink,
      size: 28,
    );
  }

  static List<Notificacao> _populaListaNotificacoes() {
    List<Notificacao> list = List<Notificacao>();

    list.add(Notificacao(
        1,
        "Pagamento",
        "Seu pagamento gerado para Renata foi confirmado!",
        "25/08/2020 15:11",
        3));
    list.add(Notificacao(2, "Seguidores", "Você tem 12 novos seguidores!",
        "21/08/2020 08:00", 2));
    list.add(Notificacao(3, "Seguidores", "Você tem 7 novos seguidores!",
        "20/08/2020 08:00", 2));
    list.add(Notificacao(4, "Boas vindas", "Seja bem vindo ao Ponto Tattoo!",
        "20/02/2020 15:37", 0));

    return list;
  }
}

class Notificacao {
  int id;
  String title;
  String descricao;
  String dataHorario;
  int tipo;

  Notificacao(this.id, this.title, this.descricao, this.dataHorario, this.tipo);

  /*Contact.fromMap(Map map) {
    id = map[idCollumn];
    name = map[nameCollumn];
    email = map[emailCollumn];
    phone = map[phoneCollumn];
    img = map[imgCollumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameCollumn: name,
      emailCollumn: email,
      phoneCollumn: phone,
      imgCollumn: img,
    };
    if (id != null) {
      map[idCollumn] = id;
    }
    return map;
  }*/

  @override
  String toString() {
    return "Contact(id: $id, descricao: $descricao, data: $dataHorario, tipo: $tipo)";
  }
}
