// ignore_for_file: unnecessary_null_comparison

import 'dart:async' show FutureOr;
import 'dart:convert' show jsonDecode;

import 'package:hive/hive.dart';
import 'package:shelf/shelf.dart' show Request, Response;

import '../../models/callUsers.dart';
import '../../models/favouriteContact.dart';
import '../../models/user.dart' show User;

Future<FutureOr<Response>> inCallUsers(Request request) async {
  try {
    String _body = await request.readAsString();
    var _map = jsonDecode(_body);
    String? _email = _map['email'];
    int? _id=int.parse(_map['id']);
    print('gur $_email');
     UserCall? inCallUser = UserCall(email: _email,id: _id);
    inCallUser.put();

    return Response.ok('''{
    {
      "message": "successfully added"
    }
    
    }''');
  } on Exception catch (e) {
    print('xxxxxxxxxxxxxxxxx');
    print(e);
    print('xxxxxxxxxxxxxxxxx');
    return Response.internalServerError(body: 'Internal Server Error');
  }
}
