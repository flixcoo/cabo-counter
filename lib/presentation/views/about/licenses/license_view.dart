import 'package:cabo_counter/core/adaptive_page_route.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/tiles/license_tile.dart';
import 'package:cabo_counter/presentation/views/about/licenses/license_detail_view.dart';
import 'package:cabo_counter/presentation/views/about/licenses/oss_licenses.dart';
import 'package:flutter/material.dart';

/// Displays a list of open source software licenses used in the app.
///
/// Users can tap on a license to view its details on a separate screen.
///
/// See also:
///   - [LicenseDetailView] for displaying license details.
///   - [ossLicenses] for the list of licenses.
class LicenseView extends StatelessWidget {
  const LicenseView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.licenses)),
      body: SafeArea(
        bottom: false,
        child: ListView.builder(
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: allDependencies.length,
          itemBuilder: (_, index) {
            return LicenseTile(
              package: allDependencies[index],
              onTap: () {
                Navigator.push(
                  context,
                  adaptivePageRoute(
                    builder: (_) =>
                        LicenseDetailView(package: allDependencies[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
