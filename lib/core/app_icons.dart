// ignore_for_file: non_constant_identifier_names
import 'dart:io';

import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:material_ui/material_ui.dart';

/// A class that provides platform-specific icons for use in the app.
abstract class AppIcons {
  static IconData get add => Platform.isIOS ? SFIcons.sf_plus : Icons.add;

  static IconData get back =>
      Platform.isIOS ? SFIcons.sf_chevron_left : Icons.chevron_left;

  static const IconData brand_github = IconData(
    0xf09b,
    fontFamily: 'FontAwesomeBrands',
    fontPackage: 'font_awesome_flutter',
  );

  static IconData get cabo_penalty =>
      Platform.isIOS ? SFIcons.sf_bolt_fill : Icons.electric_bolt;

  static IconData get chart =>
      Platform.isIOS ? SFIcons.sf_chart_bar_fill : Icons.bar_chart;

  static IconData get chevron =>
      Platform.isIOS ? SFIcons.sf_chevron_right : Icons.chevron_right;

  static IconData get close => Platform.isIOS ? SFIcons.sf_xmark : Icons.close;

  static IconData get delete =>
      Platform.isIOS ? SFIcons.sf_trash_fill : Icons.delete;

  static IconData get drag =>
      Platform.isIOS ? SFIcons.sf_line_3_horizontal : Icons.menu;

  static IconData get duplicate => Platform.isIOS
      ? SFIcons.sf_document_on_document_fill
      : Icons.copy_all_rounded;

  static IconData get e_mail =>
      Platform.isIOS ? SFIcons.sf_envelope_fill : Icons.mail;

  static IconData get end_game =>
      Platform.isIOS ? SFIcons.sf_flag_pattern_checkered : Icons.flag_outlined;

  static IconData get error => Platform.isIOS
      ? SFIcons.sf_exclamationmark_circle_fill
      : Icons.error_outline_rounded;

  static IconData get export => Platform.isIOS
      ? SFIcons.sf_square_and_arrow_up
      : Icons.file_upload_outlined;

  static IconData get feedback => Platform.isIOS
      ? SFIcons.sf_exclamationmark_bubble_fill
      : Icons.feedback_outlined;

  static IconData get home =>
      Platform.isIOS ? SFIcons.sf_house_fill : Icons.home;

  static IconData get import => Platform.isIOS
      ? SFIcons.sf_square_and_arrow_down
      : Icons.file_download_outlined;

  static IconData get infinity =>
      Platform.isIOS ? SFIcons.sf_infinity : Icons.all_inclusive;

  static IconData get info =>
      Platform.isIOS ? SFIcons.sf_info_circle_fill : Icons.info_outline;

  static IconData get kamikaze =>
      Platform.isIOS ? SFIcons.sf_flame_fill : Icons.local_fire_department;

  static IconData get legal =>
      Platform.isIOS ? SFIcons.sf_building_classical_columns : Icons.directions;

  static IconData get license =>
      Platform.isIOS ? SFIcons.sf_text_document : Icons.description;

  static IconData get minus => Platform.isIOS ? SFIcons.sf_minus : Icons.remove;

  static IconData get mode =>
      Platform.isIOS ? SFIcons.sf_square_stack_3d_up_fill : Icons.mode;

  static IconData get no_games =>
      Platform.isIOS ? SFIcons.sf_tray_fill : Icons.extension;

  static IconData get number =>
      Platform.isIOS ? SFIcons.sf_number_sign : Icons.numbers;

  static IconData get point_limit =>
      Platform.isIOS ? SFIcons.sf_flag_fill : Icons.flag;

  static IconData get privacy =>
      Platform.isIOS ? SFIcons.sf_lock_shield : Icons.shield_rounded;

  static IconData get remove_player =>
      Platform.isIOS ? SFIcons.sf_minus_circle_fill : Icons.remove_circle;

  static IconData get reset =>
      Platform.isIOS ? SFIcons.sf_arrow_counterclockwise : Icons.replay;

  static IconData get settings =>
      Platform.isIOS ? SFIcons.sf_gear : Icons.settings;

  static IconData get share =>
      Platform.isIOS ? SFIcons.sf_square_and_arrow_up_fill : Icons.share;

  static IconData get shuffle_cards =>
      Platform.isIOS ? SFIcons.sf_rectangle_on_rectangle_angled : Icons.casino;

  static IconData get sort =>
      Platform.isIOS ? SFIcons.sf_arrow_up_arrow_down : Icons.swap_vert;

  static IconData get sort_asc =>
      Platform.isIOS ? SFIcons.sf_arrow_up : Icons.arrow_upward;

  static IconData get sort_by_date =>
      Platform.isIOS ? SFIcons.sf_calendar : Icons.calendar_month;

  static IconData get sort_by_name =>
      Platform.isIOS ? SFIcons.sf_textformat : Icons.abc;

  static IconData get sort_desc =>
      Platform.isIOS ? SFIcons.sf_arrow_down : Icons.arrow_downward;

  static IconData get star =>
      Platform.isIOS ? SFIcons.sf_star_fill : Icons.star_rounded;

  static IconData get success => Platform.isIOS
      ? SFIcons.sf_checkmark_circle_fill
      : Icons.check_circle_outline_rounded;

  static IconData get support =>
      Platform.isIOS ? SFIcons.sf_heart : Icons.favorite;

  static IconData get trophy =>
      Platform.isIOS ? SFIcons.sf_trophy_fill : Icons.emoji_events_rounded;

  static IconData get version =>
      Platform.isIOS ? SFIcons.sf_tag_fill : Icons.label;

  static IconData get vibration =>
      Platform.isIOS ? SFIcons.sf_iphone : Icons.phone_android;

  static IconData get visibility_off =>
      Platform.isIOS ? SFIcons.sf_eye_slash_fill : Icons.visibility_off_rounded;

  static IconData get website =>
      Platform.isIOS ? SFIcons.sf_globe_fill : Icons.language;
}
