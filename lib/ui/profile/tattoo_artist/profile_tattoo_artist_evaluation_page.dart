import 'package:flutter/material.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';

class ProfileTattooArtistEvaluationPage extends StatefulWidget {
  @override
  _ProfileTattooArtistEvaluationPageState createState() =>
      _ProfileTattooArtistEvaluationPageState();
}

class _ProfileTattooArtistEvaluationPageState
    extends State<ProfileTattooArtistEvaluationPage> {
  List<String> listaPhotoEvaluation = List();

  @override
  void initState() {
    super.initState();
    listaPhotoEvaluation.add(
        "https://i1.wp.com/www.farofeiros.com.br/wp-content/uploads/2020/03/Memes-para-usar-durante-a-quarentena-Blog-Farofeiros-Tatuagem-Pikachu.jpg");
    //https://diarioprime.com.br/blogs/tatuagem-na-web/wp-content/uploads/2020/03/dollydest-300x240.jpg
    listaPhotoEvaluation.add("https://pbs.twimg.com/media/EIxxHd5W4AYiP8q.jpg");
    listaPhotoEvaluation.add(
        "https://i.kym-cdn.com/photos/images/original/001/601/336/ecd.jpg");
    listaPhotoEvaluation.add(
        "https://images3.memedroid.com/images/UPLOADED90/5adcf1de3a28f.jpeg");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppPontoStyle.COLOR_THEME_APP_BAR,
          title: Text("Avaliações de Lucas"),
        ),
        body: SafeArea(
          child: Container(
            color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 27),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Classificação média ",
                        style: TextStyle(
                            color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                            fontSize: 18,
                            fontWeight: FontWeight.w400)),
                    SizedBox(width: 8),
                    Text("4,8",
                        style: TextStyle(
                            color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
                            fontSize: 19, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 8),
                Text("2 avaliações",
                    style: TextStyle(
                        color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                        fontSize: 15,
                        fontWeight: FontWeight.w300)),
                SizedBox(height: 24),
                _getCardEvaluation("Camila Figueiredo", 5),
                SizedBox(height: 10),
                _getCardEvaluation("João Guilherme", 4),
              ],
            ),
          ),
        ));
  }

  Widget _getCardEvaluation(String nameClientArtist, double evaluation) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppPontoStyle.COLOR_BACKGROUND_CARD_AND_MESSAGE,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    nameClientArtist,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                _getStarsEvaluation(evaluation),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Text(
                "Profissional super bom! fgtf tghjg hjgyhf h jhgj dfh fgh h fgh fhy dghg",
                style: TextStyle(
                    color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                    fontSize: 16)),
          ),
          Container(
            height: (MediaQuery.of(context).size.height / 100) * 15,
            child: ListView.builder(
                //padding: const EdgeInsets.all(0),
                scrollDirection: Axis.horizontal,
                itemCount: listaPhotoEvaluation.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.only(right: 5),
                      child: _getContainerImageInEvaluation(index));
                }),
          ),
          SizedBox(height: 14),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.bottomRight,
                child: Text("realizado em 12/06/2020",
                    style: TextStyle(
                        color: AppPontoStyle.COLOR_THEME_TEXT_DEFAULT,
                        fontSize: 13,
                        fontWeight: FontWeight.w300)),
              ),
              Container(
                  padding: EdgeInsets.only(left: 6),
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.arrow_forward,
                      color: Colors.white38, size: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getStarsEvaluation(double evaluation) {
    List<int> tempList = List(5);
    int tempIndex = 0;
    double tempEvaluation = evaluation;
    do {
      tempEvaluation--;
      if (tempEvaluation >= 0) {
        tempList[tempIndex] = 1;
      } else if (tempEvaluation == -0.5) {
        tempList[tempIndex] = 2;
      } else {
        tempList[tempIndex] = 0;
      }
      //print("doo tempIndex:|tempIndex| tempList[tempIndex]:|${tempList[tempIndex]}|");
      tempIndex++;
    } while (tempIndex < 5);

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: 14, right: 5),
            child: Text(
              "(${evaluation.toInt().toString()})",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppPontoStyle.COLOR_THEME_STAR,
                  letterSpacing: 2),
            ),
          ),
          _getIconStar(tempList[0]),
          SizedBox(width: 2),
          _getIconStar(tempList[1]),
          SizedBox(width: 2),
          _getIconStar(tempList[2]),
          SizedBox(width: 2),
          _getIconStar(tempList[3]),
          SizedBox(width: 2),
          _getIconStar(tempList[4]),
        ],
      ),
    );
  }

  Widget _getIconStar(int typeIcon) {
    if (typeIcon == 0) {
      return Container(
        width: 19,
        height: 19,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/starlinhaamarela.png"),
              fit: BoxFit.cover),
        ),
      );
      /*return Icon(
        Icons.star_border,
        color: AppPontoStyle.COLOR_THEME_STAR,
        size: 19,
      );*/
    } else if (typeIcon == 1) {
      return Container(
        width: 19,
        height: 19,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/staramaralerainteira.png"),
              fit: BoxFit.cover),
        ),
      );
      /*return Icon(
        Icons.star,
        color: AppPontoStyle.COLOR_THEME_STAR,
        size: 19,
      );*/
    } else {
      return Icon(
        Icons.star_half,
        color: AppPontoStyle.COLOR_THEME_STAR,
        size: 19,
      );
    }
  }

  Widget _getContainerImageInEvaluation(int index) {
    return Container(
      width: ((MediaQuery.of(context).size.width / 100) * 29),
      decoration: BoxDecoration(
        //color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        image: DecorationImage(
            image: NetworkImage(listaPhotoEvaluation[index]),
            fit: BoxFit.cover),
      ),
    );
  }
}
