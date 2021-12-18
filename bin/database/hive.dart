import 'package:hive/hive.dart' show Hive;

Future<void> initHive() async {
  Hive.init('.hive');
}
