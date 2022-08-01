import 'package:ecommerce_app/navigation/paths.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/controller/view_model.dart';

import 'package:ecommerce_app/view/pages/pages.dart';


class SubRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  @override
  GlobalKey<NavigatorState> navigatorKey;

  SubRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: (Route<dynamic> route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        if (route.settings.name == Paths.productDetailsPagePath) {
          context.read<NavigationManager>().setIsProductDetailsPage(false);
        }
        if (route.settings.name == Paths.myCartPagePath) {
          context.read<NavigationManager>().setIsMyCartPage(false);
        }
        return true;
      },
      pages: [
       mainPage(),

        if (context.watch<NavigationManager>().isProductDetailsPage)
          productDetailsPage(),
        if (context.watch<NavigationManager>().isMyCartPage)
          myCartPage(),
      ],
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}

  MaterialPage mainPage() {
    return MaterialPage(
      name: Paths.mainPagePath,
      key: ValueKey(Paths.mainPagePath),
      child: const MainPage(),
    );
  }

  MaterialPage productDetailsPage() {
    return MaterialPage(
      name: Paths.productDetailsPagePath,
      key: ValueKey(Paths.productDetailsPagePath),
      child: const DetailsPage(),
    );
  }

  MaterialPage myCartPage() {
    return MaterialPage(
      name: Paths.myCartPagePath,
      key: ValueKey(Paths.myCartPagePath),
      child: const MyCartPage(),
    );
  }

}
