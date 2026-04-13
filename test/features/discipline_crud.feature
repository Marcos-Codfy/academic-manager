Feature: Discipline Management CRUD
  # Funcionalidade: Gerenciamento de Disciplinas CRUD

  Scenario: Create a new discipline successfully
    # Cenário: Criar uma nova disciplina com sucesso
    Given the app is running
    When I enter "Software Quality" into "Title" input field
    And I enter "2026-08-01" into "Start Date" input field
    And I enter "2026-12-15" into "End Date" input field
    And I enter "30" into "Seats" input field
    And I toggle "Summer Course" switch
    And I tap "Save" button
    Then I see "Discipline created successfully" text

  Scenario: Delete an existing discipline
    # Cenário: Deletar uma disciplina existente
    Given the app is running
    # 1. Primeiro nós criamos a disciplina
    When I enter "Software Quality" into title input field
    And I enter "2026-08-01" into Start Date input field
    And I tap the "Salvar" button
    Then I see "Software Quality" text

    # 2. Agora nós a deletamos
    When I tap the delete icon
    Then I do not see "Software Quality" text

  Scenario: Update an existing discipline
    # Cenário: Editar uma disciplina existente
    Given the app is running
    # 1. Primeiro nós criamos a disciplina para poder editar
    When I enter "Software Quality" into title input field
    And I enter "2026-08-01" into Start Date input field
    And I tap the "Salvar" button
    Then I see "Software Quality" text

    # 2. Agora nós clicamos no ícone de edição (que ainda vamos criar na View)
    When I tap the edit icon

    # 3. Alteramos o título para outra coisa
    And I enter "Software Architecture" into title input field
    And I tap the "Salvar" button

    # 4. Verificamos se o novo título aparece e o antigo sumiu
    Then I see "Software Architecture" text
    And I do not see "Software Quality" text