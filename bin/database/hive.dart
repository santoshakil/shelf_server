import 'package:hive/hive.dart' show Hive;

import '../models/callUsers.dart';
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
  Hive.registerAdapter(UserCallAdapter());
}

Future<void> _openBox() async {
  await Hive.openBox<User>(User.boxName);
  await Hive.openBox<FavContact>(FavContact.boxName);
  await Hive.openBox<UserCall>(UserCall.boxName);
}
