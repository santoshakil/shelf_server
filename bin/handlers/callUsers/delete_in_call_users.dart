import 'dart:async' show FutureOr;

import 'package:hive/hive.dart';
import 'package:shelf/shelf.dart' show Request, Response;

import '../../database/channels.dart' show channels;
import '../../models/callUsers.dart';
import '../../models/favouriteContact.dart';
import '../../models/user.dart' show User;
import 'dart:convert' show jsonDecode;

// import 'package:han' show User;

FutureOr<Response> deleteInCallUsersHandler(Request request) async {
  try {
    String body = await request.readAsString();
    var _map = jsonDecode(body);
    int? _fid = int.parse(_map['fid']);
    print('deleted Item $_fid');
    
    bool? idMatach = UserCall.inCallUser.values.any((element) => element.id == _fid);
    final _inCallUserList=UserCall.inCallUser.values.toList();
    final _index=_inCallUserList.indexWhere((element) => element.id == _fid);

    print('deleted Item $idMatach');

    if (idMatach == true) {
      UserCall.inCallUser.deleteAt(_index);
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
