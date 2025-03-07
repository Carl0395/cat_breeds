import 'package:flutter/foundation.dart';

void debugLog(dynamic log, [StackTrace? stack]) {
  if (kDebugMode) {
    print('$log ${stack != null ? '\n$stack' : ''}');
  }
}
