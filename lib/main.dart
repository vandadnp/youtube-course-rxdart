import 'package:flutter/material.dart';
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

enum TypeOfThing { animal, person }

@immutable
class Thing {
  final TypeOfThing type;
  final String name;

  const Thing({
    required this.type,
    required this.name,
  });
}

@immutable
class Bloc {
  final Sink<TypeOfThing?> setTypeOfThing; // write-only
  final Stream<TypeOfThing?> currentTypeOfThing; // read-only
  final Stream<Iterable<Thing>> things;

  const Bloc._({
    required this.setTypeOfThing,
    required this.currentTypeOfThing,
    required this.things,
  });

  void dispose() {
    setTypeOfThing.close();
  }

  factory Bloc({
    required Iterable<Thing> things,
  }) {
    final typeOfThingSubject = BehaviorSubject<TypeOfThing?>();

    final filteredThings = typeOfThingSubject
        .debounceTime(const Duration(milliseconds: 300))
        .map<Iterable<Thing>>((typeOfThing) {
      if (typeOfThing != null) {
        return things.where((thing) => thing.type == typeOfThing);
      } else {
        return things;
      }
    }).startWith(things);

    return Bloc._(
      setTypeOfThing: typeOfThingSubject.sink,
      currentTypeOfThing: typeOfThingSubject.stream,
      things: filteredThings,
    );
  }
}

const things = [
  Thing(name: 'Foo', type: TypeOfThing.person),
  Thing(name: 'Bar', type: TypeOfThing.person),
  Thing(name: 'Baz', type: TypeOfThing.person),
  Thing(name: 'Bunz', type: TypeOfThing.animal),
  Thing(name: 'Fluffers', type: TypeOfThing.animal),
  Thing(name: 'Woofz', type: TypeOfThing.animal),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Bloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Bloc(
      things: things,
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FilterChip with RxDart'),
      ),
      body: Column(
        children: [
          StreamBuilder<TypeOfThing?>(
            stream: bloc.currentTypeOfThing,
            builder: (context, snapshot) {
              final selectedTypeOfThing = snapshot.data;
              return Wrap(
                children: TypeOfThing.values.map((typeOfThing) {
                  return FilterChip(
                    selectedColor: Colors.blueAccent[100],
                    onSelected: (selected) {
                      final type = selected ? typeOfThing : null;
                      bloc.setTypeOfThing.add(type);
                    },
                    label: Text(typeOfThing.name),
                    selected: selectedTypeOfThing == typeOfThing,
                  );
                }).toList(),
              );
            },
          ),
          Expanded(
            child: StreamBuilder<Iterable<Thing>>(
              stream: bloc.things,
              builder: (context, snapshot) {
                final things = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: things.length,
                  itemBuilder: (context, index) {
                    final thing = things.elementAt(index);
                    return ListTile(
                      title: Text(thing.name),
                      subtitle: Text(thing.type.name),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
