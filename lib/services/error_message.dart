import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
      methodCount: 0, // لا تعرض stack trace افتراضيًا
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.none),
);
