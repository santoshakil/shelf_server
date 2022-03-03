import 'dart:async' show FutureOr;
import 'dart:convert' show jsonDecode;

import 'package:shelf/shelf.dart' show Request, Response;

import '../../models/user.dart' show User;

FutureOr<Response> signInHandler(Request request) async {
  try {
    String _body = await request.readAsString();
    print('sign innnn ${_body}');
    var _map = jsonDecode(_body);
    String? _email = _map['email'];
    String? _password = _map['password'];
    print('UserEmail ${_map['email']}');
    print('UserPassword ${_map['password']}');
    print('UserEmail $_email');
    print('UserPassword $_password');

    Map<String, String> _e = {};
    if (_email == null) _e.addAll({'email': 'email is required'});
    if (_password == null) _e.addAll({'password': 'password is required'});
    if (_e.isNotEmpty) return Response.forbidden(_e.toString());

    User? _user = User.users.values
        .firstWhere((element) => element.email == _map['email']);
    if (_user == null) return Response.forbidden('user not found');
    if (_user.password != _password) {
      return Response.forbidden('password is incorrect');
    }
    print('user: ${_user.name} logged in');

    return Response.ok('''
    {
      "message": "user created",
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
  } on Exception catch (e) {
    // print('xxxxxxxxxxxxxxxxx');
    // print(await request.readAsString());
    print('xxxxxxxxxxxxxxxxx');
    print(e);
    print('xxxxxxxxxxxxxxxxx');
    return Response.internalServerError(body: 'Internal Server Error');
  }
}
