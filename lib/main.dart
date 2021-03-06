import 'package:alkhaleej/screens/home_page.dart';
import 'package:alkhaleej/src/rss.dart';
//import 'package:alkhaleej/src/onesignal_all_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const Home());
//void main() => runApp(MyApp());

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Arabic RTL config START ss
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar", "AR"), //  RTL locales
      ],
      locale: const Locale("ar", "AR"),
      // Arabic RTL config END
      debugShowCheckedModeBanner: false,
      title: 'صحيفة الخليج',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const HomePage(),
      home: RSSDemo(),
    );
  }
}
