import 'package:hive/hive.dart';

class HiveDB {
  Box<String> databaseBox = Hive.box<String>("DB");

  void saveKey(String randomKey) {
    databaseBox.put('privateKey', randomKey);
  }

  String getKey() {
    String key = databaseBox.get('privateKey');
    return key;
  }
}

//WidgetsFlutterBinding.ensureInitialized();
//Directory document = await getApplicationDocumentsDirectory();
//Hive.init(document.path);
//await Hive.openBox<String>("keyDB");
