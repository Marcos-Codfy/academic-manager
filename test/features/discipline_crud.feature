Feature: Gerenciamento de Disciplinas (CRUD)

  Scenario: Criar uma nova disciplina
    Given the app is running
    When I enter "Teste de Software" as title
    And I enter "10" as seats
    And I toggle summer course to true
    And I tap the "Salvar" button
    Then I see "Disciplina criada com sucesso" on the screen

  Scenario: Tentar criar disciplina sem título
    Given the app is running
    When I tap the "Salvar" button
    Then I see "O título é obrigatório" on the screen