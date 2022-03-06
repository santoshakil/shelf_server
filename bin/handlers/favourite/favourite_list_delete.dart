import 'dart:async' show FutureOr;

import 'package:hive/hive.dart';
import 'package:shelf/shelf.dart' show Request, Response;

import '../../database/channels.dart' show channels;
import '../../models/favouriteContact.dart';
import '../../models/user.dart' show User;
import 'dart:convert' show jsonDecode;

// import 'package:han' show User;

FutureOr<Response> deletefavContactListHandler(Request request) async {
  try {
    String body = await request.readAsString();
    dynamic desiredKey;
    final box = Hive.box<FavContact>('favContactBox');
    var _map = jsonDecode(body);
    int? _uid = int.parse(_map['id']);
    int? _fid = int.parse(_map['fid']);
    //String? _name = _map['name'];
    //int? deleteItem;
    print('deleted Item $_fid');
    //print('deleted Item $_name');
    final String? _token = request.headers['Authorization'];
    if (_token == null) return Response.forbidden('Invalid token');
    // final String? _email = request.headers['email'];
    // if (_email == null) return Response.forbidden('email is required');
    // print('emaiiill ${User.users.values}');
    // final User? _user = User.users.get(_email);
    // if (_user == null) return Response.forbidden('Invalid email');
    // if (_user.token != _token) return Response.forbidden('Invalid token');

    // var _favContactList =
    //     FavContact.favContacts.values.map((e) => '\n' + e.toJson()).toList();
    FavContact? favConId = FavContact.favContacts.get(_uid.toString());
    var favMap = favConId?.users;
    // favMap.forEach((key, value){
    //     if (value.id == _fid) {
    //       desiredKey = key;
    //     }
    // });
    bool? idMatach = favConId?.users.any((element) => element.id == _fid);
    print('deleted Item ${favConId?.users.length}');

    if (idMatach == true) {
      favMap?.removeWhere((element) => element.id==_fid);
      //print('deleted Item lenth $deleteFav');
    }

    return Response(
      200,
      body: '''
    {
      "message": "success",
      "deleted_item":"$_fid"
    }
  ''',
    );
  } on Exception catch (e) {
    print('xxxxxxxxxxxxxxxxx');
    print(e);
    print('xxxxxxxxxxxxxxxxx');
    return Response.internalServerError(body: 'Internal Server Error');
  }
}
