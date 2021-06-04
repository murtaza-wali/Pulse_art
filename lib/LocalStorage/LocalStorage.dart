import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  userIdSet(final apiToken) async {
    // Async func to handle Futures easier; or use Future.then
    if (apiToken != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setInt('userId', apiToken);
    }
    return null;
  }

  userIdGet() async {
    // Async func to handle Futures easier; or use Future.then
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int token = prefs.getInt('userId');
    return token;
  }

  userIdRemove() async {
    // Async func to handle Futures easier; or use Future.then
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('userId');
  }
}
