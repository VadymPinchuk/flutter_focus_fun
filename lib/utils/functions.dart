// please no flutter dependencies here - only dart

import 'dart:convert';

import 'package:flutter_focus_fun/utils/scope_functions.dart';

typedef Predicate<T> = bool Function(T arg);
typedef Transformer<U, R> = R Function(U arg);

Predicate<T> everyP<T>(Iterable<Predicate<T>> ps) =>
    (i) => ps.every((p) => p(i));

Predicate<T> anyP<T>(Iterable<Predicate<T>> ps) => (i) => ps.any((p) => p(i));

Never toDo([String? message]) =>
    throw UnimplementedError(message ?? 'not implemented');

Never defect(String message) {
  // ignore: avoid_print
  print("DEFECT: $message");
  throw UnimplementedError("Defect: $message");
}

Predicate<T> not<T>(Predicate<T> p) {
  return (x) => !p(x);
}

Predicate<T> alwaysTrue<T>() {
  return (_) => true;
}

Predicate<T> alwaysFalse<T>() {
  return (_) => false;
}

extension Combine<T> on Predicate<T> {
  Predicate<T> and(Predicate<T> p) {
    return (x) => this(x) && p(x);
  }

  Predicate<T> or(Predicate<T> p) {
    return (x) => this(x) || p(x);
  }
}

// ignore: avoid-dynamic
T? castOrNull<T>(dynamic x) => x is T ? x : null;

// ignore: avoid-dynamic
T castOr<T>(dynamic x, T fallback) => x is T ? x : fallback;

Transformer<T, T> identity<T>() => (T t) => t;

T min<T extends Comparable<T>>(T v1, T v2) => v1.compareTo(v2) <= 0 ? v1 : v2;

T max<T extends Comparable<T>>(T v1, T v2) => v1.compareTo(v2) >= 0 ? v1 : v2;

Object? tryJsonDecode(String input) {
  try {
    return jsonDecode(input);
  } on FormatException catch (_) {
    return null;
  }
}

Map<String, Object?>? safeJsonDecodeMap(dynamic message) =>
    (message as Object?)
        ?.takeIfType<String>()
        ?.let(tryJsonDecode)
        ?.takeIfType<Map<String, Object?>>();

class Pair<A, B> {
  final A a;
  final B b;

  const Pair(this.a, this.b);

  factory Pair.of(A a, B b) {
    return Pair(a, b);
  }
}

extension IIE<T> on Iterable<Iterable<T>> {
  Iterable<T> get flattened sync* {
    for (var elements in this) {
      yield* elements;
    }
  }

  List<T> get flatList => [for (final elements in this) ...elements];
}

extension BooleanExtension on bool {
  T when<T>({required T Function() isTrue, required T Function() isFalse}) {
    return this ? isTrue() : isFalse();
  }
}
