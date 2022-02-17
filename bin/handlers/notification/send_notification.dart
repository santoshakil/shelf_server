import 'dart:async' show FutureOr;
import 'dart:convert' show jsonDecode;

import 'package:shelf/shelf.dart' show Request, Response;

import '../../database/channels.dart' show channels;
import '../../models/user/user.dart' show User;

FutureOr<Response> sendNotificationHandler(Request request) async {
  try {
    final String _body = await request.readAsString();
    final Map<String, dynamic> _map = jsonDecode(_body);

    final String? _auth = request.headers['Authorization'];
    if (_auth == null) return Response.forbidden('Invalid Authorization');

    final String? _to = _map['to'];
    final String? _task = _map['task'];
    final String? _time = _map['time'];
    final String? _email = _map['email'];
    final String? _reacts = _map['reacts'];
    final String? _message = _map['message'];
    final String _type = _map['type'] ?? 'text';
    final bool _isSeen = _map['isSeen'] ?? false;
    final bool _isDelete = _map['isDelete'] ?? false;
    final bool _delayed = _map['delayed'] ?? false;
    final String? _image = _map['image'];
    final String? _groupId = _map['groupId'];
    final String? _replyId = _map['replyId'];
    final String? _disappear = _map['disappear'];
    final String? _reminder = _map['reminder'];


    if (_message == null || _email == null || _to == null) {
      return Response.forbidden('message, email and to are required');
    }

    final User? _user = User.users.get(_email);
    if (_user == null) return Response.forbidden('User not found');
    if (_user.token != _auth) {
      return Response.forbidden('Invalid Authorization');
    }

    final User? _toUser = User.users.get(_to);
    if (_toUser == null) return Response.forbidden('To user not found');

    final _channel = channels[_to];
    if (_channel == null) return Response.forbidden('To User is not connected');

    _channel.sink.add('''
    {
      "message": "$_message",
      "email": "$_email",
      "sender": "${_user.name}",
      "time": "$_time",
      "isSeen": $_isSeen,
      "isDelete": $_isDelete,
      "reacts": $_reacts,
      "task": "$_task",
      "type": "$_type",
      "image": "$_image",
      "groupId": "$_groupId",
      "replyId": "$_replyId",
      "disappear": "$_disappear",
      "reminder": "$_reminder",
      "delayed": $_delayed
    }
    ''');
    print('Message sent to $_to from $_email');

    return Response.ok('Message sent!');
  } on Exception catch (e) {
    // print('xxxxxxxxxxxxxxxxx');
    // print(await request.readAsString());
    print('xxxxxxxxxxxxxxxxx');
    print(e);
    print('xxxxxxxxxxxxxxxxx');
    return Response.internalServerError(body: 'Internal Server Error');
  }
}
