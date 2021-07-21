import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences pref;
  static myUid() => pref.getString("id");
}
