import 'package:flutter/widgets.dart';

class FlowerNavigator extends Navigator {
  FlowerNavigator.onGenerateRoute({
    GlobalKey<NavigatorState>? key,
    bool Function(Route<dynamic>, dynamic)? onPopPage,
    required List<FatimaPage> pages,
    List<NavigatorObserver>? observers,
    bool reportsRouteUpdateToEngine = false,
    TransitionDelegate? transitionDelegate,
    String? initialRoute,
    String? restorationScopeId,
  }) : super(
          //keys should be optional
          key: key,
          initialRoute: initialRoute,
          onPopPage: onPopPage ??
              (route, result) {
                final didPop = route.didPop(result);
                if (!didPop) {
                  return false;
                }
                return true;
              },
          onGenerateRoute: (settings) {
            final selectedPageList =
                pages.where((element) => element.name == settings.name);
            if (selectedPageList.isNotEmpty) {
              final selectedPage = selectedPageList.first;
              return FatimaPageRoute(
                page: selectedPage.page,
                settings: settings,
              );
            }
            return null;
          },
          reportsRouteUpdateToEngine: reportsRouteUpdateToEngine,
          restorationScopeId: restorationScopeId,
          pages: pages,
          observers: [
            // GetObserver(),
            ...?observers,
          ],
          transitionDelegate:
              transitionDelegate ?? const DefaultTransitionDelegate<dynamic>(),
        );

  FlowerNavigator({
    GlobalKey<NavigatorState>? key,
    bool Function(Route<dynamic>, dynamic)? onPopPage,
    required List<FatimaPage> pages,
    List<NavigatorObserver>? observers,
    bool reportsRouteUpdateToEngine = false,
    TransitionDelegate? transitionDelegate,
    String? initialRoute,
    String? restorationScopeId,
  }) : super(
          //keys should be optional
          key: key,
          initialRoute: initialRoute,
          onPopPage: onPopPage ??
              (route, result) {
                final didPop = route.didPop(result);
                if (!didPop) {
                  return false;
                }
                return true;
              },
          reportsRouteUpdateToEngine: reportsRouteUpdateToEngine,
          restorationScopeId: restorationScopeId,
          pages: pages,
          observers: [
            // GetObserver(null, Get.routing),
            HeroController(),
            ...?observers,
          ],
          transitionDelegate:
              transitionDelegate ?? const DefaultTransitionDelegate<dynamic>(),
        );
}
