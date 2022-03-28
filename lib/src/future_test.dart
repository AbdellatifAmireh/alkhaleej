import 'dart:async';

import 'package:flutter/material.dart';

main() {
  Future someFutureResult() {
    final c = Completer();
    // complete will be called in 3 seconds by the timer.
    Timer(
      const Duration(seconds: 5),
      () => c.complete("you should see me second"),
    );
    return c.future;
  }

  // ignore: avoid_print
  someFutureResult().then((result) => debugPrint('test test $result'));
  someFutureResult().then((result) => debugPrint('test test $result'));
  debugPrint("you should see me first");
  someFutureResult().then((result) => debugPrint('test test $result'));
  someFutureResult().then((result) => debugPrint('test test $result'));
  debugPrint("you should see me first");
  someFutureResult().then((result) => debugPrint('test test $result'));
  debugPrint("you should see me first");
  someFutureResult().then((result) => debugPrint('test test $result'));
}
