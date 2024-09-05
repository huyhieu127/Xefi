import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart';

abstract class DateTimeUtils {
  DateTimeUtils._();

  static String toDateTime(String? dateTimeApi) {
    if (dateTimeApi == null || dateTimeApi.isEmpty) {
      return "";
    }
    DateTime dt = DateTime.parse(dateTimeApi);
    String formattedTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(dt);
    return formattedTime;
  }

  static String toTimeAgo(String? dateTimeApi) {
    if (dateTimeApi == null || dateTimeApi.isEmpty) {
      return "";
    }

    DateTime targetFm = DateTime.parse(toDateTime(dateTimeApi));
    var now = DateTime.now();
    var duration =
        (now.millisecondsSinceEpoch - targetFm.millisecondsSinceEpoch);
    var dff = now.difference(targetFm);
    var compare = now.subtract(Duration(seconds: dff.inSeconds));
    final result = timeago.format(compare, locale: 'vi');
    return result;
  }
}

class MyCustomMessagesTimeAgo implements LookupMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => 'Vừa xong';

  @override
  String aboutAMinute(int minutes) => '1 phút trước';

  @override
  String minutes(int minutes) => '$minutes phút trước';

  @override
  String aboutAnHour(int minutes) => '1 giờ trước';

  @override
  String hours(int hours) => '$hours giờ trước';

  @override
  String aDay(int hours) => '1 ngày trước';

  @override
  String days(int days) => '$days ngày trước';

  @override
  String aboutAMonth(int days) => '1 tháng trước';

  @override
  String months(int months) => '$months tháng trước';

  @override
  String aboutAYear(int year) => '1 năm trước';

  @override
  String years(int years) => '$years năm trước';

  @override
  String wordSeparator() => ' ';
}
