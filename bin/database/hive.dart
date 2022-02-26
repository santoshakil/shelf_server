import 'package:hive/hive.dart' show Hive;

import '../models/favouriteContact.dart';
import '../models/user.dart' show User, UserAdapter;





Future<void> initHive() async {
  Hive.init('.hive');
  _registerAdapter();
  await _openBox();
}

void _registerAdapter() {
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(FavContactAdapter());
}

Future<void> _openBox() async {
  await Hive.openBox<User>(User.boxName);
  await Hive.openBox<FavContact>(FavContact.boxName);
}
