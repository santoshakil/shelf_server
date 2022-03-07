import 'dart:async' show FutureOr;

import 'package:shelf/shelf.dart' show Request, Response;

import '../../database/channels.dart' show channels;
import '../../models/user.dart' show User;
// import 'package:han' show User;

FutureOr<Response> getUserListHandler(Request request) async {
  final String? _token = request.headers['Authorization'];
  if (_token == null) return Response.forbidden('Invalid token');
  final String? _email = request.headers['email'];
  if (_email == null) return Response.forbidden('email is required');
  //print('emaiiill ${User.users.values}');
  final User? _user = User.users.values.firstWhere((element) => element.email==_email);
  if (_user == null) return Response.forbidden('User not found');
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

FutureOr<Response> getActiveUserListHandler(Request request) async {
  final String? _token = request.headers['Authorization'];
  if (_token == null) return Response.forbidden('Invalid token');
  final String? _email = request.headers['email'];
  if (_email == null) return Response.forbidden('email is required');
  final User? _user = User.users.values.firstWhere((element) => element.email==_email);
  if (_user == null) return Response.forbidden('Invalid email');
  if (_user.token != _token) return Response.forbidden('Invalid token');

  var _users = channels.entries.map((e) => '\n' '"' + e.key + '"').toList();

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
