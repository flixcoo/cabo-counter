import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/custom_navigation_bar.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure the app runs in portrait mode only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Initialize services
  await ConfigService.initConfig();
  await VersionService.init();
  await ConfigService.setMigrationDone(false);
  runApp(
    Provider<AppDatabase>(
      create: (context) => AppDatabase(),
      child: const CaboCounterApp(),
      dispose: (context, databaseInstance) => databaseInstance.close(),
    ),
  );
}

class CaboCounterApp extends StatefulWidget {
  const CaboCounterApp({super.key});

  @override
  State<StatefulWidget> createState() => _CaboCounterAppState();
}

class _CaboCounterAppState extends State<CaboCounterApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).app_name,
      debugShowCheckedModeBanner: false,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
        ...GlobalCupertinoLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        for (final loc in supportedLocales) {
          if (loc.languageCode == locale?.languageCode) {
            return loc;
          }
        }
        return supportedLocales.first;
      },

      // Theme
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,

        // colors
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        primaryColor: CustomTheme.primaryColor,
        scaffoldBackgroundColor: CustomTheme.backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: CustomTheme.primaryColor,
          brightness: Brightness.dark,
          primary: CustomTheme.primaryColor,
          onPrimary: CustomTheme.textColor,
          surface: CustomTheme.backgroundColor,
          onSurface: CustomTheme.textColor,
        ),

        // Component themes
        iconButtonTheme: CustomTheme.iconButtonTheme,
        actionIconTheme: CustomTheme.actionIconTheme,
        textButtonTheme: CustomTheme.textButtonTheme,
        textTheme: CustomTheme.textTheme,
        appBarTheme: CustomTheme.appBarTheme,

        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          },
        ),
      ),
      home: const CustomNavigationBar(),
    );
  }
}
