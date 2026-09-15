import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/presentation/views/about/about_view.dart';
import 'package:cabo_counter/presentation/views/home/home_view.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';

/// TabBar for navigating between the main menu and about section.
///
/// [CustomNavigationBar] is a [StatefulWidget] that provides a tabbed interface for navigating
/// between the main menu and the about section of the app. It uses a
/// - Home (MainMenuView)
/// - About (AboutView)
///
/// The tab labels are provided via localization.
class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: tabIndex == 0 ? const HomeView() : const AboutView(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        fixedColor: CustomTheme.primaryColor,
        backgroundColor: CustomTheme.navBarBackgroundColor,
        enableFeedback: false,
        currentIndex: tabIndex,
        onTap: (int newIndex) {
          VibrationService.selectionClick();
          setState(() => tabIndex = newIndex);
        },
        items: [
          BottomNavigationBarItem(
            icon: AppIcon(AppIcons.home, size: 24),
            label: loc.home,
          ),
          BottomNavigationBarItem(
            icon: AppIcon(AppIcons.info, size: 24),
            label: loc.about,
          ),
        ],
      ),
    );
  }
}
