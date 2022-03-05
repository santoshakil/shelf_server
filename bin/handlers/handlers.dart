import 'package:shelf_router/shelf_router.dart' show Router;

import 'auth/signin.dart' show signInHandler;
import 'auth/signup.dart' show signUpHandler;
import 'callUsers/add_in_call_users.dart';
import 'callUsers/delete_in_call_users.dart';
import 'callUsers/get_in_call_users.dart';
import 'favourite/favourite_list_delete.dart';
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
  ..post('/addincalluser', inCallUsers)
  ..get('/userList', getUserListHandler)
  ..get('/activeUserList', getActiveUserListHandler)
  ..get('/getFavContact', getfavContactListHandler)
  ..get('/getInCallUsers', getInCallUsers)
  ..delete('/deleteFavContactList', deletefavContactListHandler)
  ..delete('/deleteInCallUsersList', deleteInCallUsersHandler);


final handlersWS = Router()..get('/getNotificaion', getNotificationHandler);

