import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class AppItem {
  final String name;
  final IconData icon;
  final String packageName;

  AppItem({required this.name, required this.icon, required this.packageName});
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
  final List<AppItem> apps = [
    AppItem(name: 'WhatsApp', icon: Icons.message, packageName: 'com.whatsapp'),
    AppItem(name: 'Facebook', icon: Icons.facebook, packageName: 'com.facebook.katana'),
    AppItem(name: 'Instagram', icon: Icons.camera_alt, packageName: 'com.instagram.android'),
    AppItem(name: 'Twitter', icon: Icons.chat_bubble, packageName: 'com.twitter.android'),
    AppItem(name: 'YouTube', icon: Icons.video_library, packageName: 'com.google.android.youtube'),
    AppItem(name: 'Gmail', icon: Icons.email, packageName: 'com.google.android.gm'),
    AppItem(name: 'Maps', icon: Icons.map, packageName: 'com.google.android.apps.maps'),
    AppItem(name: 'Chrome', icon: Icons.web, packageName: 'com.android.chrome'),
    AppItem(name: 'Spotify', icon: Icons.music_note, packageName: 'com.spotify.music'),
    AppItem(name: 'Netflix', icon: Icons.movie, packageName: 'com.netflix.mediaclient'),
    AppItem(name: 'Amazon', icon: Icons.shopping_cart, packageName: 'in.amazon.mShop.android.shopping'),
    AppItem(name: 'Flipkart', icon: Icons.store, packageName: 'com.flipkart.android'),
    AppItem(name: 'Paytm', icon: Icons.payment, packageName: 'net.one97.paytm'),
    AppItem(name: 'PhonePe', icon: Icons.phone_android, packageName: 'com.phonepe.app'),
    AppItem(name: 'GPay', icon: Icons.credit_card, packageName: 'com.google.android.apps.nbu.paisa.user'),
    AppItem(name: 'Uber', icon: Icons.local_taxi, packageName: 'com.ubercab'),
    AppItem(name: 'Ola', icon: Icons.directions_car, packageName: 'com.olacabs.customer'),
    AppItem(name: 'Zomato', icon: Icons.restaurant, packageName: 'com.application.zomato'),
    AppItem(name: 'Swiggy', icon: Icons.delivery_dining, packageName: 'in.swiggy.android'),
    AppItem(name: 'LinkedIn', icon: Icons.work, packageName: 'com.linkedin.android'),
    // Add 40 more apps
    ...List.generate(40, (index) => AppItem(name: 'App ${index + 21}', icon: Icons.apps, packageName: 'com.example.app${index + 21}')),
  ];

  final List<AppItem> games = [
    AppItem(name: 'Subway Surfers', icon: Icons.gamepad, packageName: 'com.kiloo.subwaysurf'),
    AppItem(name: 'Candy Crush', icon: Icons.gamepad, packageName: 'com.king.candycrushsaga'),
    AppItem(name: 'Temple Run 2', icon: Icons.gamepad, packageName: 'com.imangi.templerun2'),
    AppItem(name: 'PUBG Mobile', icon: Icons.gamepad, packageName: 'com.tencent.ig'),
    AppItem(name: 'Clash of Clans', icon: Icons.gamepad, packageName: 'com.supercell.clashofclans'),
    AppItem(name: 'Ludo King', icon: Icons.gamepad, packageName: 'com.ludoking'),
    AppItem(name: '8 Ball Pool', icon: Icons.gamepad, packageName: 'com.miniclip.eightballpool'),
    AppItem(name: 'Free Fire', icon: Icons.gamepad, packageName: 'com.dts.freefireth'),
    AppItem(name: 'Among Us', icon: Icons.gamepad, packageName: 'com.innersloth.spacemafia'),
    AppItem(name: 'Asphalt 9', icon: Icons.gamepad, packageName: 'com.gameloft.android.ANMP.GloftA9HM'),
    // Add 10 more games
    ...List.generate(10, (index) => AppItem(name: 'Game ${index + 11}', icon: Icons.gamepad, packageName: 'com.example.game${index + 11}')),
  ];

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

  Future<void> _launchApp(BuildContext context, String packageName) async {
    final Uri url = Uri.parse('android-app://$packageName');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $packageName')),
      );
    }
  }

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
        return InkWell(
          onTap: () => _launchApp(context, items[index].packageName),
          borderRadius: BorderRadius.circular(40),
          child: AppIcon(item: items[index]),
        );
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
