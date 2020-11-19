# provide_this

provide_this is a set of mixins that expose a method for building a [Provider].

[Provide] mixes in a method on any [Widget] called [provide] that builds a
[Provider] with `this` widget as its child and provides an object to its
children.

[ProvideTo] mixes in a method on any class called [provideTo] that builds a
[Provider] that provides `this` to a [Widget] and its children.

See: [Provider](https://pub.dev/packages/provider).

# Usage

```dart
import 'package:provide_this/provide_this.dart';
```

## Mixing Provide into a Widget.

Mix [Provide] with a sub-type of the object being provided into any [Widget].

```dart
class MyWidget extends StatelessWidget with Provide<MyObject> {
  @override
  Widget build(BuildContext context) {
    return MyWidgetView();
  }
}
```

Now you can call the [provide] method from an instance of [MyWidget] to wrap
it in a [Provider] and pass a supplied object to it and its children.

```dart
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String myValue = 'My Value';

  @override
  Widget build(BuildContext context) {
    return MyWidget().provide(myValue);
  }
}
```

Now [myValue] will be accessible via the [Provider] from within [MyWidget]
and its child [MyWidgetView] by using [Provider]'s getters or by extending
[BuildContext] with a getter of your own.

```dart
class MyWidgetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myValue = context.watch<String>();

    return Text(myValue);
  }
}
```

Alternatively, if you extend [BuildContext] with a getter called [string]:

```dart
extension GetMyValue on BuildContext {
  String get string => watch<String>();
}

class MyWidgetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(context.string);
  }
}
```

## Mixing ProvideTo into a class.

Mix [ProvideTo] with a sub-type of the class its being mixed into any class.

```dart
class MyClass with ProvideTo<MyClass> {
  final String _myPrivateValue = 'foo';

  String get myValue => _myPrivateValue;
}
```

Now you can call the [provideTo] method on your class to build a [Provider] that
passes the active instance (`this`) of the class to any Flutter [Widget].

```dart
class MyApp extends StatelessWidget {
  const MyApp(this.myClass);

  final MyClass myClass;

  @override
  Widget build(BuildContext context) {
    return myClass.provideTo(MyWidget());
  }
}
```

Now [myClass] will be accessible via the [Provider] from within [MyWidget]
and its children by using [Provider]'s getters or by extending [BuildContext]
with a getter of your own.

```dart
class MyWidget extends StatelessWidget {
  const MyWidget();

  @override
  Widget build(BuildContext context) {
    final myClass = context.watch<MyClass>();

    return Text(myClass.myValue);
  }
}
```

Alternatively, if you extend [BuildContext] with a getter called [myValue]:

```dart
extension GetMyClass on BuildContext {
  MyClass get myValue => watch<MyClass>().myValue;
}

class MyWidgetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(context.myValue);
  }
}
```
