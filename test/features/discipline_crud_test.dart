// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_app_is_running.dart';
import './step/i_enter_teste_de_software_as_title.dart';
import './step/i_enter10_as_seats.dart';
import './step/i_toggle_summer_course_to_true.dart';
import './step/i_tap_the_salvar_button.dart';
import './step/i_see_disciplina_criada_com_sucesso_on_the_screen.dart';
import './step/i_see_o_titulo_e_obrigatorio_on_the_screen.dart';

void main() {
  group('''Gerenciamento de Disciplinas (CRUD)''', () {
    testWidgets('''Criar uma nova disciplina''', (tester) async {
      await theAppIsRunning(tester);
      await iEnterTesteDeSoftwareAsTitle(tester);
      await iEnter10AsSeats(tester);
      await iToggleSummerCourseToTrue(tester);
      await iTapTheSalvarButton(tester);
      await iSeeDisciplinaCriadaComSucessoOnTheScreen(tester);
    });
    testWidgets('''Tentar criar disciplina sem título''', (tester) async {
      await theAppIsRunning(tester);
      await iTapTheSalvarButton(tester);
      await iSeeOTituloEObrigatorioOnTheScreen(tester);
    });
  });
}
