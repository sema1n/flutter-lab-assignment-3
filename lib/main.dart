import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/repositories/album_repository.dart';
import 'logic/album_bloc.dart';

import 'ui/screens/onboarding_screen.dart';
import 'ui/screens/album_list_screen.dart';
import 'ui/screens/album_detail_screen.dart';

import 'ui/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

void main() {
  final repo = AlbumRepository(client: http.Client());
  runApp(MyApp(repository: repo));
}

class MyApp extends StatelessWidget {
  final AlbumRepository repository;

  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/albums',
          builder: (context, state) => AlbumListScreen(),
        ),
        GoRoute(
          path: '/detail',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;
            if (data == null) {
              return const Scaffold(
                body: Center(child: Text('No album data provided')),
              );
            }
            return AlbumDetailScreen(data: data);
          },
        ),
      ],
    );

    return BlocProvider(
      create: (_) => AlbumCubit(repository)..fetchAlbums(),
      child: MaterialApp.router(
        title: 'Album Viewer',
        theme: AppTheme.light,
        routerConfig: router,
        debugShowCheckedModeBanner: false, // optional: hides debug banner
      ),
    );
  }
}
