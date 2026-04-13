# Manager Academic (Web)

Uma aplicação web desenvolvida em Flutter para o gerenciamento de disciplinas oferecidas em uma instituição de ensino. Este projeto foi desenvolvido com foco em Qualidade de Software, aplicando testes orientados a comportamento e esteiras automatizadas.

## Tecnologias e Arquitetura

O projeto utiliza **Flutter (Web)** e **Dart**, organizados sob padrões de projeto para garantir manutenibilidade e separação de responsabilidades:

- **MVVM (Model-View-ViewModel):** Separa a interface gráfica (View) da lógica de negócios e estado (ViewModel).
- **Repository Pattern:** Isola a camada de acesso a dados, permitindo que a aplicação consuma os dados (atualmente em memória para simulação) sem acoplar a interface ao banco de dados.

### Dependências Principais
- `http`: Preparação para consumo futuro de APIs REST.
- `intl`: Formatação de datas.
- `bdd_widget_test`: Framework para escrita e execução de testes baseados em comportamento (BDD).

## Funcionalidades (CRUD)

O sistema permite gerenciar as disciplinas, exigindo obrigatoriamente os seguintes campos:
- Título da disciplina
- Data de início e término
- Número de vagas
- Sinalização se é uma disciplina de verão (Summer Course)

## Qualidade de Software e Testes

A qualidade da aplicação é garantida através da metodologia **BDD (Behavior-Driven Development)**, com cenários descritos em linguagem natural (Gherkin) dentro da pasta `test/features/`.

