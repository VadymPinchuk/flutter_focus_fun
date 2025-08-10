// please no flutter dependencies here, only dart

import 'package:flutter_focus_fun_tv_demo/utils/functions.dart' show Predicate;

/// Extensions that can be used on any type [T].
extension ScopeFunctionExt<T> on T {
  /// Calls the specified function [block] with this value as its argument and
  /// returns `this` value.
  T also(void Function(T it) block) {
    block(this);
    return this;
  }

  Future<T> alsoAsync(Future<void> Function(T it) block) async {
    await block(this);
    return Future<T>.value(this);
  }

  /// Calls the specified function [block] with `this` value as its argument and
  /// returns its result.
  R let<R>(R Function(T it) block) {
    return block(this);
  }

  Future<R> letAsync<R>(Future<R> Function(T it) block) {
    return block(this);
  }

  /// Returns `this` value if it satisfies the given [predicate] or null if
  /// it doesn't.
  T? takeIf(Predicate<T> predicate) {
    return predicate(this) ? this : null;
  }

  /// Returns `this` value if it type R or null if it doesn't.
  R? takeIfType<R extends T>() {
    return this is R ? this as R : null;
  }

  /// Returns `this` value if it does not satisfy the given [predicate] or
  /// null if it does.
  T? takeUnless(Predicate<T> predicate) {
    return predicate(this) ? null : this;
  }
}

/// Extensions that can be used on any nullable type [T].
extension ScopeFunctionNullableExt<T> on T? {
  /// Calls the specified function [block] with `this` value as its argument and
  /// returns its result. In case `this` is null, it will return whatever is
  /// provided in [orElse].
  R letOrElse<R>(R Function(T it) block, {required R Function() orElse}) {
    final that = this;
    return that == null ? orElse() : that.let((inner) => block(inner));
  }

  R letOrDefault<R>(R Function(T it) block, {required R orElse}) {
    final self = this;
    return self == null ? orElse : self.let((inner) => block(inner));
  }

  /// This extension is used to prevent using `??` (null-coalescing operator)
  /// in favor of a more functional approach. In case the provided value of type
  /// [T] is null, it will return provided [defaultValue].
  T withDefault(T defaultValue) {
    return this ?? defaultValue;
  }

  T unwrap(String Function()? nullExceptionReason) {
    if (this == null) {
      throw Exception(nullExceptionReason?.call() ?? 'Unexpected null value');
    }
    return this!;
  }

  T? alsoOr(void Function(T it) block, {required void Function() orElse}) {
    this?.also(block) ?? orElse();
    return this;
  }

  Future<T?> alsoOrAsync(
    Future<void> Function(T it) block, {
    required Future<void> Function() orElse,
  }) async {
    await this?.alsoAsync(block) ?? orElse();
    return this;
  }
}
