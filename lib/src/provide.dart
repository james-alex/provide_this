import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Mixes in a method on a [Widget] that builds a [Provider] that
/// passes an object to its children.
mixin Provide<T> on Widget {
  /// Builds a [Provider] that passes [object] to the children of `this`.
  ///
  /// Use [Provider]'s methods, or its [BuildContext] extension methods,
  /// to get `this` from the context of [child] or any of its children.
  /// Call `context.watch<T>()` in [build].
  ///
  /// See: https://pub.dev/packages/provider#exposing-a-value
  ///
  /// Consider extending [BuildContext] with a getter that calls
  /// `context.watch<T>()` to make your value even more convenient
  /// to access.
  ///
  /// See the README: https://pub.dev/packages/provide_this for an example,
  /// or https://dart.dev/guides/language/extension-methods for more info
  /// on extension methods.
  Provider<T> provide(T object) {
    assert(object != null);

    return Provider<T>(
      create: (_) => object,
      child: this,
    );
  }
}
