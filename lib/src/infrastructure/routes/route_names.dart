import 'route_path.dart';

class RouteNames {
  static String home = RoutePath.home;
  static String splash = RoutePath.splash;
  static String login = RoutePath.login;
  static String register = '${RoutePath.login}${RoutePath.register}';
  static String events = RoutePath.events;
  static String myEvents = '${RoutePath.events}${RoutePath.myEvents}';
  static String addEvent =
      '${RoutePath.events}${RoutePath.myEvents}${RoutePath.addEvent}';
  static String editEvent =
      '${RoutePath.events}${RoutePath.myEvents}${RoutePath.editEvent}';
}
