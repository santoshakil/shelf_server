import '../postgres.dart';

Future<void> createChatTable(int uid) async {
  final _tableName = 'chat_$uid';

  await pg.execute('''
      CREATE TABLE IF NOT EXISTS $_tableName (
        id SERIAL PRIMARY KEY,
        sender_id INTEGER NOT NULL,
        message VARCHAR(255) NOT NULL,
        attachment bytea,
        sent_at TIMESTAMP NOT NULL DEFAULT NOW()
      )
    ''');
}

Future<void> createGroupChatInfoTable() async => await pg.execute('''
      CREATE TABLE IF NOT EXISTS group_chat_info (
        id SERIAL PRIMARY KEY,
        group_id VARCHAR(255) NOT NULL,
        admin_id INTEGER NOT NULL,
        name VARCHAR(255) NOT NULL,
        members VARCHAR[] NOT NULL,
        admins VARCHAR[] NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT NOW()
      )
    ''');

Future<void> createGroupChatTable(int uid) async {
  final _tableName = 'group_chat_$uid';

  await pg.execute('''
      CREATE TABLE IF NOT EXISTS $_tableName (
        id SERIAL PRIMARY KEY,
        sender_id INTEGER NOT NULL,
        message VARCHAR(255) NOT NULL,
        attachment bytea,
        sent_at TIMESTAMP NOT NULL DEFAULT NOW()
      )
    ''');

  await pg.execute(
    '''
    INSERT INTO group_chat_info (group_id, admin_id, name, members, admins)
    VALUES (@group_id, @admin_id, @name, @members, @admins)
    ''',
    substitutionValues: {
      'group_id': _tableName,
      'admin_id': uid,
      'name': 'Group Chat',
      'members': [uid],
      'admins': [uid],
    },
  );
}

Future<void> addUserToGroup(int uid, int gid) async {
  final results = await pg.query(
    'SELECT * FROM group_chat_info WHERE group_id = @group_id',
    substitutionValues: {'group_id': gid},
  );

  if (results.isEmpty) return;

  var members = results.first.toColumnMap()['members'] as List<dynamic>;
  var admins = results.first.toColumnMap()['admins'] as List<dynamic>;

  await pg.execute(
    '''
    UPDATE group_chat_info
    SET members = @members,
        admins = @admins
    WHERE group_id = @group_id
    ''',
    substitutionValues: {
      'group_id': gid,
      'members': members..add(uid),
      'admins': admins..add(uid),
    },
  );
}

Future<void> removeUserFromGroup(int uid, int gid) async {
  final results = await pg.query(
    'SELECT * FROM group_chat_info WHERE group_id = @group_id',
    substitutionValues: {'group_id': gid},
  );

  if (results.isEmpty) return;

  var members = results.first.toColumnMap()['members'] as List<dynamic>;
  var admins = results.first.toColumnMap()['admins'] as List<dynamic>;

  await pg.execute(
    '''
    UPDATE group_chat_info
    SET members = @members,
        admins = @admins
    WHERE group_id = @group_id
    ''',
    substitutionValues: {
      'group_id': gid,
      'members': members..remove(uid),
      'admins': admins..remove(uid),
    },
  );
}

Future<void> sendMessage({
  required int uid,
  required int chatID,
  required String message,
  attachment,
}) async =>
    await pg.execute(
      '''
    INSERT INTO $chatID (sender_id, message, attachment)
    VALUES (@sender_id, @message, @attachment)
    ''',
      substitutionValues: {
        'sender_id': uid,
        'message': message,
        'attachment': attachment,
      },
    );

Future<void> deleteMessage({
  required int chatID,
  required int messageID,
}) async =>
    await pg.execute(
      '''
    DELETE FROM $chatID
    WHERE id = @message_id
    ''',
      substitutionValues: {'message_id': messageID},
    );
