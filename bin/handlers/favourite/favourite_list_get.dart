import 'dart:async' show FutureOr;

import 'package:shelf/shelf.dart' show Request, Response;

import '../../database/channels.dart' show channels;
import '../../models/favouriteContact.dart';
import '../../models/user.dart' show User;
// import 'package:han' show User;

FutureOr<Response> getfavContactListHandler(Request request) async {
  final String? _token = request.headers['Authorization'];
  if (_token == null) return Response.forbidden('Invalid token');
  final int? _id = int.parse(request.headers['id']!);
  if (_id == null) return Response.forbidden('id is required');
  //print('emaiiill $_id');
  // final User? _user = User.users.get(_id);
  // if (_user == null) return Response.forbidden('Invalid id');
  // if (_user.token != _token) return Response.forbidden('Invalid token');

  // var _favUser =
  //     FavContact.favContacts.values.firstWhere((element) => element.uid==_id);
  // print('kkjj $_favUser');
  // if (FavContact.favContacts == null) {
  //   return Response.forbidden('No Data Found');
  // }
  // if (_favUser == null) {
  //   print('kkjj ${FavContact.favContacts.values.length}');
  //   return Response.forbidden('Id not found');
  // }
  // var _fav = _favUser.users;
  // print('kkjj ${_fav.length}');
  var getFav=FavContact.favContacts.get(_id.toString());
  var _favContactList = getFav?.users.map((e) => '\n' + e.toJson()).toList();
//print('deleted Item ${FavContact.favContacts.values.length}');
  return Response(
    200,
    body: '''
    {
      "message": "success",
      "users": $_favContactList
    }
  ''',
  );
}
