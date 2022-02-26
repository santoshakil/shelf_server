import 'dart:io' show InternetAddress, Platform;

final serverIP = InternetAddress.anyIPv4;
final serverPort = int.parse(Platform.environment['PORT'] ?? '8080');
final serverPortWS = int.parse('8081');

const int hiveTypeUser = 1;
const int hiveTypeFavContact = 2;
