import 'dart:async' show FutureOr;
import 'dart:convert' show jsonDecode;

import 'package:shelf/shelf.dart' show Request, Response;

import '../../models/user/user.dart' show User;

FutureOr<Response> signUpHandler(Request request) async {
  var _body = await request.readAsString();
  var _map = jsonDecode(_body);

  Map<String, String> _e = {};
  if (_map['name'] == null) _e.addAll({'name': 'name is required'});
  if (_map['email'] == null) _e.addAll({'email': 'email is required'});
  if (_map['password'] == null) _e.addAll({'password': 'password is required'});
  if (_e.isNotEmpty) return Response.forbidden(_e.toString());

  if (User.users.containsKey(_map['email'])) {
    return Response.forbidden('email already exists');
  }

  var _user = User.fromMap(_map);
  print(_user.token);
  await _user.put();

  return Response.ok('{"message": "user created", "token": "${_user.token}"}');
}
