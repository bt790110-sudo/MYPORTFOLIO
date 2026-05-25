import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/theme_provider.dart';
import 'core/routes/app_router.dart';
import 'widgets/custom_cursor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Bypasses local asset constraints securely on GitHub Pages
  GoogleFonts.config.allowRuntimeFetching = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp.router(
            title: 'Bikram Thapa | Premium Flutter Developer',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            
            // LIGHT THEME
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: const Color(0xFF6366F1),
              scaffoldBackgroundColor: Colors.white,
              useMaterial3: true,
              // FIX: Safely applies the Inter text theme without freezing the app
              textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
            ),
            
            // DARK THEME
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: const Color(0xFF818CF8),
              scaffoldBackgroundColor: const Color(0xFF0A0A0A),
              useMaterial3: true,
              // FIX: Safely applies the Inter text theme without freezing the app
              textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
            ),
            
            routerConfig: AppRouter.router,
            builder: (context, child) {
              if (child == null) return const SizedBox.shrink();
              return ResponsiveBreakpoints.builder(
                child: CustomCursor(child: child),
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                ],
              );
            },
          );
        },
      ),
    );
  }
}