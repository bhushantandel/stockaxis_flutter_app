import 'dart:io';
import 'dart:developer' as dev;

class AppLogs {
  static bool logFlag = true;

  /// This is printlog function to print log based logflag .if logflag true print log else log will not print
  static void printLog(var msg) {
    if (logFlag) {
      if (Platform.isIOS) {
        print(msg);
      } else {
        dev.log(msg);
      }
    }
  }
}
