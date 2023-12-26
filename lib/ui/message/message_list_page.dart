import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/message/message_detail_page.dart';

class MessageListPage extends StatefulWidget {
  @override
  _MessageListPageState createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  var listContactsMessages = _populateListContactsMessages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mensagens"),
        backgroundColor: AppPontoStyle.COLOR_THEME_APP_BAR,
      ),
      body: Container(
        color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 12),
            Expanded(
              child: _getListContactsMessages(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getListContactsMessages() {
    int countListContactsMessages = 0;

    try {
      countListContactsMessages = listContactsMessages.length;
    } catch (e) {
      print("Erro mensagens: $e");
    }

    if (countListContactsMessages > 0) {
      return ListView.builder(
          itemCount: listContactsMessages.length,
          itemBuilder: (context, index) {
            return _getModelContactsMessagesCard(context, index);
          });
    } else {
      return Center(
          child: const Text(
        "Você ainda não possui mensagens!",
        style: TextStyle(
            fontSize: 18, color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
      ));
    }
  }

  Widget _getModelContactsMessagesCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        color: AppPontoStyle.COLOR_BACKGROUND_CARD_AND_MESSAGE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Container(
            //color: Colors.purpleAccent,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.account_circle,
                    color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                    size: 39,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        //color: Colors.blueAccent,
                        child: Text(
                          listContactsMessages[index].remetente ?? "-",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        //color: Colors.blueAccent,
                        child: Text(
                          listContactsMessages[index].descricao ?? "-",
                          //"Olá gostaria de saber mais sobre seu atendimento",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Text(
                            listContactsMessages[index].dataHorario ?? "",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT)),
                      ),
                      SizedBox(
                          height: listContactsMessages[index].lida ? 22 : 12),
                      _notificacaoLida(index),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MessageDetailPage()),
        );
      },
    );
  }

  Widget _notificacaoLida(int index) {
    if (!listContactsMessages[index].lida) {
      return Icon(Icons.brightness_1, color: Colors.cyan, size: 16.0);
    } else {
      return Container();
    }
  }

  static List<Mensagem> _populateListContactsMessages() {
    List<Mensagem> list = List<Mensagem>();

    Mensagem not1 =
        Mensagem(1, "Renata Souza", "", "20/02/2020", true);
    Mensagem not2 = Mensagem(2, "Mário", "Teste 2", "20/03/2020", false);
    Mensagem not3 = Mensagem(3, "Caio", "Teste 3", "20/04/2020", true);

    list.add(not1);
    list.add(not2);
    list.add(not3);

    return list;
  }
}

class Mensagem {
  int id;
  String remetente;
  String descricao;
  String dataHorario;
  bool lida;

  Mensagem(
      this.id, this.remetente, this.descricao, this.dataHorario, this.lida);

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
    return "Contact(id: $id, remetente: $remetente, descricao: $descricao, data: $dataHorario, lida: $lida)";
  }
}
