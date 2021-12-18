import 'package:hive/hive.dart' show Hive;

import '../models/user/user.dart' show UserAdapter;

Future<void> initHive() async {
  Hive.init('.hive');
  _registerAdapter();
}

void _registerAdapter() {
  Hive.registerAdapter(UserAdapter());
}
