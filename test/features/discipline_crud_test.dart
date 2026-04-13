// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_app_is_running.dart';
import './step/i_enter_software_quality_into_title_input_field.dart';
import './step/i_enter20260801_into_start_date_input_field.dart';
import './step/i_enter20261215_into_end_date_input_field.dart';
import './step/i_enter30_into_seats_input_field.dart';
import './step/i_toggle_summer_course_switch.dart';
import './step/i_tap_save_button.dart';
import './step/i_see_discipline_created_successfully_text.dart';
import './step/i_tap_the_salvar_button.dart';
import './step/i_see_software_quality_text.dart';
import './step/i_tap_the_delete_icon.dart';
import './step/i_do_not_see_software_quality_text.dart';
import './step/i_tap_the_edit_icon.dart';
import './step/i_enter_software_architecture_into_title_input_field.dart';
import './step/i_see_software_architecture_text.dart';

void main() {
  group('''Discipline Management CRUD''', () {
    testWidgets('''Create a new discipline successfully''', (tester) async {
      await theAppIsRunning(tester);
      await iEnterSoftwareQualityIntoTitleInputField(tester);
      await iEnter20260801IntoStartDateInputField(tester);
      await iEnter20261215IntoEndDateInputField(tester);
      await iEnter30IntoSeatsInputField(tester);
      await iToggleSummerCourseSwitch(tester);
      await iTapSaveButton(tester);
      await iSeeDisciplineCreatedSuccessfullyText(tester);
    });
    testWidgets('''Delete an existing discipline''', (tester) async {
      await theAppIsRunning(tester);
      await iEnterSoftwareQualityIntoTitleInputField(tester);
      await iEnter20260801IntoStartDateInputField(tester);
      await iTapTheSalvarButton(tester);
      await iSeeSoftwareQualityText(tester);
      await iTapTheDeleteIcon(tester);
      await iDoNotSeeSoftwareQualityText(tester);
    });
    testWidgets('''Update an existing discipline''', (tester) async {
      await theAppIsRunning(tester);
      await iEnterSoftwareQualityIntoTitleInputField(tester);
      await iEnter20260801IntoStartDateInputField(tester);
      await iTapTheSalvarButton(tester);
      await iSeeSoftwareQualityText(tester);
      await iTapTheEditIcon(tester);
      await iEnterSoftwareArchitectureIntoTitleInputField(tester);
      await iTapTheSalvarButton(tester);
      await iSeeSoftwareArchitectureText(tester);
      await iDoNotSeeSoftwareQualityText(tester);
    });
  });
}
