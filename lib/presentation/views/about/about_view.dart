import 'package:cabo_counter/core/adaptive_page_route.dart';
import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/animated_icon_button.dart';
import 'package:cabo_counter/presentation/components/widgets/grouped_lists/custom_form_row.dart';
import 'package:cabo_counter/presentation/components/widgets/grouped_lists/custom_form_section.dart';
import 'package:cabo_counter/presentation/views/about/licenses/license_view.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// A view that displays information about the app, including its name, version,
/// privacy policy, imprint, and licenses.
class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(loc.about)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      loc.app_name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Version
                  Text(
                    '${loc.version} ${VersionService.getVersionNumber()}',
                    style: TextStyle(fontSize: 15, color: Colors.grey[300]),
                  ),
                ],
              ),
              // App name

              // Logo
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/app-logo.jpg'),
                ),
              ),

              CustomFormSection(
                rows: [
                  // Support me
                  CustomFormRow(
                    prefixText: loc.support_me,
                    prefixIcon: AppIcons.support,
                    onPressed: () =>
                        launchUrl(Uri.parse(Constants.DONATE_LINK)),
                  ),

                  // Licenses
                  CustomFormRow(
                    prefixText: loc.licenses,
                    prefixIcon: AppIcons.license,
                    onPressed: () => Navigator.push(
                      context,
                      adaptivePageRoute(builder: (_) => const LicenseView()),
                    ),
                  ),

                  // Privacy policy
                  CustomFormRow(
                    prefixText: loc.privacy_policy,
                    prefixIcon: AppIcons.privacy,
                    onPressed: () => launchUrl(
                      Uri.parse(
                        '${Constants.PRIVACY_POLICY_LINK}?lang=${loc.localeName}',
                      ),
                    ),
                  ),

                  // Legal notice
                  CustomFormRow(
                    prefixText: loc.legal_notice,
                    prefixIcon: AppIcons.legal,
                    onPressed: () => launchUrl(
                      Uri.parse(
                        '${Constants.LEGAL_LINK}?lang=${loc.localeName}',
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                spacing: 10,
                children: [
                  const Text(
                    '\u00A9 Felix Kirchner',
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Website
                      AnimatedIconButton(
                        onPressed: () =>
                            launchUrl(Uri.parse(Constants.WEBSITE_LINK)),
                        icon: AppIcons.website,
                        color: CustomTheme.primaryColor,
                      ),

                      // Contact
                      AnimatedIconButton(
                        onPressed: () => launchUrl(
                          Uri.parse('mailto:${Constants.CONTACT_EMAIL}'),
                        ),
                        icon: AppIcons.e_mail,
                        color: CustomTheme.primaryColor,
                      ),

                      // Github
                      AnimatedIconButton(
                        onPressed: () =>
                            launchUrl(Uri.parse(Constants.GITHUB_LINK)),
                        icon: AppIcons.brand_github,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
