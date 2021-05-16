import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_listener/hive_listener.dart';

void main() async {
  await Hive.initFlutter('example_hive_folder');
  await Hive.openBox('settings');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HiveListener(
      box: Hive.box('settings'),
      keys: [
        'dark_theme'
      ], // keys is optional to specify listening value changes
      builder: (box) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: box.get('dark_theme', defaultValue: false)
              ? ThemeData.dark()
              : ThemeData.light(),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String? title;

  const MyHomePage({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box settingsBox = Hive.box('settings');
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            HiveListener(
              box: settingsBox,
              keys: [
                'counter'
              ], // keys is optional to specify listening value changes
              builder: (box) {
                return Text(
                  '${box.get('counter', defaultValue: 0)}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                bool darkTheme =
                    settingsBox.get('dark_theme', defaultValue: false);
                settingsBox.put('dark_theme', !darkTheme);
              },
              child: Text("Switch Dark Theme"),
            ),
            ElevatedButton(
              onPressed: () {
                settingsBox.put('counter', 0);
              },
              child: Text("Reset Counter"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int counter = settingsBox.get('counter', defaultValue: 0);
          settingsBox.put('counter', ++counter);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
