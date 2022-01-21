import 'dart:async' show FutureOr;
import 'dart:convert' show jsonDecode;

import 'package:shelf/shelf.dart' show Request, Response;

import '../../database/postgres/functions/user.dart';
import '../../models/user/user.dart' show User;

FutureOr<Response> signInHandler(Request request) async {
  String _body = await request.readAsString();
  var _map = jsonDecode(_body);
  String? _email = _map['email'];
  String? _password = _map['password'];

  Map<String, String> _e = {};
  if (_email == null) _e.addAll({'email': 'email is required'});
  if (_password == null) _e.addAll({'password': 'password is required'});
  if (_e.isNotEmpty) return Response.forbidden(_e.toString());

  // User? _user = User.users.get(_email);
  User? _user = await getUserByEmail(_email!);
  if (_user == null) return Response.forbidden('user not found');
  if (_user.password != _password) {
    return Response.forbidden('password is incorrect');
  }
  print('user: ${_user.name} logged in');

  return Response.ok('''
  {
    "message": "user logged in!",
    "token": "${_user.token}",
    "id": "${_user.id}",
    "name": "${_user.name}",
    "email": "${_user.email}",
    "phone": "${_user.phone}",
    "address": "${_user.address}",
    "designation": "${_user.designation}",
    "depertment": "${_user.depertment}"
  }
  ''');
}
