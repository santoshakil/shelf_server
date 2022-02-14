import 'dart:io' show InternetAddress, Platform;

// final serverIP = InternetAddress.anyIPv4;
final serverIP = 'communication.algorithmgeneration.com';
final serverPort = int.parse(Platform.environment['PORT'] ?? '8080');

const int hiveTypeUser = 1;
