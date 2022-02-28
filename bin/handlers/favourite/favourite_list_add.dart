import 'dart:async' show FutureOr;
import 'dart:convert' show jsonDecode;

import 'package:hive/hive.dart';
import 'package:shelf/shelf.dart' show Request, Response;

import '../../models/favouriteContact.dart';
import '../../models/user.dart' show User;

Future<FutureOr<Response>> favouriteListAdd(Request request) async {
  try {
    String _body = await request.readAsString();
    var _map = jsonDecode(_body);
    final String? _token = request.headers['Authorization'];
    int? _uid = int.parse(_map['id']);
    int? _fid = int.parse(_map['fid']);
    print('gur $_fid');
    //String? _email = _map['email'];
    Map<String, String> _e = {};
    // ignore: unnecessary_null_comparison
    if (_uid == null) _e.addAll({'id': 'Id is required'});
    //if (_email == null) _e.addAll({'email': 'email is required'});
    if (_fid == null) _e.addAll({'fid': 'favourite Id not found'});
    if (_token == null) return Response.forbidden('Invalid token');
    if (_e.isNotEmpty) return Response.forbidden(_e.toString());

    // User? _user = User.users.get(_fid);
    // print('gur $_user');
    // if (_user == null) return Response.forbidden('user not found');
    //if (_user.token != _token) return Response.forbidden('Invalid token');
    // if (_user.id != _uid) {
    //   return Response.forbidden('User name not found');
    // }

    User? uid = User.users.values.firstWhere((element) => element.id==_uid);
    User? fid = User.users.values.firstWhere((element) => element.id==_fid);
        print('gurur $uid');
    print('gurur ${User.users.values.last.id}');
    if (fid == null) {
      print('gururr $fid');

      return Response.forbidden('User Not Found');
    }
    FavContact? favConId = FavContact.favContacts.get(_uid.toString());
    if (favConId == null) {
      FavContact favList = FavContact(
          uid: _uid, users: HiveList<User>(User.users, objects: [fid]));
      FavContact.favContacts.put(_uid.toString(), favList);
    } else {
      favConId.users.add(fid);
      favConId.save();
    }
    // var _favContact = FavContact.fromMap(_map);
    // await _favContact.put();

    return Response.ok('''{
      
    {
      "message": "successfully added",
      "id":"$_fid"
    }
    
    }''');
  } on Exception catch (e) {
    print('xxxxxxxxxxxxxxxxx');
    print(e);
    print('xxxxxxxxxxxxxxxxx');
    return Response.internalServerError(body: 'Internal Server Error');
  }
}
