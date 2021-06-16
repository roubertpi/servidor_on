import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../providers/app_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());


class App extends StatelessWidget {

  final AppProvider appProvider = AppProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appProvider),
      ],
      child: MaterialApp(
        title: 'Ping-Ping',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
