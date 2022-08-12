import 'package:ecommerce_app/controller/view_model.dart';
import 'package:ecommerce_app/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/navigation/sub_router_delegate.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelManager>(
          create: (context) => ModelManager(),
        ),
        ChangeNotifierProvider<NavigationManager>(
          create: (context) => NavigationManager(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final SubRouterDelegate _subRouterDelegate;

  @override
  void initState() {
    _subRouterDelegate = SubRouterDelegate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Palette.orange,
        ),
        // textTheme: ,
        fontFamily: 'Mark-Pro',
      ),
      home: Router(
        routerDelegate: _subRouterDelegate,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
