import 'package:hive/hive.dart' show Hive;

import '../models/user/user.dart' show User, UserAdapter;

Future<void> initHive() async {
  Hive.init('.hive');
  _registerAdapter();
  await _openBox();
}

void _registerAdapter() {
  Hive.registerAdapter(UserAdapter());
}

Future<void> _openBox() async {
  await Hive.openBox<User>(User.boxName);
}
