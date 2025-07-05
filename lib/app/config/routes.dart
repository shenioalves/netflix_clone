import 'package:go_router/go_router.dart';
import 'package:netflix_clone/app/features/login/view/login_view.dart';
import 'package:netflix_clone/app/features/started/view/started_view.dart';
import 'package:netflix_clone/app/features/splash/splash_view.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashView()),
      GoRoute(path: '/started', builder: (_, __) => StartedView()),
      GoRoute(path: '/login', builder: (_, __) => const LoginView()),
    ],
  );
}
