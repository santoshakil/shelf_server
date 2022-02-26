import 'package:shelf_router/shelf_router.dart' show Router;

import 'auth/signin.dart' show signInHandler;
import 'auth/signup.dart' show signUpHandler;
import 'favourite/favourite_list_get.dart' show getfavContactListHandler;
import 'notification/get_notification.dart' show getNotificationHandler;
import 'notification/send_notification.dart' show sendNotificationHandler;
import 'user/user.dart' show getActiveUserListHandler, getUserListHandler;
import 'favourite/favourite_list_add.dart' show favouriteListAdd;

final handlers = Router()
  ..post('/signup', signUpHandler)
  ..post('/signin', signInHandler)
  ..post('/sendNotificaion', sendNotificationHandler)
  ..post('/addfavouriteList', favouriteListAdd)
  ..get('/userList', getUserListHandler)
  ..get('/activeUserList', getActiveUserListHandler)
  ..get('/getFavContact', getfavContactListHandler);

final handlersWS = Router()..get('/getNotificaion', getNotificationHandler);
