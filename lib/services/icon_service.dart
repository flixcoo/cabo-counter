// ignore_for_file: non_constant_identifier_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';

/// A service that provides platform-specific icons for use in the app.
abstract class IconService {
  static IconData get add => Platform.isIOS ? SFIcons.sf_plus : Icons.add;

  static IconData get add_player =>
      Platform.isIOS ? SFIcons.sf_plus_circle_fill : Icons.add_circle;

  static IconData get cabo_penalty =>
      Platform.isIOS ? SFIcons.sf_bolt : Icons.electric_bolt;

  static IconData get chart =>
      Platform.isIOS ? SFIcons.sf_chart_bar_fill : Icons.bar_chart;

  static IconData get chevron =>
      Platform.isIOS ? SFIcons.sf_chevron_right : Icons.chevron_right;

  static IconData get back =>
      Platform.isIOS ? SFIcons.sf_chevron_left : Icons.chevron_left;

  static IconData get close => Platform.isIOS ? SFIcons.sf_xmark : Icons.close;

  static IconData get delete =>
      Platform.isIOS ? SFIcons.sf_trash : Icons.delete;

  static IconData get drag =>
      Platform.isIOS ? SFIcons.sf_line_3_horizontal : Icons.menu;

  static IconData get e_mail =>
      Platform.isIOS ? SFIcons.sf_envelope : Icons.mail;

  static IconData get export => Platform.isIOS
      ? SFIcons.sf_square_and_arrow_up
      : Icons.file_upload_outlined;

  static IconData get home =>
      Platform.isIOS ? SFIcons.sf_house_fill : Icons.home;

  static IconData get import => Platform.isIOS
      ? SFIcons.sf_square_and_arrow_down
      : Icons.file_download_outlined;

  static IconData get info =>
      Platform.isIOS ? SFIcons.sf_info_circle : Icons.info_outline;

  static IconData get infinity =>
      Platform.isIOS ? SFIcons.sf_infinity : Icons.all_inclusive;

  static IconData get kamikaze =>
      Platform.isIOS ? SFIcons.sf_flame_fill : Icons.local_fire_department;

  static IconData get license =>
      Platform.isIOS ? SFIcons.sf_text_document : Icons.description;

  static IconData get locked => Platform.isIOS ? SFIcons.sf_lock : Icons.lock;

  static IconData get minus => Platform.isIOS ? SFIcons.sf_minus : Icons.remove;

  static IconData get mode =>
      Platform.isIOS ? SFIcons.sf_square_stack_3d_up : Icons.mode;

  static IconData get number =>
      Platform.isIOS ? SFIcons.sf_number : Icons.numbers;

  static IconData get no_games =>
      Platform.isIOS ? SFIcons.sf_tray : Icons.extension;

  static IconData get players =>
      Platform.isIOS ? SFIcons.sf_person_2_fill : Icons.group;

  static IconData get point_limit =>
      Platform.isIOS ? SFIcons.sf_flag : Icons.flag;

  static IconData get remove_player =>
      Platform.isIOS ? SFIcons.sf_minus_circle_fill : Icons.remove_circle;

  static IconData get reset =>
      Platform.isIOS ? SFIcons.sf_arrow_counterclockwise : Icons.replay;

  static IconData get rounds => Platform.isIOS
      ? SFIcons.sf_arrow_trianglehead_2_clockwise_rotate_90_circle
      : Icons.autorenew;

  static IconData get share =>
      Platform.isIOS ? SFIcons.sf_square_and_arrow_up : Icons.share;

  static IconData get sort_by_date =>
      Platform.isIOS ? SFIcons.sf_calendar : Icons.calendar_month;

  static IconData get sort_by_name =>
      Platform.isIOS ? SFIcons.sf_textformat : Icons.abc;

  static IconData get sort_asc =>
      Platform.isIOS ? SFIcons.sf_arrow_up : Icons.arrow_upward;

  static IconData get sort_desc =>
      Platform.isIOS ? SFIcons.sf_arrow_down : Icons.arrow_downward;

  static IconData get sort =>
      Platform.isIOS ? SFIcons.sf_arrow_up_arrow_down : Icons.swap_vert;

  static IconData get settings =>
      Platform.isIOS ? SFIcons.sf_gear : Icons.settings;

  static IconData get version => Platform.isIOS ? SFIcons.sf_tag : Icons.label;

  static IconData get visibility_off =>
      Platform.isIOS ? SFIcons.sf_eye_slash_fill : Icons.visibility_off_rounded;

  static IconData get shuffle_cards =>
      Platform.isIOS ? SFIcons.sf_rectangle_on_rectangle_angled : Icons.casino;

  static IconData get website =>
      Platform.isIOS ? SFIcons.sf_globe : Icons.language;

  static const IconData brand_github = IconData(
    0xf09b,
    fontFamily: 'FontAwesomeBrands',
    fontPackage: 'font_awesome_flutter',
  );

  static IconData get vibration =>
      Platform.isIOS ? SFIcons.sf_iphone : Icons.phone_android;

  static IconData get support =>
      Platform.isIOS ? SFIcons.sf_heart : Icons.favorite;

  static IconData get privacy =>
      Platform.isIOS ? SFIcons.sf_lock_shield : Icons.shield_rounded;

  static IconData get legal =>
      Platform.isIOS ? SFIcons.sf_building_columns : Icons.directions;

  static IconData get brush =>
      Platform.isIOS ? SFIcons.sf_paintbrush_fill : Icons.brush;

  static IconData get haptic_feedback => Platform.isIOS
      ? SFIcons.sf_iphone_gen1_radiowaves_left_and_right
      : Icons.vibration;

  static IconData get player =>
      Platform.isIOS ? SFIcons.sf_person_fill : Icons.person;

  static IconData get tool =>
      Platform.isIOS ? SFIcons.sf_wrench_adjustable_fill : Icons.build;
}

/// Wrapper for Icons / SFIcons
class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.size, this.color});

  final IconData icon;
  final double? size;
  final Color? color;

  bool get _isSFSymbol => icon.fontPackage == 'flutter_sficon';

  @override
  Widget build(BuildContext context) {
    if (_isSFSymbol) {
      final iconTheme = IconTheme.of(context);
      return SFIcon(
        icon,
        fontSize: size ?? iconTheme.size ?? 24,
        color: color ?? iconTheme.color,
      );
    }
    return Icon(icon, size: size, color: color);
  }
}
