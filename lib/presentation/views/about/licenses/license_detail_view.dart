import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart'
    show AppLocalizations;
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/presentation/views/about/licenses/oss_licenses.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LicenseDetailView extends StatelessWidget {
  /// Displays the details of a specific open source software license.
  ///
  /// - [package]: The license to display.
  const LicenseDetailView({super.key, required this.package});

  final Package package;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.license_details)),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 10,
          bottom: MediaQuery.paddingOf(context).bottom,
        ),
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CustomTheme.primaryColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AppIcon(
                  AppIcons.license,
                  color: CustomTheme.primaryColor,
                  size: 38,
                ),
              ),

              // Name
              Column(
                spacing: 2,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        package.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Version
                  if (package.version != null)
                    Container(
                      decoration: BoxDecoration(
                        color: CustomTheme.mainElementColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        '${loc.version} ${package.version!}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  Column(
                    children: [
                      // Authors
                      if (package.authors.isNotEmpty)
                        SelectableText(
                          package.authors.join(', '),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),

                      if (package.homepage != null)
                        GestureDetector(
                          onTap: () => launchUrl(Uri.parse(package.homepage!)),
                          child: Text(
                            package.homepage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              color: CustomTheme.primaryColor,
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ],
              ),

              // Description & license
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: CustomTheme.buttonBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 10,
                  children: [
                    // Description
                    if (package.description.isNotEmpty) ...[
                      Text(package.description, textAlign: TextAlign.center),

                      const Divider(
                        radius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ],

                    // License text
                    Text(package.license ?? loc.no_license_text),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
