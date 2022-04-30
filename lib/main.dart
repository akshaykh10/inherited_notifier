import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inherited Notifier Demo',
      initialRoute: '/one',
      routes: {
        '/one': (context) => const HomePage(),
        '/two': (context) => const SecondPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          centerTitle: true,
        ),
        floatingActionButton: IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/two',
            );
          },
          icon: const Icon(Icons.forward),
        ),
        body: SliderInheritedNotifier(
          notifier: sliderData,
          child: Builder(builder: (context) {
            return Column(
              children: [
                Slider(
                  value: SliderInheritedNotifier.of(context),
                  onChanged: (value) {
                    sliderData.changeOpacity = value;
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Opacity(
                        opacity: SliderInheritedNotifier.of(context),
                        child: Container(
                          color: Colors.yellow,
                          height: 200.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Opacity(
                        opacity: SliderInheritedNotifier.of(context),
                        child: Container(
                          color: Colors.green,
                          height: 200.0,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
        ));
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
        centerTitle: true,
      ),
      body: Center(
        child: SliderInheritedNotifier(
          notifier: sliderData,
          child: Builder(builder: (context) {
            return Opacity(
              opacity: SliderInheritedNotifier.of(context),
              child: Container(
                color: Colors.red,
                height: 100.0,
                width: 100.0,
              ),
            );
          }),
        ),
      ),
    );
  }
}

class SliderData extends ChangeNotifier {
  double _value = 0.0;
  double get value => _value;
  set changeOpacity(double newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }
}

SliderData sliderData = SliderData();

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  const SliderInheritedNotifier({
    Key? key,
    required SliderData notifier,
    required Widget child,
  }) : super(
          key: key,
          notifier: notifier,
          child: child,
        );

  static double of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()
            ?.notifier
            ?.value ??
        0.0;
  }
}
