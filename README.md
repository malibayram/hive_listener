# hive_listener

A tiny widget to listen hive box changes

## How to use

```dart
HiveListener(
  box: Hive.box('settings'),
  keys: ['dark_theme'], // keys is optional to specify listening value changes
  builder: (box) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: box.get('dark_theme', defaultValue: false) ? ThemeData.dark() : ThemeData.light(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  },
)
 ```