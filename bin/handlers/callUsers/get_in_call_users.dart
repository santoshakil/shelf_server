// ignore_for_file: unnecessary_null_comparison

import 'dart:async' show FutureOr;
import 'dart:convert' show jsonDecode;

import 'package:hive/hive.dart';
import 'package:shelf/shelf.dart' show Request, Response;

import '../../models/callUsers.dart';
import '../../models/favouriteContact.dart';
import '../../models/user.dart' show User;

Future<FutureOr<Response>> getInCallUsers(Request request) async {
  try {
    //String _body = await request.readAsString();
    //var _map = jsonDecode(_body);
    final String? _token = request.headers['Authorization'];
    if (_token == null) return Response.forbidden('Invalid token');
    // String? _email = _map['email'];
    // print('gur $_email');
    // final UserCall? _inCallUser = UserCall.inCallUser.values
    //     .firstWhere((element) => element.email == _email);
    // if (_inCallUser == null) {
    //   return Response.forbidden('User not found');
    // }

    var _callUsers =
        UserCall.inCallUser.values.map((e) => '\n' + e.toJson()).toList();

    return Response.ok('''{
      "users": $_callUsers
    
    }''');
  } on Exception catch (e) {
    print('xxxxxxxxxxxxxxxxx');
    print(e);
    print('xxxxxxxxxxxxxxxxx');
    return Response.internalServerError(body: 'Internal Server Error');
  }
}
