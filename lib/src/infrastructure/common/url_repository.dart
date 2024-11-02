class UrlRepository {
  UrlRepository._();

  // Base
  static const String _baseUrl = 'http://localhost:3000';
  static const String _users = '/users';
  static const String _events = '/events';

  // login
  static Uri loginByUsername({
    required String username,
  }) {
    return Uri.parse('$_baseUrl$_users?username=$username');
  }

  // users
  static Uri users = Uri.parse('$_baseUrl$_users');

  static Uri userByUsername({required String username}) {
    return Uri.parse('$_baseUrl$_users?username=$username');
  }

  static Uri userById({required int id}) {
    return Uri.parse('$_baseUrl$_users/$id');
  }

  // events
  static Uri getAllEvents = Uri.parse('$_baseUrl$_events');

  static Uri getEventsByMakerId({required int makerId}) {
    return Uri.parse('$_baseUrl$_events?makerId=$makerId');
  }

  static Uri addEvent = Uri.parse('$_baseUrl$_events');

  static Uri getEventById({required int eventId}) {
    return Uri.parse('$_baseUrl$_events/$eventId');
  }

  static Uri deleteEventById({required int eventId}) {
    return Uri.parse('$_baseUrl$_events/$eventId');
  }

  static Uri searchEventByParams({String? title, String? params}) {
    if (title == null && params == null) {
      return Uri.parse('$_baseUrl$_events');
    }

    return Uri.parse('$_baseUrl$_events/?title_like=$title${params ?? ''}');
  }

  static Uri searchEventByTitleAndMakerId({
    required String title,
    required int makerId,
  }) {
    return Uri.parse('$_baseUrl$_events/?makerId=$makerId&title_like=$title');
  }
}
