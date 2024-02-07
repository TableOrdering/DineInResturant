import 'package:dine_in_resturant/bloc/auth/authentication_bloc.dart';
import 'package:dine_in_resturant/core/routes/routes.dart';
import 'package:dine_in_resturant/views/screens/auth/auth_page.dart';
import 'package:dine_in_resturant/views/screens/category/create_category.dart';
import 'package:dine_in_resturant/views/screens/items/create_items.dart';
import 'package:dine_in_resturant/views/widgets/bottom_navigation.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter({required this.authenticationBloc}) {
    _router = GoRouter(
      initialLocation: kHomeRoute,
      refreshListenable: authenticationBloc,
      redirect: (context, state) {
        final isSignInRoute = state.matchedLocation.startsWith(kAuthRoute);
        final isAuthenticated =
            authenticationBloc.state == AuthenticationState.authenticated;
        if (!isAuthenticated && !isSignInRoute) {
          return kAuthRoute;
        } else if (isAuthenticated && isSignInRoute) {
          return kHomeRoute;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: kHomeRoute,
          name: kHomeRoute,
          // builder: (context, state) => const CreateItemsPage(),
          builder: (context, state) => const BottomNavigationPage(),
          routes: [
            GoRoute(
              path: kCreateCategoryRoute,
              name: kCreateCategoryRoute,
              builder: (context, state) => const CreateCategoryPage(),
            ),
            GoRoute(
              path: kCreateItemsRoute,
              name: kCreateItemsRoute,
              builder: (context, state) => const CreateItemsPage(),
            ),
          ],
        ),
        GoRoute(
          path: kAuthRoute,
          name: kAuthRoute,
          builder: (context, state) => const AuthPage(),
        )
      ],
    );
  }

  late final GoRouter _router;
  GoRouter get router => _router;
  final AuthenticationBloc authenticationBloc;
}
