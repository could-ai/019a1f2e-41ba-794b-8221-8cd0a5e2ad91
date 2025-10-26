import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class AppItem {
  final String name;
  final IconData icon;

  AppItem({required this.name, required this.icon});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IndiaHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<AppItem> apps = List.generate(
    60,
    (index) => AppItem(name: 'App ${index + 1}', icon: Icons.apps),
  );

  final List<AppItem> games = List.generate(
    20,
    (index) => AppItem(name: 'Game ${index + 1}', icon: Icons.gamepad),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('IndiaHub'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.apps), text: 'Apps'),
              Tab(icon: Icon(Icons.gamepad), text: 'Games'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AppGridView(items: apps),
            AppGridView(items: games),
          ],
        ),
      ),
    );
  }
}

class AppGridView extends StatelessWidget {
  final List<AppItem> items;

  const AppGridView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return AppIcon(item: items[index]);
      },
    );
  }
}

class AppIcon extends StatelessWidget {
  final AppItem item;

  const AppIcon({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            item.icon,
            size: 30,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.name,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
