
class AuthService{

  /*final localStorage = locator<DataService>();
  Future<bool> isAuthenticated() async {
    try {
      String bearerToken = await localStorage.getPref(
        LocalStorageName.bearerToken,
      );

      String tokenExpirationString = await localStorage.getPref(
        LocalStorageName.tokenExpiration,
      );

      DateTime tokenExpirationTime = DateTime.parse(tokenExpirationString);
      DateTime currentTime = DateTime.now();

      if (bearerToken == null || bearerToken == "") {
        print("bearerToken is empty.");
        return false;
      }

      if (tokenExpirationString == null || tokenExpirationString == "") {
        print("tokenExpiration is empty.");
        return false;
      }

      if (currentTime.compareTo(tokenExpirationTime) > -1) {
        print("tokenExpiration has expired.");
        return false;
      }
    } catch (e) {
      return false;
    }

    return true;
  } */
}