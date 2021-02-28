part of 'shared.dart';

class PreferenceManager {
  static var id;

  static savePreferences(int id, int number) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('id', id);
    pref.setInt('value', number);
    pref.commit();
  }

  static getPreferences(BuildContext context, double number) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getInt('id');
    if (id == 1) {
      number = 1;
    } else if (id == 2) {
      number = 2;
    } else if (id == 3) {
      number = 3;
    } else if (id == 4) {
      number = 4;
    } else {
      number = 5;
    }
  }
}
