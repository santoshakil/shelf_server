import 'package:shelf_router/shelf_router.dart' show Router;

import 'auth/signin.dart' show signInHandler;
import 'auth/signup.dart' show signUpHandler;
import 'notification/get_notification.dart' show getNotificationHandler;
import 'notification/send_notification.dart' show sendNotificationHandler;
import 'user/user.dart' show getUserListHandler;

final handlers = Router()
  ..post('/signup', signUpHandler)
  ..post('/signin', signInHandler)
  ..post('/sendNotificaion', sendNotificationHandler)
  ..get('/getNotificaion', getNotificationHandler)
  ..get('/userList', getUserListHandler);
