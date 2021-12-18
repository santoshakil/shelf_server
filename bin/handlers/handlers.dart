import 'package:shelf_router/shelf_router.dart' show Router;

import 'notification/get_notification.dart' show getNotificationHandler;
import 'notification/send_notification.dart' show sendNotificationHandler;

final handlers = Router()
  ..get('/getNotificaion', getNotificationHandler)
  ..post('/sendNotificaion', sendNotificationHandler);
