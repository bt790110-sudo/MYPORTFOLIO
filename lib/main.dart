import 'dart:ui';
import 'dart:async'; // ✅ ADD
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/theme/theme_provider.dart';
import 'core/routes/app_router.dart';
import 'widgets/custom_cursor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔴 Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.exceptionAsString());
    debugPrintStack(stackTrace: details.stack);
  };

  // 🔴 Platform / Web / async errors
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('PLATFORM ERROR: $error');
    debugPrintStack(stackTrace: stack);
    return true;
  };

  // 🔥 MAJOR FIX: Catch ALL async + runtime crashes (Web safe)
  runZonedGuarded(() {
    GoogleFonts.config.allowRuntimeFetching = false;

    runApp(const MyApp());
  }, (error, stack) {
    debugPrint('ZONE ERROR: $error');
    debugPrintStack(stackTrace: stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),

      // Small Performance Fix
      child: Selector<ThemeProvider, ThemeMode>(
        selector: (_, provider) => provider.themeMode,

        builder: (context, themeMode, _) {
          return MaterialApp.router(
            title: 'Bikram Thapa | Premium Flutter Developer',
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,

            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: const Color(0xFF6366F1),
              scaffoldBackgroundColor: Colors.white,
              fontFamily: GoogleFonts.inter().fontFamily,
              useMaterial3: true,
            ),

            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: const Color(0xFF818CF8),
              scaffoldBackgroundColor: const Color(0xFF0A0A0A),
              fontFamily: GoogleFonts.inter().fontFamily,
              useMaterial3: true,
            ),

            routerConfig: AppRouter.router,

            builder: (context, child) {
              assert(child != null, 'Router child is null');

              return ResponsiveBreakpoints.builder(
                child: CustomCursor(
                  child: child ?? const SizedBox(),
                ),
                breakpoints: const [
                  Breakpoint(start: 0, end: 450, name: MOBILE),
                  Breakpoint(start: 451, end: 800, name: TABLET),
                  Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                ],
              );
            },
          );
        },
      ),
    );
  }
}