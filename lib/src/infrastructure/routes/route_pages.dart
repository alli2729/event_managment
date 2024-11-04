import '../../pages/settings/common/setting_bindings.dart';
import '../../pages/settings/views/setting_screen.dart';
import '../../pages/bookmark_event/common/bookmark_event_binding.dart';
import '../../pages/bookmark_event/views/bookmark_event_screen.dart';
import '../../pages/event_detail/common/event_detail_bindings.dart';
import '../../pages/event_detail/views/event_detail_screen.dart';
import '../../pages/add_event/common/add_event_bindings.dart';
import '../../pages/add_event/views/add_event_screen.dart';
import '../../pages/edit_event/common/edit_event_bindings.dart';
import '../../pages/edit_event/views/edit_event_screen.dart';
import '../../pages/my_events/common/my_events_bindings.dart';
import '../../pages/my_events/views/my_events_screen.dart';
import '../../pages/events/common/events_bindings.dart';
import '../../pages/events/views/events_screen.dart';
import '../../pages/register/common/register_bindings.dart';
import '../../pages/register/views/register_screen.dart';
import '../../pages/login/common/login_bindings.dart';
import '../../pages/login/views/login_screen.dart';
import 'package:get/get.dart';
import 'route_path.dart';
import '../../pages/splash/common/splash_bindings.dart';
import '../../pages/splash/views/splash_view.dart';

class RoutePages {
  static List<GetPage> pages = [
    GetPage(
      name: RoutePath.splash,
      page: () => const SplashView(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: RoutePath.login,
      page: () => const LoginScreen(),
      binding: LoginBindings(),
      children: [
        GetPage(
          name: RoutePath.register,
          page: () => const RegisterScreen(),
          binding: RegisterBindings(),
        ),
      ],
    ),
    GetPage(
      name: RoutePath.events,
      page: () => const EventsScreen(),
      binding: EventsBindings(),
      children: [
        GetPage(
          name: RoutePath.settings,
          page: () => const SettingScreen(),
          binding: SettingBindings(),
        ),
        GetPage(
          name: RoutePath.eventDetail,
          page: () => const EventDetailScreen(),
          binding: EventDetailBindings(),
        ),
        GetPage(
          name: RoutePath.bookmark,
          page: () => const BookmarkEventScreen(),
          binding: BookmarkEventBinding(),
        ),
        GetPage(
          name: RoutePath.myEvents,
          page: () => const MyEventsScreen(),
          binding: MyEventsBindings(),
          children: [
            GetPage(
              name: RoutePath.addEvent,
              page: () => const AddEventScreen(),
              binding: AddEventBindings(),
            ),
            GetPage(
              name: RoutePath.editEvent,
              page: () => const EditEventScreen(),
              binding: EditEventBindings(),
            ),
          ],
        )
      ],
    ),
  ];
}
