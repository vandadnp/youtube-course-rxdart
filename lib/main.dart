import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // create our behavior subject every time widget is rebuilt
    final subject = useMemoized(
      () => BehaviorSubject<String>(),
      [key],
    );

    // dispose of the old subject every time widget is rebuilt
    useEffect(
      () => subject.close,
      [subject],
    );

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
          stream: subject.stream.distinct(),
          initialData: 'Please start typing...',
          builder: (context, snapshot) {
            return Text(snapshot.requireData);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: subject.sink.add,
        ),
      ),
    );
  }
}
