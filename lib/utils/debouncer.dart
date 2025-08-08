import 'dart:async';

/// A utility class that debounces the execution of a function.
///
/// This is useful for rate-limiting events that occur frequently, such as
/// search input changes, to avoid excessive processing.
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 300)});

  /// Calls the given [callback] after the [delay] has passed.
  /// If [call] is called again before the [delay] has passed,
  /// the previous callback is canceled and the timer is reset.
  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  /// Cancels any pending callbacks.
  void cancel() {
    _timer?.cancel();
  }

  /// Whether there is a pending callback.
  bool get isRunning => _timer?.isActive ?? false;

  /// Disposes of the debouncer and cancels any pending callbacks.
  void dispose() {
    _timer?.cancel();
  }
}
