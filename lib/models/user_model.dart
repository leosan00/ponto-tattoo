class UserModel {
  static final String userAppTable = "TB_UserAppTable";
  static final String userIdColumn = "idUser";
  static final String userIdSystemColumn = "idSystemUser";
  static final String userLoginColumn = "login";
  static final String userTypeProfileColumn = "typeProfile";
  static final String userNameColumn = "name";
  static final String userCityColumn = "city";
  static final String userTypePlanColumn = "typePlan";
  static final String userStatusColumn = "status";

  int idUser;
  int idSystemUser;
  String login;
  String password;
  int typeProfile;
  String name;
  String city;
  int typePlan;
  int status;

  UserModel(this.idUser, this.idSystemUser, this.login, this.typeProfile,
      this.name, this.city, this.typePlan, this.status);

  UserModel.registerOne(this.login, this.password);

  //String password;
  //String cpf;
/*  String biography;
  String bDay;
  int gender;
  String urlImagePhoto;
  String urlImageCover;*/
  //String dateModified;

  UserModel.fromMap(Map map) {
    idUser = map[userIdColumn];
    idSystemUser = map[userIdSystemColumn];
    login = map[userLoginColumn];
    typeProfile = map[userTypeProfileColumn];
    name = map[userNameColumn];
    city = map[userCityColumn];
    typePlan = map[userTypePlanColumn];
    status = map[userStatusColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      userIdColumn: idUser,
      userIdSystemColumn: idSystemUser,
      userLoginColumn: login,
      userTypeProfileColumn: typeProfile,
      userNameColumn: name,
      userCityColumn: city,
      userTypePlanColumn: typePlan,
      userStatusColumn: status,
    };
    if (idUser != null) {
      map[userIdColumn] = idUser;
    }
    return map;
  }

  @override
  String toString() {
    return 'UserModel{idUser: $idUser, idSystemUser: $idSystemUser, login: $login, typeProfile: $typeProfile, name: $name, city: $city, typePlan: $typePlan, status: $status}';
  }

/*factory UserAppModel.fromJson(Map<String, dynamic> json) =>
      UserAppModel(
        json[userIdColumn],
        json[userIdMonitoryColumn].toString(),
        json[userNameColumn].toString(),
        json[idClientMonitoryColumn],
        json[languageColumn].toString(),
        json[clientColorThemeColumn].toString(),
        json[clientLogoUrlColumn].toString(),
        json[userTokenColumn].toString(),
      );

  Map<String, dynamic> toJson() =>
      {
        userNameColumn: userName,
        idClientMonitoryColumn: idClientMonitory,
        languageColumn: language,
        clientColorThemeColumn: clientColorTheme,
        clientLogoUrlColumn: clientLogoUrl,
        userTokenColumn: userToken
      };*/

}
