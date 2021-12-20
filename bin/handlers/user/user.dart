import 'dart:async' show FutureOr;

import 'package:shelf/shelf.dart' show Request, Response;

import '../../models/user/user.dart' show User;

FutureOr<Response> getUserListHandler(Request request) async {
  final String? _token = request.headers['Authorization'];
  if (_token == null) return Response.forbidden('Invalid token');
  final String? _email = request.headers['email'];
  if (_email == null) return Response.forbidden('email is required');
  final User? _user = User.users.get(_email);
  if (_user == null) return Response.forbidden('Invalid email');
  if (_user.token != _token) return Response.forbidden('Invalid token');

  var _users = User.users.values.map((e) => '\n' + e.toJson()).toList();

  return Response(
    200,
    body: '''
    {
      "message": "success",
      "users": $_users
    }
  ''',
  );
}
