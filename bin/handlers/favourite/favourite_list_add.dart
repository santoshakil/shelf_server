import 'dart:async' show FutureOr;
import 'dart:convert' show jsonDecode;

import 'package:shelf/shelf.dart' show Request, Response;

import '../../models/favouriteContact.dart';
import '../../models/user.dart' show User ;

Future<FutureOr<Response>> favouriteListAdd(Request request) async {
  try {
    String _body = await request.readAsString();
    var _map = jsonDecode(_body);
    final String? _token = request.headers['Authorization'];
    int? _id = int.parse(_map['id']);
     String? _name = _map['name'];
    String? _email = _map['email'];
    Map<String, String> _e = {};
    // ignore: unnecessary_null_comparison
    if (_id == null) _e.addAll({'id': 'Id is required'});
    if (_email == null) _e.addAll({'email': 'email is required'});
    if (_name == null) _e.addAll({'name': 'Name not found'});
    if (_token == null) return Response.forbidden('Invalid token');
    if (_e.isNotEmpty) return Response.forbidden(_e.toString());

    User? _user = User.users.get(_email);
    if (_user == null) return Response.forbidden('user not found');
    //if (_user.token != _token) return Response.forbidden('Invalid token');
    if (_user.name != _name) {
      return Response.forbidden('User name not found');
    }
    // ignore: unrelated_type_equality_checks
    // if (_user.id != _id) {
    //   return Response.forbidden('id not found');
    // }
      var _favContact = FavContact.fromMap(_map);
      await _favContact.put();
     if (_favContact.name == _name) {
      return Response.forbidden('User name already exits');
    }
      print('user created: ${_favContact.id.toString()}');

    return Response.ok('''{
      
    {
      "id": "${_favContact.id}",
      "name": "${_favContact.name}",
      "email": "${_favContact.email}"
    }
    
    }''');
  } on Exception catch (e) {
    print('xxxxxxxxxxxxxxxxx');
    print(e);
    print('xxxxxxxxxxxxxxxxx');
    return Response.internalServerError(body: 'Internal Server Error');
  }
}
