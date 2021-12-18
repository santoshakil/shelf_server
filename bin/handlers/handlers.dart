import 'package:shelf_router/shelf_router.dart' show Router;

import 'auth/signin.dart' show signInHandler;
import 'auth/signup.dart' show signUpHandler;
import 'notification/get_notification.dart' show getNotificationHandler;
import 'notification/send_notification.dart' show sendNotificationHandler;

final handlers = Router()
  ..post('/signup', signUpHandler)
  ..post('/signin', signInHandler)
  ..get('/getNotificaion', getNotificationHandler)
  ..post('/sendNotificaion', sendNotificationHandler);
